set -e
vm_name=${name:-teradata-vantage-express}
export zone=${zone:-asia-east2-c}
firewall_dev=${vm_name}-dev
firewall_prod=${vm_name}
create-vm() {
  gcloud compute instances create ${vm_name} --zone=${zone} --machine-type=n2-custom-4-8192 --enable-nested-virtualization \
    --create-disk=boot=yes,device-name=ve-disk,image-project=ubuntu-os-cloud,image-family=ubuntu-2004-lts,size=70,type=pd-standard \
    --async --tags=teradata
  gcloud compute firewall-rules create ${firewall_dev} --allow=tcp:22,tcp:4422,tcp:1025,icmp --description="Allow development traffic to teradata-vantage-express" --direction=INGRESS
  curl https://raw.githubusercontent.com/davidkhala/gcp-collections/main/compute/cli/instance.sh | bash -s wait-until-ssh ${vm_name}

}
ssh-vm() {
  gcloud compute ssh root@${vm_name} --zone=${zone}
}
setup-vm() {
  gcloud compute ssh root@${vm_name} --zone=${zone} --command="wget https://raw.githubusercontent.com/davidkhala/data-warehouse/main/teradata/express/teradata.sh; chmod +x ./teradata.sh; ./teradata.sh setup"
   

  curl https://raw.githubusercontent.com/davidkhala/gcp-collections/main/compute/cli/instance.sh | bash -s get-ip ${vm_name}

}
terminate() {
  gcloud compute instances delete ${vm_name} --zone=${zone} --quiet
  gcloud compute firewall-rules delete ${firewall_dev} --quiet
  gcloud compute firewall-rules delete ${firewall_prod} --quiet
}
housekeep() {
  gcloud compute firewall-rules create ${firewall_prod} --allow=tcp:1025 --description="Allow traffic to teradata-vantage-express" --direction=INGRESS --target-tags=teradata
  gcloud compute firewall-rules delete ${firewall_dev}
}

$@
