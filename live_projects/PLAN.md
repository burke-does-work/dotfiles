# Plan: Keep the Mac Awake With the Lid Closed

Status: installed and committed. Every gate test and validation check passed.

---

## Intent

Make the Mac stay awake with the lid closed while it's on the charger, so Claude Code remote control and other programs stay connected. On battery, the Mac behaves like a standard Mac.

The power source is the only control. Unplugging before packing the Mac turns stay-awake off, so the Mac can't keep running in a bag by accident.

---

## Target behavior

- Plugged in - stay-awake on. Closing the lid leaves the Mac awake.
- Unplugged - stay-awake off. Closing the lid sleeps the Mac.
- No other state and no hotkey.
- Master switch - `awake disable` returns the Mac to standard behavior on any power source, across restarts, until `awake enable`. Rarely used.

| Situation                         | Result                                         |
| --------------------------------- | ---------------------------------------------- |
| Plugged in, lid closed            | Stays awake                                    |
| Plugged in, sleep wanted          | Not possible without unplugging                |
| Unplugged, lid open               | Standard Mac, idle sleep on its timer          |
| Unplugged, lid closed             | Sleeps                                         |
| Unplugged while the lid is closed | Script runs `pmset sleepnow`, sleeps in 5 s    |
| Low battery                       | No special handling, because stay-awake is off |
| Restart                           | The job sets the right state at login          |
| Overnight on the charger          | Never sleeps                                   |
| After `awake disable`             | Standard Mac on any power source               |

---

## Approach

A script reads the power source every 5 seconds and sets `disablesleep` to match. A `launchd` job keeps the script running.

| Piece         | Purpose                                                                  | Location                     |
| ------------- | ------------------------------------------------------------------------ | ---------------------------- |
| `awake`       | Script with `apply`, `watch`, `enable`, `disable`, and `status`          | `config/awake/awake`         |
| `launchd` job | Runs `awake watch` at login, restarts it if it dies, label `local.awake` | `config/awake/awake.plist`   |
| Admin rule    | Passwordless `pmset -a disablesleep 0` and `1` only                      | `config/awake/awake.sudoers` |
| Setup script  | Validates and installs the rule, links files, loads job                  | `setup/setup_awake.sh`       |

A name check found no existing `awake` command on this Mac.

### Script behavior

- `apply` reads `pmset -g batt` and runs `sudo -n pmset -a disablesleep 1` on AC power or `0` on battery.
- `apply` only writes when the current value differs, so repeat runs change nothing.
- Unreadable power source output sets `0`. Off is the safe direction here, because it restores standard sleep.
- `watch` runs `apply` every 5 seconds. If it dies, `launchd` restarts it.
- Before turning stay-awake off, `apply` waits 3 seconds and rechecks, so a brief loss of power doesn't end a lid-closed session.
- After turning stay-awake off with the lid closed, `apply` runs `pmset sleepnow`, in case the Mac doesn't sleep by itself.
- `sudo -n` runs with no input attached, so a missing rule fails fast instead of waiting for a password.
- Output goes to `~/Library/Logs/awake.log`.
- `disable` runs `launchctl bootout` and `launchctl disable gui/<uid>/local.awake`, then sets `disablesleep 0`. `launchd` keeps the disabled state across restarts.
- `enable` runs `launchctl enable` and `launchctl bootstrap`, and the job then sets the state to match the power source.
- `status` shows whether the job is enabled and running, the power source, and `SleepDisabled`.

### Master switch choice

- Chosen - `launchctl disable`. It's `launchd`'s own switch, the install never changes, and nothing runs while off. This Mac's per-login domain already keeps a disabled-jobs list, which `launchctl print-disabled` shows.
- Rejected - removing the job's link. It changes the installed setup, and the setup script has to avoid recreating it.
- Rejected - an off-switch file. It adds saved state, and the job keeps running.
- Rejected - the `Disabled` key in the job file. It changes a tracked file, and `launchctl` keeps its own override record.

### Install

