#!/bin/bash



# Step 2: Install soga
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/soga/master/install.sh)
if [ $? -eq 0 ]; then
    echo "soga安装成功"
else
    echo "安装出错"
    exit 1
fi

# Step 3: Update soga.conf
cat << EOF > /etc/soga/soga.conf
# 日志配置
log_level=info
log_file=

# 基础配置
type=v2board
server_type=ss

#对接配置
api=webapi
node_id=363
webapi_url=https://ultlink.com
webapi_key=CaonIMADasdasEasdasz
soga_key=472UG4EmXEPCcNGqc2KdEz7KkwnykUrr

# DNS配置
dns_strategy=ipv4_first
default_dns=1.1.1.1

# 中转相关配置
proxy_protocol=true
EOF

# Step 4: Record node_id
read -p "请输入node_id: " node_id
sed -i "s/node_id=363/node_id=$node_id/" /etc/soga/soga.conf

# Step 5: Start soga
soga config node_id=$node_id
soga restart
