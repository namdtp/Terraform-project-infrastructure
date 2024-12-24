#!/bin/bash

set -x  # Debug mode

chmod +x bash.sh
git add bash.sh
git commit -m "Add executable permission for bash.sh"
git push origin <branch>

# Set Google Cloud credentials
GCP_CREDENTIALS='{
  "type": "service_account",
  "project_id": "woven-amulet-445102-f3",
  "private_key_id": "9b876a21962ca874f711aedb7ee06e5577444a09",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCzSTiaSH3HaoSF\n87bskZEROgiOo6ZICmoyXxue2NbcivIGcKipC4VbTCOHIiUPReARE+bwkf7ynNeo\nprVOHmCbphQ6TDzE8BIioaEWdFrzY/afxNXXH+RNklVV3wJ300u8uP2BN4+Yc1IO\n7vbuBAXhjEz1K0uhhR2OoBG5WaNrAsOWqx2PNtd/Bi9UqN9eNsTuygIi+scHtsAu\npphCg0tNCaKfr9GyRvzUMNjzz2bCgO8HsaPINhNqsFH4qE7XH72/gbaHxH2yqj9e\nlTTuyy8DelnYHSMFF/hvndSUJUX6aVlo98P9AqDwlNn2oXVXnjD6DaW2JDzF/0H8\nkpsPXdQBAgMBAAECggEAMkyIG0zcMN7S+EvEVcGPLACWlwIVrB9z5NbnBl06hpxa\nw3DG+Mo5K0CEtSxgrlTBxLjLMVIcb0+Od4vx0M1X+EMTaLmr0Oqzg9DJw2V4gNFa\nRz+vaM/TOuojk9hhtmFq3bMeuCpw2Gn+Kx9i2qr5RWqZyqzPZqzUeoexAUnDPcmL\nMPzjLx4799bxWIQyv3oy7fDxy/irbg2ffQ7alqVGpeoV5LIcUGXCWI+p2PMj606d\nqG3yrjMngY0t8N+0JO2xQ5PDHCgDANYcgxYJ5Tozoa/P+powIZ6+xKLwHvTYOiaC\ntCUkrvbn7hDG5OgCKrFPEfp1Kr3VU8A9KUj0aPUtSwKBgQDw6mgjnRHNG0+b//dm\nwvKjTisX/lvBUH9mcV+ynRb1uNOYgrfpiVDi2HUvWY4qAFGHtBsVb+kdNMujF+y/\nNC0/pZ77sJdej/JhOHuwjfJQlqMQhIuvbECs74pGexJ7uXEofgAxxgVtnS4PZasw\nTGhrocR1ouMoJNINgDidOgKtHwKBgQC+gvbSGPFnrJ+iZXhcdxSQV93UnKWoe4Ft\nvNOeDYPuHNDeawWptQV2YW2sMppyCygPQRp/jm36V8XgxWgAGYw+lFch9RMje1aS\n+zqwhK8rr9coqB1l3xJWiwf3o0FYzNihC/CB6oc67aP4e4yjz0VQAnLYGvQq5Edg\nAKfayjA63wKBgAdgtlW43q2wU2zMlu//slyL7Ufr0zWFWJFzkWGv698UjO5Tunwd\nZ2u7A0Oy82aX4edM/bNXXQU287GH7wkf+O7FDKxaiRgtQlf12dvbTPto0Y+U744s\nu4JQR6TG6hb949hAm5LqpInp0VpJW8e730rEhnavyVMWZZRiQ9mUyDYzAoGALwIL\nux2ye11p6l1VTKOJbHBx6SNZ8O/AqP49zTMSia+MjkUkGZL0LRivQh0eZOOB1/m9\nexn+4xXDWsn69oNXSp25vkRFm6y0WQIqoiGrQ4FY+sw4rMlVMguORLmAx1OMZHiY\nuMXQ5mZ63jZGJqlfNfXUtqQ3+VlojzS6Nk9LhUsCgYEAhQg9VcMFv7NTs2YZ8Zf6\n8MsxrjK+6FlErhZJCGSgSAQfSXFTZ+eXd4vmhmcYVfexaVJV4lS15L9akfHV9d89\njmv9L8151TuAe9PJTkQ5N9o1QLRbYDVXGqk+jZAyoEdE0yqqaLhpn00NlT+eOeId\ntN2mhTyNYoxQcKF2xKaYccw=\n-----END PRIVATE KEY-----\n",
  "client_email": "dev-123@woven-amulet-445102-f3.iam.gserviceaccount.com",
  "client_id": "103722882729277522150",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/dev-123%40woven-amulet-445102-f3.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}'


# Ghi credentials vào file tạm thời
echo "$GCP_CREDENTIALS" > $HOME/credentials.json || { echo "Failed to write credentials"; exit 1; }

export GOOGLE_APPLICATION_CREDENTIALS=$HOME/credentials.json

# Nhận tham số môi trường (dev, staging, prod)
ENV=$1
if [ -z "$ENV" ]; then
  echo "Error: Environment parameter is required (dev, staging, prod)"
  exit 1
fi

TF_DIR="environments/$ENV"

# Step 1: Initialize Terraform
echo "Initializing Terraform for environment: $ENV"
terraform -chdir="$TF_DIR" init -no-color -input=false || { echo "Terraform init failed"; exit 1; }

# Step 2: Validate Terraform
echo "Validating Terraform configuration for environment: $ENV"
terraform -chdir="$TF_DIR" validate -no-color || { echo "Terraform validate failed"; exit 1; }

# Step 3: Plan Terraform
echo "Planning Terraform changes for environment: $ENV"
terraform -chdir="$TF_DIR" plan -var-file=../../shared.tfvars -input=false || { echo "Terraform plan failed"; exit 1; }

# Step 4: Apply Terraform
echo "Applying Terraform changes for environment: $ENV"
terraform -chdir="$TF_DIR" apply -auto-approve -var-file=../../shared.tfvars || { echo "Terraform apply failed"; exit 1; }

echo "Terraform deployment completed for environment: $ENV"

rm -f $HOME/credentials.json
