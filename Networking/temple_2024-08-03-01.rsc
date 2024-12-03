# 1970-01-02 00:27:22 by RouterOS 7.15.3
# software id = 1RRL-ZG7S
#
# model = RB952Ui-5ac2nD
# serial number = C5600E260687
/interface bridge
add name=bridge1
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa2-psk mode=dynamic-keys name=Sparkle \
    supplicant-identity=MikroTik wpa2-pre-shared-key=ponypony
add authentication-types=wpa2-psk mode=dynamic-keys name=temple \
    supplicant-identity=MikroTik wpa2-pre-shared-key=ponypony
add authentication-types=wpa-psk,wpa2-psk mode=dynamic-keys name=\
    "Ken's iPhone" supplicant-identity="" wpa-pre-shared-key=1234567890 \
    wpa2-pre-shared-key=1234567890
/interface wireless
set [ find default-name=wlan1 ] country="united states3" disabled=no \
    frequency=auto mode=ap-bridge security-profile=temple ssid=templet \
    wps-mode=disabled
set [ find default-name=wlan2 ] band=5ghz-a/n/ac country="united states3" \
    disabled=no frequency=auto mode=ap-bridge security-profile=temple ssid=\
    temple5t wps-mode=disabled
/ip pool
add name=dhcp_pool0 ranges=10.0.0.100-10.0.0.250
/ip dhcp-server
add address-pool=dhcp_pool0 interface=bridge1 lease-time=10m name=dhcp1
/interface bridge port
add bridge=bridge1 interface=*A
add bridge=bridge1 interface=*B
add bridge=bridge1 interface=*C
add bridge=bridge1 interface=*D
add bridge=bridge1 interface=all
/ip address
add address=10.0.0.1/16 interface=bridge1 network=10.0.0.0
/ip dhcp-server network
add address=10.0.0.0/16 gateway=10.0.0.1
/ip hotspot profile
set [ find default=yes ] html-directory=hotspot
/system note
set show-at-login=no
