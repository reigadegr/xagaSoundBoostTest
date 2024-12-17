#!/bin/sh
sound_path="/data/adb/modules/XagaSoundTest"
BASEDIR="$(dirname "$0")"
conf="/data/data/com.miui.misound/shared_prefs/mi_sound_preference.xml"
boot_first_load(){
    pm clear com.miui.misound
    [ ! -d $(dirname "$conf") ] && mkdir -p $(dirname "$conf")
    cat $sound_path/config/headphone.xml > $conf
    pm enable com.miui.misound
    am start com.miui.misound/com.miui.misound.dolby.DolbyEqActivity
    until [ "$(dumpsys activity lru | grep " TOP" | cut -d ':' -f3 | awk -F '/' '{print $1}')" = 'com.miui.misound' ]; do
        sleep 0.1s
    done
    am force-stop com.miui.misound
    am force-stop com.android.settings
}
boot_first_load