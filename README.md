# OPS Toolbox

Typical tooling used for OPS.

## Table of contents

1. [Getting started](#getting-started)
2. [How to use](#how-to-use)
3. [Notes](#notes)

## Getting started

### 1. Package Managers

To manage the required dependencies & tools the simplest method is to leverage the use of package managers.
While optional, it is highly encouraged you use these.

- **Windows**: [https://chocolatey.org/install](https://chocolatey.org/install).
- **MacOS**: [https://docs.brew.sh/Installation](https://docs.brew.sh/Installation).

### 2. Tools

#### Windows

- `choco install git` - [git](https://git-scm.com/) CLI for source control.
- `choco install make` - [GNU make](https://www.gnu.org/software/make/manual/make.html) is a utility tool that enables the creation of workflows (not needed under WSL).
- `choco install docker-desktop` - [Docker Desktop](https://www.docker.com/products/docker-desktop/) & Runtime to build, manage and run containers.

#### MacOS

- `brew install git` - [git](https://git-scm.com/) CLI for source control.
- `brew install make` - [GNU make](https://www.gnu.org/software/make/manual/make.html) is a utility tool that enables the creation of workflows. See our [Makefile](./Makefile).
- `brew install --cask docker` - [Docker Desktop](https://www.docker.com/products/docker-desktop/) & Runtime to build, manage and run containers.

## How to use

Create a basic `docker-compose.yml` file and mount an application's infrastructure into the ops container:

```yaml
services:
  ops:
    image: qubiz/ops-toolbox:latest-alpine-aws
    command: ["tail", "-f", "/dev/null"]
    container_name: ops
    env_file:
      - .env
    volumes:
      - .:/app:rw,cached
```

2. Provide the required credentials to the ops container via a `.env` file:

```
### AWS ###
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
```

## Notes

1. Currently this setup only supports projects built using Terraform on AWS infrastructure.
