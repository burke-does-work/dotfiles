# Slate X (GL-AXT1800) — Documented Config

## Static IP Assignments

| Device         | IP            | MAC               |
| -------------- | ------------- | ----------------- |
| maodou-mac     | 192.168.8.224 | FC:B2:14:30:48:22 |
| USW-Lite-8-PoE | 192.168.8.156 | 28:70:4E:CB:76:29 |
| pickle-pi      | 192.168.8.154 | D8:3A:DD:18:08:09 |
| Ubiquiti AP    | 192.168.8.161 | 28:70:4E:55:9A:AC |
| maodou-pi      | 192.168.8.232 | 88:A2:9E:73:D7:A4 |
| maodou-pi-wifi | 192.168.8.233 | 88:A2:9E:73:D7:A5 |

`maodou-pi` and `maodou-pi-wifi` are sequential MACs — ethernet and Wi-Fi interfaces on the same device.

## Wi-Fi

- SSID: `pickle-palace`
- Password: known

## DHCP Range

Not manually configured — GL.iNet default. All devices have static assignments so the pool range is not critical to match on the Slate 7.
