#!/bin/sh

reboot_celular()
{
  adb reboot
}

enable_airplane_mode()
{
 adb shell settings put global airplane_mode_on 1
}

disable_airplane_mode()
{
 adb shell settings put global airplane_mode_on 0
}

wifi()
{
 adb shell input text "SenhaDaSuaWifi"
}

email()
{
 adb shell input text "SeuEmailDeTeste@gmail.com"
}

input() # Esta função vai receber como parâmetro o que vc desejar passar como texto para um campo de texto na tela
{
 adb shell input text "$1"
}

function getinfo () {

        echo "============================== DEVICE RELEVANT INFO ==============================="

        echo FINGERPRINT:

        adb shell getprop ro.build.fingerprint

        echo "SIM INFO : $(adb shell getprop gsm.sim.operator.alpha) | $(adb shell getprop gsm.sim.operator.numeric)"

        echo "SIM FULL IMSI : $(adb shell service call iphonesubinfo 7 | awk -F "'" '{print $2}' | sed '1 d'| tr -d '\n' | tr -d '.' | tr -d ' ')"

        echo "ro.CARRIER : $(adb shell getprop ro.carrier)"

        echo "MODEL : $(adb shell getprop ro.product.model)"

        echo "IMEI : $(adb shell service call iphonesubinfo 1 | awk -F "'" '{print $2}' | sed '1 d'| tr -d '\n' | tr -d '.' | tr -d ' ')"

        echo "SERIAL : $(adb shell getprop ro.boot.serialno)"

        echo "SKU : $(adb shell getprop ro.boot.hardware.sku)"

        echo "HW : $(adb shell getprop ro.vendor.hw.revision)"

        echo "Radio : $(adb shell getprop ro.vendor.hw.radio)"

        echo "==================================================================================="

}
