#!/bin/sh
set -e

# 1. Поднимаем WireGuard-интерфейс wg0 с помощью заранее подготовленного конфига
wg-quick up /etc/wireguard/wg0.conf

# 2. Запускаем Tinyproxy в режимеForeground (не daemon, чтобы держать процесс активным)
exec tinyproxy -c /etc/tinyproxy/tinyproxy.conf -d

# 3. Какой-то грязный хак, потому что сразу не хочет работать
# TODO: fixit
wg-quick down /etc/wireguard/wg0.conf
wg-quick up /etc/wireguard/wg0.conf