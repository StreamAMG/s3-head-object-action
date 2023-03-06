#!/bin/sh

set -e

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  echo "AWS_ACCESS_KEY_ID is not set. Quitting."
  exit 1
fi

if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo "AWS_SECRET_ACCESS_KEY is not set. Quitting."
  exit 1
fi

if [ -z "$AWS_REGION" ]; then
  AWS_REGION="eu-west-1"
fi


if [ -z "$AWS_S3_BUCKET" ]; then
  echo "AWS_S3_BUCKET is not set. Quitting."
  exit 1
fi

if [ -z "$AWS_S3_OBJECT_KEY" ]; then
  echo "AWS_S3_OBJECT_KEY is not set. Quitting."
  exit 1
fi

aws configure --profile s3-head-object-action <<-EOF > /dev/null 2>&1
${AWS_ACCESS_KEY_ID}
${AWS_SECRET_ACCESS_KEY}
${AWS_REGION}
json
EOF

echo s3_object=$(aws s3api head-object --bucket ${AWS_S3_BUCKET} --key ${AWS_S3_OBJECT_KEY} \
              --profile s3-head-object-action | jq "@json") >> $GITHUB_OUTPUT

aws configure --profile s3-head-object-action <<-EOF > /dev/null 2>&1
null
null
null
text
EOF