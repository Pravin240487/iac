#!/bin/sh

set -e
tf_env=$1
python3 commentor.py "main.tf" "//END=VPC" True

terraform apply -var 'image_tags={"api"="sprint-13-400-6ff040f", "app"="dev-46-2de45b3", "dbms" = "stage-113-aa27954", "scheduler" = "main-31-467d321", "ai-agent" = "qs_ai_main_dev-34-dev", "agent-runtime" = "main-36-39cdcd6", "integration" = "main-51-d09c6f7", "etl" = "main-18-8265914" }' -var-file="$tf_env".tfvars -auto-approve

python3 commentor.py "main.tf" "//END=VPC" False

python3 commentor.py "main.tf" "//END=SG" True

terraform apply -var 'image_tags={"api"="sprint-13-400-6ff040f", "app"="dev-46-2de45b3", "dbms" = "stage-113-aa27954", "scheduler" = "main-31-467d321", "ai-agent" = "qs_ai_main_dev-34-dev", "agent-runtime" = "main-36-39cdcd6", "integration" = "main-51-d09c6f7", "etl" = "main-18-8265914" }' -var-file="$tf_env".tfvars -auto-approve

python3 commentor.py "main.tf" "//END=SG" False

python3 commentor.py "main.tf" "//END=EC2" True

terraform apply -var 'image_tags={"api"="sprint-13-400-6ff040f", "app"="dev-46-2de45b3", "dbms" = "stage-113-aa27954", "scheduler" = "main-31-467d321", "ai-agent" = "qs_ai_main_dev-34-dev", "agent-runtime" = "main-36-39cdcd6", "integration" = "main-51-d09c6f7", "etl" = "main-18-8265914" }' -var-file="$tf_env".tfvars -auto-approve

python3 commentor.py "main.tf" "//END=EC2" False

python3 commentor.py "main.tf" "//END=RDS" True

terraform apply -var 'image_tags={"api"="sprint-13-400-6ff040f", "app"="dev-46-2de45b3", "dbms" = "stage-113-aa27954", "scheduler" = "main-31-467d321", "ai-agent" = "qs_ai_main_dev-34-dev", "agent-runtime" = "main-36-39cdcd6", "integration" = "main-51-d09c6f7", "etl" = "main-18-8265914" }' -var-file="$tf_env".tfvars -auto-approve

python3 commentor.py "main.tf" "//END=RDS" False

python3 commentor.py "main.tf" "//END=LB" True

terraform apply -var 'image_tags={"api"="sprint-13-400-6ff040f", "app"="dev-46-2de45b3", "dbms" = "stage-113-aa27954", "scheduler" = "main-31-467d321", "ai-agent" = "qs_ai_main_dev-34-dev", "agent-runtime" = "main-36-39cdcd6", "integration" = "main-51-d09c6f7", "etl" = "main-18-8265914" }' -var-file="$tf_env".tfvars -auto-approve

python3 commentor.py "main.tf" "//END=LB" False

terraform apply -var 'image_tags={"api"="sprint-13-400-6ff040f", "app"="dev-46-2de45b3", "dbms" = "stage-113-aa27954", "scheduler" = "main-31-467d321", "ai-agent" = "qs_ai_main_dev-34-dev", "agent-runtime" = "main-36-39cdcd6", "integration" = "main-51-d09c6f7", "etl" = "main-18-8265914" }' -var-file="$tf_env".tfvars -auto-approve