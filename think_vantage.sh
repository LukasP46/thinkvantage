#!/bin/bash

cat=$(cat thinkvantage.lck)
if [    $cat == *"RUN"* ]; then

    echo "0" > thinkvantage.lck

else
    
    echo "1" > thinkvantage.lck
    out=$(systemctl status thinkfan)

    echo $out


    if [[ $out == *"Active: active (running)"* ]]
    then
        sudo systemctl stop thinkfan
        echo "RUN" >> thinkvantage.lck
        cat=$(cat thinkvantage.lck)
        while [[ $cat == *"1"*	]]; do
            cat=$(cat thinkvantage.lck)
            sleep 2
            echo "level full-speed" > /proc/acpi/ibm/fan
            echo set to full-speed
        done
    fi

    if [[ $out == *"Active: inactive (dead)"* ]]
    then
        sudo systemctl start thinkfan
        echo reset
    fi

fi


echo "0" > thinkvantage.lck