- Link `awake` into `~/.local/bin`.
- Link the job into `~/Library/LaunchAgents`, or copy it if `launchd` rejects the link at login.
- Install the rule to `/etc/sudoers.d/awake`, owned by root with mode 0440, only after `visudo -c` passes.
- Load the job with `launchctl bootstrap`, unless `launchctl print-disabled` shows it disabled.
- The human runs the setup script with `sudo`, because it writes outside the home directory.

### Changes to the working tree

The earlier build left uncommitted changes, and this design removes all of them.

- Remove the `f12` rule from `config/karabiner/karabiner.json`.
- Remove the `stay-awake-on`, `stay-awake-off`, and `stay-awake-status` aliases. `awake status` replaces the status alias, and the job would overwrite manual changes.

### Alternatives considered

- `f12` with automatic re-arm - one-press sleep on the charger, at the cost of a waiting process, a battery job, and timing edge cases. Kept as the fallback if this design fails the gate.
- Integrated `launchd` design - one decision point, but roughly twice the code, two state files, and checks every 15 seconds.
- Sleepless - the same `disablesleep` mechanism with no sleep action. Its admin rule and `sudo -n` pattern carry over.
- Amphetamine - closed source and last updated in 2023.
- Clamshell mode - requires an external display and peripherals.

---

## Gate: test after install

The human runs these after the setup script installs the job, because the tests are physical.

| Test                   | Action                                                                 | Pass                                                           |
| ---------------------- | ---------------------------------------------------------------------- | -------------------------------------------------------------- |
| Plug in                | Plug in with the lid open, then run `awake status`                     | `SleepDisabled` reads 1 within about 5 seconds                 |
| Lid closed on charger  | Close the lid for 15 minutes on the charger                            | Remote control responds from phone                             |
| Power blip             | With the lid closed on the charger, unplug and replug within 2 seconds | Remote control still responds                                  |
| Unplug with lid closed | With the lid closed on the charger, unplug and leave it                | Power log shows "Entering Sleep state" within about 10 seconds |

### Results

Run on 2026-11-02 and 2026-11-03.

| Test                   | Result | Evidence                                                                         |
| ---------------------- | ------ | -------------------------------------------------------------------------------- |
| Install                | Pass   | Setup ran cleanly, job running, rule allows only the two commands                |
| Unplugged at install   | Pass   | Log shows `disablesleep 0` 4 seconds after the job started on battery            |
| Plug in                | Pass   | Log shows `disablesleep 1` 2 seconds after the switch to AC                      |
| Lid closed on charger  | Pass   | Human confirmed, and no sleep entries in 13 hours on AC                          |
| Power blip             | Pass   | Human confirmed, no log line and no sleep entries                                |
| Unplug with lid closed | Pass   | "Software Sleep" 5 seconds after the log showed `disablesleep 0` and lid closed  |

- Restart on the charger - pass. The Mac booted at 18:43:50, and the log shows "watch started" at 18:46:20 after login, so `launchd` loads the job from its link.
- Watcher restart - pass. Ending process 800 brought up process 4506 within 1 second, and the log shows a new "watch started" at 18:54:36.
- `awake disable` - pass. `launchctl print-disabled` lists `local.awake` as disabled, and `SleepDisabled` reads 0 on AC.
- Disabled through a restart - pass. After the 18:56:44 boot, `local.awake` stayed disabled, no new "watch started" appeared, and `SleepDisabled` read 0 on AC.
- `awake enable` - pass. The job started at 18:58:18 and set `disablesleep 1` one second later.
- Power-on to battery - no gap. `powerd` starts only after the FileVault unlock, which also logs in, and the watcher turned stay-awake off 9 seconds later. The setting survived the full shutdown.
- Logout to battery - gap confirmed. After logging out on AC and unplugging at the login window, the lid stayed closed about 2 minutes with no sleep entries. The watcher turned stay-awake off only at the next login.
- `disablesleep` survived the restart. The log has no new set line after login, because the setting already read 1. This contradicts the Sleepless author's report that it resets on reboot.
- The power blip left no log line, so the 3-second recheck never ran. A blip under 2 seconds usually falls between 5-second polls, and the watcher never sees it. A blip that lands on a poll is still untested.
- The setup script needs a terminal, because `sudo` can't ask for a password through the `!` prefix in Claude Code.

