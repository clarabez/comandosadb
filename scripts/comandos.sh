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