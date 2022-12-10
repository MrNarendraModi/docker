#!/bin/sh

mkdir /tmp/build
curl -L -H "Cache-Control: no-cache" -o /tmp/build/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
unzip /tmp/build/v2ray.zip -d /tmp/build
install -m 755 /tmp/build/v2ray /usr/local/bin/v2ray
install -m 755 /tmp/build/v2ctl /usr/local/bin/v2ctl

rm -rf /tmp/build

install -d /usr/local/etc/v2ray
cat << EOF > /usr/local/etc/v2ray/config.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$ID", 
                        "flow": "xtls-rprx-direct",
                        "level": 0,
                        "email": "test@example.org"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

# Run V2Ray
/usr/local/bin/v2ray -config /usr/local/etc/v2ray/config.json
