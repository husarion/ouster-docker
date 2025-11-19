[private]
default:
    @just --list --unsorted

set shell := ["bash", "-cu"]
# host := "root@192.168.77.2"
# host := "root@hofi-x64-super.local"
host := "root@10.15.20.156"
port := "2222"

sync:
    #!/bin/bash
    # scp -P {{port}} ./rtc_sync.sh {{host}}:/home/root/rtc_sync.sh
    # scp -P {{port}} ./rtc_sync.sh {{host}}:/usr/bin/rtc_sync.sh
    # scp -P {{port}} ./justfile {{host}}:/home/root/justfile
    # scp -P {{port}} ./flash_overlay_stm32.sh {{host}}:/home/root/flash_overlay_stm32.sh
    
    scp -r -P {{port}} ./* {{host}}:/home/root/ouster-docker
    
    # scp -P {{port}} ./golden_img_create_wizard.sh {{host}}:/usr/bin/
    # scp -P {{port}} ./apply_husarion_ugv_golden_img_patch.sh {{host}}:/usr/bin/
    # scp -P {{port}} ./apply_cleanup.sh {{host}}:/usr/bin/
    # scp -P {{port}} ./first_boot.service {{host}}:/usr/share/golden_img_create/
    # scp -P {{port}} ./first_boot.sh {{host}}:/usr/share/golden_img_create/
    # scp -P {{port}} ./clear_keys.sh {{host}}:/usr/share/golden_img_create/

bad-time:
    #!/bin/bash
    date -s '2018-01-01 00:00:00'