### Triggers to reevaluate

Any failed test stops relying on the setup. The human and the AI system reevaluate the plan.

| Result                               | Likely change                                       |
| ------------------------------------ | --------------------------------------------------- |
| Plug in doesn't set `SleepDisabled`  | Check the admin rule and `~/Library/Logs/awake.log` |
| Lid closed on charger sleeps         | Reconsider the approach                             |
| A power blip ends the session        | Lengthen the 3-second recheck                       |
| Unplug with lid closed doesn't sleep | Check the log for the `sleepnow` step               |

---

## Earlier gate results

Run on 2026-11-02 against the first design, which used `f12` with stay-awake always on.

| Test                       | Result | Evidence                                                            |
| -------------------------- | ------ | ------------------------------------------------------------------- |
| Sleep while setting is off | Pass   | `f12` logged "Entering Sleep state", then "Wake from"               |
| Sleep while setting is on  | Fail   | `pmset sleepnow` returned error `0xe00002e2`, and `f12` did nothing |
| Lid closed on battery      | Pass   | About 18 minutes, no sleep entries, remote control responded        |
| Power change to charger    | Pass   | Switched to AC with the lid closed, no sleep entries                |
| Power change to battery    | Pass   | Switched to battery with the lid closed, no sleep entries           |
| Lid reopened               | Pass   | Programs unchanged, no sleep entries                                |

- The display still turned off about 5 minutes after the lid closed, so the display timer keeps working.
- The failed test ended the first design, because no sleep command works while `disablesleep` is on.

---

## Slice: build

Status: done. Committed with the work log entry. `live_projects/` stays uncommitted, matching the repo's history.

- Write the script, job, rule, and setup script - done.
- Apply the working tree changes above - done.
- The human runs the setup script - done.

Commit message:

```text
Build: Keep the Mac awake with the lid closed on the charger

- awake - add a watcher that ties disablesleep to the power source
- awake - add enable, disable, and status commands
- launchd - run the watcher at login and restart it if it dies
- sudoers - allow only the two disablesleep commands without a password
- setup - add an installer that validates the rule before installing
```

---

## Validation

- Run the checks declared in the README:
  - `npx prettier --check .`
  - `npx markdownlint-cli2`
- Run `zsh -n` or `bash -n` on the script and setup script.
- Confirm `plutil -lint` passes on the job file.
- Confirm `visudo -c` passes on the rule.
- Confirm the rule allows only the two `disablesleep` commands, and other `sudo` commands still ask for a password.
- The human confirms each flow:
  - Plugging in sets `SleepDisabled` to 1 within a few seconds.
  - Unplugging sets it to 0 within a few seconds.
  - Closing the lid on the charger leaves the Mac awake.
  - Closing the lid on battery sleeps the Mac.
  - After a restart, the job is loaded and the state matches the power source.
  - After the human ends the watcher process, `launchd` restarts it.
  - `awake disable` shows the job as disabled in `launchctl print-disabled`, and `SleepDisabled` reads 0.
  - After `awake disable` and a restart, the job isn't running and `SleepDisabled` reads 0.
  - `awake enable` starts the job, and the state matches the power source.

---

## Risks

- Unsafe failure direction - if the watcher stops while plugged in, stay-awake stays on after unplugging, and the Mac could run in a bag. `KeepAlive` restarts reduce this.
- Undocumented setting - this Mac's `pmset` manual omits `disablesleep`, so a macOS update could change it.
- Undocumented output - the `pmset -g batt` format isn't documented. Unreadable output fails safe to off.
- No sleep on the charger - the Mac never sleeps while plugged in, including overnight.
- Wi-Fi - one Sleepless user reports a lid-closed Mac that dropped Wi-Fi after a router outage and never rejoined until the lid opened. The tests so far haven't hit this.
- Admin rule - anything running as the user can toggle `disablesleep`, but nothing else.
- After logout - `disablesleep` persists, and the job stops at logout. Logging out on the charger and then unplugging leaves stay-awake on at the login window, so closing the lid doesn't sleep the Mac. Tested and confirmed. After a power-on, FileVault holds the Mac before `powerd` starts, so that path has no gap.

