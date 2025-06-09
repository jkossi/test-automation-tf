# Events Platform IaC

## Automation

### Quick Start

#### Prerequisites

Docker should be installed and running in order to run the IaC automation.

#### Steps

First, run the setup script to generate your config folder in `~/.events-platform-iac` and a default `config` file.

```
./setup.sh
```

Then build the automation container image.

```
docker build . -t events-platform-iac
```

Next, run the container and pass any configuration values needed. A file containing external configuration values
is expected in `/iac-config.yml`, which is created via volume attachment.

```
docker run -e DEPLOY_TARGET=development -e WORKSPACE=example -a stdout -a stderr events-platform-iac \
    -v ${HOME}/.events-platform-iac/config:/iac-config.yml \
    ansible-playbook -i 'localhost,' ansible/main.yml 
```

There is a `run.sh` script which combines these commands for convenience:

```
# Run with default args 
./run.sh

# Specify an environment/workspace
./run.sh -e development -w example -v /my/config/path/config.yml
```
