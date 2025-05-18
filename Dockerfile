# Базовый образ Ubuntu с поддержкой ARM (Ubuntu официально поддерживает многоплатформенные образы)
FROM ubuntu:22.04

# Устанавливаем необходимые пакеты:
# wireguard-tools для управления WireGuard, iproute2 для команд ip/route, tinyproxy для HTTP-прокси.
RUN apt-get update && apt-get install -y --no-install-recommends \
    wireguard-tools iproute2 tinyproxy openresolv iptables curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Копируем конфигурацию WireGuard (wg0.conf) в образ
COPY wg0.conf /etc/wireguard/wg0.conf

# Копируем конфиг Tinyproxy в образ
COPY tinyproxy.conf /etc/tinyproxy/tinyproxy.conf

# Копируем и задаём права на скрипт ENTRYPOINT
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Открываем порт прокси (HTTP). (Будет проброшен на хост локально)
EXPOSE 8888/tcp

# Запускаем скрипт при старте контейнера
ENTRYPOINT ["/entrypoint.sh"]
