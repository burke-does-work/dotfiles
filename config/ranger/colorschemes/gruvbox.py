from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *


class Gruvbox(ColorScheme):
    # xterm-256 approximations of Gruvbox Dark Hard palette
    # bg_hard=235  fg=223  red=167  green=142  yellow=214
    # blue=109     aqua=108 orange=208 gray=243  bg1=237

    progress_bar_color = 208  # orange

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            fg = 223    # fg (cream)
            attr = normal
            if context.empty or context.error:
                fg = 208
                attr = bold
            if context.border:
                attr = normal
                fg = 243
            if context.media:
                if context.image:
                    fg = 108  # aqua
                else:
                    fg = 214  # yellow
            if context.container:
                attr = bold
                fg = 208  # orange
            if context.directory:
                attr = bold
                fg = 109  # blue
            elif context.executable and not \
                    any((context.media, context.container,
                         context.fifo, context.socket)):
                attr = bold
                fg = 142  # green
            if context.socket:
                attr = bold
                fg = 214
            if context.fifo or context.device:
                fg = 214
                if context.device:
                    attr = bold
            if context.link:
                fg = 214 if context.good else 208
            if context.tag_marker and not context.selected:
                attr = bold
                if fg in (208, 142):
                    fg = 223
                else:
                    fg = 208
            if not context.selected and (context.cut or context.copied):
                attr = bold
                fg = 243
                bg = 235
            if context.main_column:
                if context.marked:
                    attr |= bold | reverse
                    fg = 214
            if context.badinfo:
                if attr & reverse:
                    bg = 208
                else:
                    fg = 208
            # Apply selected last so it is never overwritten by file-type attrs
            if context.selected:
                attr |= reverse
            # Mute inactive pane so the active pane is immediately obvious
            if context.inactive_pane:
                fg = 243
                attr = normal

        elif context.in_titlebar:
            # Give the whole titlebar a real background so it does not blend
            # into the shell background.
            bg = 237   # gruvbox bg1
            attr = normal

            if context.hostname:
                fg = 208 if context.bad else 142
                attr = bold
            elif context.directory:
                fg = 109
            elif context.tab:
                if context.good:
                    # Active tab: strong yellow block
                    fg = 235
                    bg = 214
                    attr = bold
                else:
                    # Inactive tabs: muted but still visibly tab-shaped
                    fg = 243
                    bg = 239
                    attr = normal
            elif context.link:
                fg = 108

        elif context.in_statusbar:
            if context.permissions:
                if context.good:
                    fg = 108
                elif context.bad:
                    fg = 208
            if context.marked:
                attr = bold | reverse
                fg = 214
            if context.message:
                if context.bad:
                    attr = bold
                    fg = 208
            if context.loaded:
                bg = self.progress_bar_color
            if context.vcsinfo:
                fg = 109
                attr = normal
            if context.vcscommit:
                fg = 214
                attr = normal
            if context.vcsdate:
                fg = 108
                attr = normal

        if context.text:
            if context.highlight:
                attr = reverse

        if context.in_taskview:
            if context.title:
                fg = 109
            if context.selected:
                attr = reverse
            if context.loaded:
                if context.selected:
                    fg = self.progress_bar_color
                else:
                    bg = self.progress_bar_color

        if context.vcsfile and not context.selected:
            attr = normal
            if context.vcsinfo:
                fg = 109
            if context.vcscommit:
                fg = 214
            if context.vcsstaged:
                fg = 142
            if context.vcsunstaged:
                fg = 208
            if context.vcsdirty:
                fg = 208
            if context.vcsuntracked:
                fg = 208
            if context.vcsconflict:
                fg = 208
                attr = bold

        return fg, bg, attr
