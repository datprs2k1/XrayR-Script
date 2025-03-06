<p align="center"><img src="https://avatars.githubusercontent.com/u/91626055?v=4" width="128" /></p>

<div align="center">

# XrayR

XrayR Projects

</div>

# Description of XrayR

XrayR Supports Only AikoPanel

An Xray-based back-end framework, supporting V2ay, Trojan, Shadowsocks protocols, extremely easily extensible and supporting multi-panel connection。

If you like this project, you can click the star + view in the upper right corner to track the progress of this project.

## Disclaimer

This project is for my personal learning, development and maintenance only, I do not guarantee the availability and I am not responsible for any consequences resulting from using this software.

## Featured

- Open source `This version depends on the happy mood`
- Supports multiple protocols V2ray, Trojan, Shadowsocks.
- Supports new features like Vless and XTLS.
- Supports single connection to multiple boards and nodes without rebooting.
- Online IP support is limited
- Support node port level, user level rate limit.
- Simple and clear configuration.
- Modify the configuration to automatically restart the instance.
- Easy to compile and upgrade, can quickly update core version, support new Xray-core features.
- Support UDP and many other functions

## Featured

| Featured                                   | VMess | Trojan | Shadowsocks | VLESS |
| ------------------------------------------ | ----- | ------ | ----------- | ----- |
| Get button info                            | √     | √      | √           | √     |
| Get user information                       | √     | √      | √           | √     |
| User traffic statistics                    | √     | √      | √           | √     |
| Report server information                  | √     | √      | √           | √     |
| Automatic registration of TLS certificates | √     | √      | √           | √     |
| auto-renew tls certificate                 | √     | √      | √           | √     |
| Number of people online                    | √     | √      | √           | √     |
| Online User Restrictions                   | √     | √      | √           | √     |
| Audit rules                                | √     | √      | √           | √     |
| Node port speed limit                      | √     | √      | √           | √     |
| User speed limit                           | √     | √      | √           | √     |
| Custom DNS                                 | √     | √      | √           | √     |

## User interface support

| Panel     | VMess | Trojan | Shadowsocks | VLESS |
| --------- | ----- | ------ | ----------- | ----- |
| AikoPanel | √     | √      | √           | √     |

## Command support

- [x] `xrayr` - XrayR command
- [x] `xrayr x25519` - X25519 certificate management (Vless-Reality)

**Note: The command is not supported in the docker version and if you have Command New for it pls commit it**

## Software installation - release

```
wget --no-check-certificate -O XrayR.sh https://raw.githubusercontent.com/datprs2k1/XrayR-Script/master/install.sh && bash XrayR.sh
```
