terraform {
  backend "s3" {
    # Pass these values in via --backend-config CLI args
    bucket  = ""
    key     = ""
    region  = ""
    profile = "" # Sign in a profile via OIDC or AWS CLI
  }

  required_providers {
    rudderstack = {
      source  = "rudderlabs/rudderstack"
      version = "~> 3.0.5"
    }
  }
  required_version = "~> 1.6.6"
}

provider "rudderstack" {
  api_url      = "https://api.rudderstack.com/v2"
  access_token = "" # pass this in via the `RUDDERSTACK_ACCESS_TOKEN` env variable
}
