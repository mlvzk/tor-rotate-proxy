# tor-rotate-proxy

# ENVS

Change `RANGE_FROM` and `RANGE_TO` in `Dockerfile` if you want to increase/decrease the number of Tor proxies.
Default is 4100 to 4120, so 20 proxies.

# Build

```sh
docker build . -t tor-rotate-proxy
```

# Run

```sh
docker run -d -p 9100:9100 tor-rotate-proxy
```

# Use

```sh
curl --socks5 localhost:9100 api.ipify.org
```