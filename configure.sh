#!/bin/sh

# Download and install Peppa
mkdir /tmp/Peppa
curl -L -H "Cache-Control: no-cache" -o /tmp/Peppa/Peppa.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip
unzip /tmp/Peppa/Peppa.zip -d /tmp/Peppa
install -m 755 /tmp/Peppa/xray /usr/local/bin/Peppa

# Remove temporary directory
rm -rf /tmp/Peppa

# Peppa new configuration
install -d /usr/local/etc/Peppa
cat << EOF > /usr/local/etc/Peppa/config.json
{
  "log": {
    "loglevel": "none"
  },
  "inbounds": [
    {
      "port": "$PORT",
${CONFIG_JSON}
 }
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

# Run Peppa
/usr/local/bin/Peppa -config /usr/local/etc/Peppa/config.json
