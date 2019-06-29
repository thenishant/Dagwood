#Get device names
devices=$(adb devices | grep -oP "\K([^ ]+)(?=\sdevice(\W|$))")
echo "Devices found: ${#devices[@]}"

APPIUM_LOG="/var/log/appium.log"
CMD="xvfb-run appium --log $APPIUM_LOG"