set -e
az config set defaults.location=eastasia
az config set defaults.group=root-compartment
create-vm() {

  az disk create -n teradata-vantage-express --size-gb 60
  az sshkey create --name teradata-ssh-key

  az vm create --name teradata-vantage-express --image UbuntuLTS --size Standard_F4s_v2 --public-ip-sku Basic --admin-username azureuser --ssh-key-name teradata-ssh-key
  DISK_ID=$(az disk show -n teradata-vantage-express --query 'id' -o tsv)
  az vm disk attach --vm-name teradata-vantage-express --name $DISK_ID

}

mount-data-disk() {
  parted /dev/sdc --script mklabel gpt mkpart xfspart xfs 0% 100%
  mkfs.xfs /dev/sdc1
  partprobe /dev/sdc1
  export DISK_UUID=$(blkid | grep sdc1 | cut -d"\"" -f2)
  echo "UUID=$DISK_UUID  /opt/downloads   xfs   defaults,nofail   1   2" >>/etc/fstab
}
$@
