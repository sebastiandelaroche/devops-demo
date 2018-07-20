wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip
unzip /tmp/terraform.zip -d ~/bin

echo $GOOGLE_AUTH > $HOME/gcp-key.json
gcloud auth activate-service-account --key-file $HOME/gcp-key.json
gcloud --quiet config set project $GCP_PROJECT

cd infra && terraform init -input=false &&
terraform apply -input=false -auto-approve
# && cd .. &&
# git config --global user.email "aspadevs@gmail.com" &&
# git config --global user.name "sebastiandelaroche" &&
# git add infra && git commit -m "Deployed $CIRCLE_BUILD_NUM [skip ci]" &&
# git push origin master