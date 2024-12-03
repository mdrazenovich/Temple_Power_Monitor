# 1970-01-02 01:02:35 by RouterOS 7.15.3
# software id = SM63-G547
#
# model = RB952Ui-5ac2nD
# serial number = C5600EC9FDC2
/interface bridge
add name=bridge1
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n country="united states3" \
    disabled=no frequency=auto mode=ap-bridge ssid=temple wps-mode=disabled
set [ find default-name=wlan2 ] band=5ghz-a/n/ac country="united states3" \
    disabled=no frequency=auto mode=ap-bridge ssid=temple5 wps-mode=disabled
/interface lte apn
set [ find default=yes ] ip-type=ipv4 use-network-apn=no
/interface wireless security-profiles
set [ find default=yes ] authentication-types=wpa2-psk mode=dynamic-keys \
    supplicant-identity=MikroTik wpa2-pre-shared-key=1234567890
/ip pool
add name=dhcp_pool0 ranges=10.0.1.100-10.0.1.250
/ip dhcp-server
add address-pool=dhcp_pool0 interface=bridge1 lease-time=10m name=dhcp1
/interface bridge port
add bridge=bridge1 interface=ether1
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=ether3
add bridge=bridge1 interface=ether4
add bridge=bridge1 interface=ether5
add bridge=bridge1 interface=wlan1
add bridge=bridge1 interface=wlan2
/ip firewall connection tracking
set udp-timeout=10s
/ip neighbor discovery-settings
set discover-interface-list=!dynamic
/ip settings
set max-neighbor-entries=8192
/ipv6 settings
set disable-ipv6=yes max-neighbor-entries=8192
/interface ovpn-server server
set auth=sha1,md5
/ip address
add address=10.0.1.1/16 interface=bridge1 network=10.0.0.0
/ip dhcp-server network
add address=10.0.0.0/16 gateway=10.0.1.1
/ip hotspot profile
set [ find default=yes ] html-directory=hotspot
/routing bfd configuration
add disabled=no interfaces=all min-rx=200ms min-tx=200ms multiplier=5
/system note
set show-at-login=no
