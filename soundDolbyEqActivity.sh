#!/bin/sh
sound_path="/data/adb/modules/XagaSoundTest"
BASEDIR="$(dirname "$0")"
conf="/data/data/com.miui.misound/shared_prefs/mi_sound_preference.xml"

pm clear com.miui.misound
[ ! -d $(dirname "$conf") ] && mkdir -p $(dirname "$conf")
cat $sound_path/config/normal.xml > $conf
pm enable com.miui.misound
am start com.miui.misound/com.miui.misound.dolby.DolbyEqActivity
# sleep 2
until [ "$(dumpsys activity lru | grep " TOP" | cut -d ':' -f3 | awk -F '/' '{print $1}')" = 'com.miui.misound' ]; do
    sleep 0.1s
done
am force-stop com.miui.misound com.android.settings

