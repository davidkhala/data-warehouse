set -e
export VM_IMAGE_DIR="${HOME}/VantageExpress17.20_Sles12"
DEFAULT_VM_NAME="vantage-express"
VM_NAME="${VM_NAME:-$DEFAULT_VM_NAME}"
setup() {
    apt-install
    mkdir -p $VM_IMAGE_DIR
    download-disks
    create-vbox
    set-autostart
    wait-until-ready
}

apt-install() {
    sudo apt update && sudo apt-get install virtualbox p7zip-full p7zip-rar -y
}
download-OVA() {
    # .ova is for GUI-based Virtualbox VM install, please use disk 1,2,3 for CLI-based Virtualbox VM install
    wget -O $VM_IMAGE_DIR/vbox.ova https://objectstorage.ap-singapore-1.oraclecloud.com/n/cn9yc2hk0gzg/b/installation-binary/o/teradata%2FVantageExpress_VirtualBoxAppliance_17.20_Sles12_20220819081111.ova
}
download-disks() {
    wget -O $VM_IMAGE_DIR/ve.7z https://objectstorage.ap-singapore-1.oraclecloud.com/n/cn9yc2hk0gzg/b/installation-binary/o/teradata%2FVantageExpress17.20_Sles12_20230220064202.7z
    7z x $VM_IMAGE_DIR/ve.7z
}
create-vbox() {

    vboxmanage createvm --name "$VM_NAME" --register --ostype openSUSE_64
    vboxmanage modifyvm "$VM_NAME" --ioapic on --memory 6000 --vram 128 --nic1 nat --cpus 4
    vboxmanage storagectl "$VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci

    set -e
    [[ -n $(find $VM_IMAGE_DIR -name '*disk1*') ]] # ensure file exist
    [[ -n $(find $VM_IMAGE_DIR -name '*disk2*') ]] # ensure file exist
    [[ -n $(find $VM_IMAGE_DIR -name '*disk3*') ]] # ensure file exist

    vboxmanage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$(find $VM_IMAGE_DIR -name '*disk1*')"
    vboxmanage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 1 --device 0 --type hdd --medium "$(find $VM_IMAGE_DIR -name '*disk2*')"
    vboxmanage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 2 --device 0 --type hdd --medium "$(find $VM_IMAGE_DIR -name '*disk3*')"
    vboxmanage modifyvm "$VM_NAME" --natpf1 "tdssh,tcp,,4422,,22"
    vboxmanage modifyvm "$VM_NAME" --natpf1 "tddb,tcp,,1025,,1025"
    start-vbox-async
    vboxmanage controlvm "$VM_NAME" keyboardputscancode 1c 1c

}
stop-vbox() {
    vboxmanage controlvm "$VM_NAME" acpipowerbutton
    local counter=0
    set +e
    while true; do
        if vboxmanage list runningvms | grep $VM_NAME; then
            ((counter++))
            sleep 1
            echo Stopping $VM_NAME ...

        else
            break
        fi
    set -e
    done
}
start-vbox-async() {
    vboxmanage startvm "$VM_NAME" --type headless
}
start-vbox(){
    start-vbox-async
    wait-until-ready
}
stop() {
    stop-vbox
    sudo shutdown -h now
}

set-autostart() {

    
    sudo wget -O /etc/systemd/system/vantage-express.service https://raw.githubusercontent.com/davidkhala/data-warehouse/main/teradata/express/autostart/vantage-express.service
    sudo systemctl daemon-reload

    # needs vbox vm installed under root user, otherwise the systemd service will fail to start
    sudo systemctl enable vantage-express # inline start can fail due to vantage-express vm is running.

}
wait-until-ready() {
    sudo apt-get install -y sshpass
    wait-until-port-4422

    ssh-vbox "curl https://raw.githubusercontent.com/davidkhala/data-warehouse/main/teradata/teradata.sh -O; chmod +x ./teradata.sh; ./teradata.sh wait-until-health"
    # Generally, it will success after ~120 retry times
}
wait-until-port-4422() {
    local counter=0
    set +e
    while true; do
        if ssh-vbox "true"; then
            break
        else
            ((counter++))
            sleep 1
            echo Wait until port 4422 ready ... ${counter} times retry
        fi

    done
    set -e
    # Generally, it will success after ~40 retry times
}

ssh-vbox() {
    sshpass -p root ssh -o StrictHostKeyChecking=no -o ConnectTimeout=1 -p 4422 root@${hostname:-localhost} $@
}

$@
