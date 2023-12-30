#!/bin/bash

vm_name="SnowCrash"

VBoxManage controlvm $vm_name poweroff
VBoxManage unregistervm $vm_name