---

## Docs requiring direction

These writes need human direction, and this plan's approval doesn't cover them.

- `docs/DESIGN_macos.md` - add this setup. The uncommitted rename of this file belongs to separate work, so this update waits until that work settles.
- `docs/DESIGN_macos.md` - states that battery sleep takes 30 minutes, but this Mac has `sleep 1`. One of them is wrong.
- `README.md` - still links to the doc names from before the rename.
- `live_projects/WORKING.md` - the low-battery item no longer applies, because stay-awake is always off on battery.

---

## Decisions during implementation

Record any decision here that changes this plan.

- Karabiner replaces Raycast - the human chose `f12` in Karabiner, because it catches the key ahead of apps and keeps the setting in the repo.
- Build before gate - the human directed implementation before the first gate ran. Nothing got committed.
- First design ended - the gate showed no sleep command works while `disablesleep` is on.
- Charger-only design - the human directed this plan to follow the plugged-in-only alternative. It drops the hotkey and the always-on state.
- Master switch - the human added `enable` and `disable` for rare use, through `launchctl disable`.
- Rename - the human renamed `stay-awake` to `awake` for faster typing.
- Build before gate - the human directed implementation before the charger-only gate ran. Nothing gets committed until it passes.
- Polling replaces `pslog` - `pmset -g pslog` output may be buffered when piped, which a terminal test wouldn't reveal, and its format is undocumented. A 5-second poll avoids both and needs no gate test.
- Blip guard and lid sleep built in - two gate triggers had cheap fixes, so the script includes them now. The 3-second recheck covers brief power loss, and `pmset sleepnow` covers a lid-closed Mac that doesn't sleep by itself. The gate tests still apply.
- Commit before gate - the human directed the commit after the plug-in test, with the lid-closed tests still open. A failed test now means a follow-up change, not a held commit.
- Logout gap accepted - the human never logs out, and uses only lid close, restart, and shutdown. All three are covered, so the watcher stays a login job.
- Wi-Fi rejoin ignored - the human directed no further attention to it.

---

## Knowledge notes

- macOS sleep isn't instant. `pmset sleepnow` turns the display off first, and the Mac enters sleep a few seconds later.
- Any key press or trackpad touch in that gap cancels sleep. The power log then shows only "Display is turned off" and "Display is turned on".
- At display off, `powerd` holds an assertion named `com.apple.powermanagement.darkwakelinger` for about 5 seconds. Its purpose is inferred from the name, since Apple doesn't document it. Observed on macOS 26.5.1 on Apple Silicon.
- A dark screen doesn't prove sleep. A real sleep leaves two power log entries: "Entering Sleep state due to 'Software Sleep'" and a later "Wake from".
- This command shows the latest pair:

  ```bash
  pmset -g log | grep -E 'Entering Sleep state|Wake from' | tail -2
  ```

- A broader search for `Sleep` or `Wake` also matches driver timing lines such as "Kernel Client Acks", which mention both words without marking a sleep.
- `pmset sleepnow` doesn't need `sudo`. A Karabiner `shell_command` can run it directly.
- `pmset -a disablesleep 1` blocks every sleep request, including `pmset sleepnow`, which fails with error `0xe00002e2`. A sleep action has to turn the setting off first.
- `SleepDisabled` is system-wide. It appears under "System-wide power settings" in `pmset -g` rather than per power source, so `pmset -c` can't limit it to the charger.
- `pmset -a disablesleep 1` survives a restart. Observed on macOS 26.5.1 on Apple Silicon, against a third-party report that it resets.
- With `disablesleep` on, a MacBook stays awake with the lid closed on battery and through power source changes. The display still turns off on its normal timer.
