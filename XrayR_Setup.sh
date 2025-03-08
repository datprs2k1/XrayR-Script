#!/bin/bash

clear

# Hỏi thông tin chung
echo ""
read -p "  Nhập domain web (không cần https://): " api_host
[ -z "${api_host}" ] && { echo "  Domain không được để trống."; exit 1; }
read -p "  Nhập key của web: " api_key
[ -z "${api_key}" ] && { echo "  Key không được để trống."; exit 1; }

# Hỏi số lượng node
read -p "  Nhập số lượng node cần cài (1 hoặc 2, mặc định 1): " node_count
echo "--------------------------------"
[ -z "${node_count}" ] && node_count="1"
if [[ "$node_count" != "1" && "$node_count" != "2" ]]; then
  echo "  Số lượng node không hợp lệ, chỉ chấp nhận 1 hoặc 2."
  exit 1
fi

# Lấy địa chỉ IP của VPS
vps_ip=$(hostname -I | awk '{print $1}')

# Khai báo mảng lưu thông tin node
declare -A nodes

# Hỏi thông tin cho từng node
for i in $(seq 1 $node_count); do
  echo ""
  echo "  [1] Vmess"
  echo "  [2] Vless"
  echo "  [3] Trojan"
  read -p "  Chọn loại Node: " NodeType
  if [ "$NodeType" == "1" ]; then
      NodeType="V2ray"
      NodeName="Vmess"
      DisableLocalREALITYConfig="false"
      EnableVless="false"
      EnableREALITY="false"
  elif [ "$NodeType" == "2" ]; then
      NodeType="V2ray"
      NodeName="Vless"
      DisableLocalREALITYConfig="true"
      EnableVless="true"
      EnableREALITY="true"
  elif [ "$NodeType" == "3" ]; then
      NodeType="Trojan"
      NodeName="Trojan"
      DisableLocalREALITYConfig="false"
      EnableVless="false"
      EnableREALITY="false"
  else
      echo "  Loại Node không hợp lệ, mặc định là Vmess"
      NodeType="V2ray"
      NodeName="Vmess"
      DisableLocalREALITYConfig="false"
      EnableVless="false"
      EnableREALITY="false"
  fi

  read -p "  Nhập ID Node: " node_id
  [ -z "${node_id}" ] && { echo "  ID Node không được để trống."; exit 1; }

  nodes[$i,NodeType]=$NodeType
  nodes[$i,NodeName]=$NodeName
  nodes[$i,node_id]=$node_id
  nodes[$i,CertDomain]=$vps_ip
  nodes[$i,EnableVless]=$EnableVless
  nodes[$i,DisableLocalREALITYConfig]=$DisableLocalREALITYConfig
  nodes[$i,EnableREALITY]=$EnableREALITY
done

# Hiển thị thông tin đã nhập và yêu cầu xác nhận
clear
echo ""
echo "  Thông tin cấu hình"
echo "--------------------------------"
echo "  Domain web: https://${api_host}"
echo "  Key web: ${api_key}"
echo "  Địa chỉ Node: ${nodes[$i,CertDomain]}"
for i in $(seq 1 $node_count); do
  echo ""
  echo "  Loại Node: ${nodes[$i,NodeName]}"
  echo "  ID Node: ${nodes[$i,node_id]}"
done
echo "--------------------------------"
read -p "  Bạn có muốn tiếp tục cài đặt không? (y/n, mặc định y): " confirm
confirm=${confirm:-y}
if [ "$confirm" != "y" ]; then
  echo "  Hủy bỏ cài đặt."
  exit 0
fi

# Hàm cài đặt
install_node() {
  local i=$1
  local NodeType=${nodes[$i,NodeType]}
  local node_id=${nodes[$i,node_id]}
  local CertDomain=${nodes[$i,CertDomain]}
  local EnableVless=${nodes[$i,EnableVless]}
  local DisableLocalREALITYConfig=${nodes[$i,DisableLocalREALITYConfig]}
  local EnableREALITY=${nodes[$i,EnableREALITY]}

  cat >>/etc/XrayR/config.yml<<EOF
  -
    Nodes:
  - PanelType: "NewV2board" # Panel type: AikoPanel
    ApiConfig:
      ApiHost: '${api_host}'
      ApiKey: '${api_key}'
      NodeID: ${node_id}
      NodeType: ${NodeType} # Node type: V2ray, Shadowsocks, Trojan
      Timeout: 30 # Timeout for the api request
      EnableVless: ${EnableVless} # Enable Vless for V2ray Type
      RuleListPath: # /etc/Aiko-Server/rulelist Path to local rulelist file
    ControllerConfig:
      EnableProxyProtocol: false
      DisableLocalREALITYConfig: ${DisableLocalREALITYConfig}
      EnableREALITY: ${EnableREALITY}
      REALITYConfigs:
        Show: true
      CertConfig:
        CertMode: file # Option about how to get certificate: none, file, http, dns. Choose "none" will forcedly disable the tls config.
        CertDomain: "${CertDomain}" # Domain to cert
        CertFile: /etc/XrayR/443.crt # Provided if the CertMode is file
        KeyFile: /etc/XrayR/443.key
        Provider: alidns # DNS cert provider, Get the full support list here: https://go-acme.github.io/lego/dns/
        Email: test@me.com
        DNSEnv: # DNS ENV option used by DNS provider
          ALICLOUD_ACCESS_KEY: aaa
          ALICLOUD_SECRET_KEY: bbb
EOF
}

# Cài đặt XrayR và cấu hình
bash <(curl -Ls https://raw.githubusercontent.com/datprs2k1/XrayR-Script/main/install.sh)
openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes -out /etc/XrayR/443.crt -keyout /etc/XrayR/443.key -subj "/C=JP/ST=Tokyo/L=Chiyoda-ku/O=Google Trust Services LLC/CN=google.com"
cd /etc/XrayR
cat >config.yml <<EOF
Log:
  Level: none # Log level: none, error, warning, info, debug 
  AccessPath: # /etc/XrayR/access.Log
  ErrorPath: # /etc/XrayR/error.log
DnsConfigPath: # /etc/XrayR/dns.json # Path to dns config, check https://xtls.github.io/config/dns.html for help
RouteConfigPath: # /etc/XrayR/route.json # Path to route config, check https://xtls.github.io/config/routing.html for help
OutboundConfigPath: # /etc/XrayR/custom_outbound.json # Path to custom outbound config, check https://xtls.github.io/config/outbound.html for help
ConnectionConfig:
  Handshake: 4 # Handshake time limit, Second
  ConnIdle: 30 # Connection idle time limit, Second
  UplinkOnly: 2 # Time limit when the connection downstream is closed, Second
  DownlinkOnly: 4 # Time limit when the connection is closed after the uplink is closed, Second
  BufferSize: 64 # The internal cache size of each connection, kB  
Nodes:
EOF

# Gọi hàm cài đặt cho từng node
for i in $(seq 1 $node_count); do
  install_node $i
done

cd /root
clear
echo ""
xrayr restart
