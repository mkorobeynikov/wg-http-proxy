# WireGuard HTTP Proxy

A Docker-based solution for routing HTTP traffic through a WireGuard VPN tunnel.

## Overview

This project combines WireGuard VPN and Tinyproxy to create an HTTP proxy server that routes all traffic through a WireGuard VPN connection. This allows you to:

- Access region-restricted content by routing traffic through a VPN
- Add an extra layer of privacy to your HTTP requests
- Share a single VPN connection with multiple devices through the HTTP proxy

## How It Works

The Docker container:
1. Establishes a WireGuard VPN connection using your provided configuration
2. Starts Tinyproxy on port 8888 to provide HTTP proxy services
3. Routes all proxy traffic through the WireGuard tunnel

## Requirements

- Docker
- A valid WireGuard configuration file (`wg0.conf`)

## Setup

1. Place your WireGuard configuration file in the project directory as `wg0.conf`
   ```
   cp path/to/your/wireguard-config.conf wg0.conf
   ```
   
   Note: `wg0.conf` is included in `.gitignore` to prevent accidentally committing your private VPN credentials.

2. Build the Docker image:
   ```
   docker build -t wireguard-http-proxy .
   ```

3. Run the container:
   ```
   docker run -d --name wireguard-proxy --cap-add=NET_ADMIN --sysctl net.ipv4.conf.all.src_valid_mark=1 -p 8888:8888 wireguard-http-proxy
   ```

## Usage

Once running, configure your applications to use the HTTP proxy:

- Host: your Docker host IP (or `localhost` if running locally)
- Port: 8888
- Protocol: HTTP

## Configuration

- **WireGuard**: Edit `wg0.conf` to use your VPN provider's settings
- **Tinyproxy**: Modify `tinyproxy.conf` to change proxy settings:
  - Currently configured to listen on port 8888 and accept connections from any IP (0.0.0.0/0)
  - Connection timeout set to 600 seconds

## Security Considerations

This proxy is configured to accept connections from any IP address. For production use, consider restricting access by modifying the `Allow` directive in `tinyproxy.conf`.

## License

[License information]

## Troubleshooting

- Check container logs: `docker logs wireguard-proxy`
- Verify your WireGuard configuration is valid
- Ensure required ports are not blocked by firewalls

