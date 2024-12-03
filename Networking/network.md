# Temple Power Monitoring Network

10.0.0.0/16 Network

## Temple Breaker Network
10.0.0.0/16
10.0.0.100 - 10.0.0.250 DHCP pool

10.0.0.1 Hap AC Lite
10.0.0.2 RPi Breaker Monitoring
10.0.0.3 Nano Loco


## Unicord Network
10.0.1.0/16
10.0.1.100 - 10.0.1.250 DHCP pool

10.0.1.1 Hap AC Lite
10.0.1.2 RPi Solar Monitoring
10.0.1.3 Nano Loco


## Build Camp
10.0.2.1/16


## Nano Loco Config
User/password - admin/Temple12345
Bridge network SSID - TemplePower
Bridge network password - whoiswatchingme
Control Freq Scan List - 5805, 5740
Channel Width 20MHz
SNMP - templepublic
Management radio on startup - Off


## wifi
ssid/WPA2 - temple/1234567890
mode - ap bridge
Band - 2GHz-B/G/N
Channel width - 20MHz
Frequency - auto
Country - United States 3
WPS Mode - Disabled

ssid/WPA2 - temple5/1234567890
mode - ap bridge
Band - 5GHz-A/N/AC
Channel width - 20MHz
Frequency - auto
Country - United States 3
WPS Mode - Disabled


## Todo

1. Set password on Hap AC Lite devices.
2. Set WPA2 passwords for Wifi access.
