#!/bin/bash

vm_name="SnowCrash"
GREEN='\033[1;32m'
GREY='\033[0;37m'
NC='\033[0m'

if echo $(VBoxManage list vms) | grep -q $vm_name; then
  echo "VM $vm_name already exists"
  VBoxManage startvm $vm_name --type headless 2>/dev/null
  exit 0
fi

echo $GREEN

VBoxManage setproperty machinefolder "/Volumes/usb_pruiz-ca/Virtual Box"

VBoxManage createvm --name "SnowCrash" --ostype "Linux" --register
VBoxManage modifyvm "SnowCrash" --cpus 1 --memory 512 --nic1 bridged --bridgeadapter1 en0 --audio none

VBoxManage storagectl "SnowCrash" --name "IDE Controller" --add ide
VBoxManage storageattach "SnowCrash" --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium "./SnowCrash.iso"

VBoxManage startvm $vm_name --type headless

echo $GREY
printf "Waiting for IP address"
while true; do

  ip=$(VBoxManage guestproperty get "SnowCrash" "/VirtualBox/GuestInfo/Net/0/V4/IP")

  if ! echo "$ip" | grep -q "No value set!"; then
    break
  fi

  printf "."
  
  sleep 1
done
echo $NC

echo
echo "====================="
echo "${vm_name}IP Address:"
echo "- $ip"
echo "====================="
