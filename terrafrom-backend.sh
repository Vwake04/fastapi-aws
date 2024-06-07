aws s3api create-bucket \
    --bucket state-terraform-bucket-blue \
    --region ap-south-1 \
    --create-bucket-configuration LocationConstraint=ap-south-1 \
    --profile=blue

aws s3api put-bucket-versioning \
    --bucket state-terraform-bucket-blue \
    --versioning-configuration Status=Enabled \
    --profile=blue
    
aws dynamodb create-table \
    --table-name terraform-lock-table \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --profile=blue


terraform init -backend-config="bucket=$BUCKET_TF_STATE" -backend-config="region=$AWS_REGION" -backend-config="dynamodb_table=$DYNAMODB_TF_TABLE" -backend-config="kms_key_id=$KMS_KEY_TF_ID" -backend-config="key=$KEY_TF_NAME"





