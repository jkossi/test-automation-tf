mkdir -p ~/.events-platform-iac
touch ~/.events-platform-iac/config

# ensure  ~/.aws/cli/cache is populated if the user is logged in to the `aws` cli
aws configure export-credentials --profile staging > /dev/null

if [ -d ~/.aws/cli/cache ]; then
  credentialsPath=`ls -Art ~/.aws/cli/cache | tail -n 1`
  AWS_ACCESS_KEY=`jq -r '.Credentials.AccessKeyId' ~/.aws/cli/cache/${credentialsPath}`
  AWS_SECRET_ACCESS_KEY=`jq -r '.Credentials.SecretAccessKey' ~/.aws/cli/cache/${credentialsPath}`
  yq -i ".aws.access_key = \"${AWS_ACCESS_KEY}\", .aws.secret_access_key = \"${AWS_SECRET_ACCESS_KEY}\"" ~/.events-platform-iac/config
fi
