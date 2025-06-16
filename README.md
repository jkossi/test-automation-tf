# Events Platform IaC

## Quick Start

### Prerequisites

Docker should be installed and running in order to run the IaC automation.

#### Local Credential Setup

* Doppler: Create a personal token and add it to your `~/.events-platform-iac/config` under the `doppler_api_token` attribute
* AWS: Authenticate with AWS under the `aws-staging-developer` role under `ezCater Staging` via the AWS CLI: `aws sso login --profile staging`
  * If there are issues with Netskope interfering with SSL verification during `aws` login, run through the steps found in: https://ezcater.atlassian.net/wiki/spaces/IA/pages/5129142301/Netskope+Certificates+and+CLI+Tools 
  
### Steps

Assuming all prerequisites are satisfied, you can execute the IaC automation by calling the `run.sh` script:

```
# Run with default args 
./run.sh

# Specify an environment/workspace
./run.sh -e development -w example -v /my/config/path/config.yml
```

### Detailed Steps

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
