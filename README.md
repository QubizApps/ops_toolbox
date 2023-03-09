# OPS Toolbox
Tooling for OPS

## How to use

docker-compose.yml:
```yaml
services:
  ops:
    image: qubiz/ops-toolbox:latest
    command: [ "tail", "-f", "/dev/null" ]
    container_name: ops
    env_file:
      - .env
    volumes:
      - .:/app:rw,cached
```

.env:
```
### AWS ###
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
```
