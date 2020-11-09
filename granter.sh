package=android-tools
if ! [ $(id -u) = 0 ]; then
   echo "Please run this script as root (sudo)"
   exit 1
fi
if pacman -Qs $package > /dev/null ; then
  echo "Package $package is installed, skipping installation"
else
  echo "Package $package is not installed, installing as root, enter your password if prompted"
  sudo pacman -S --noconfirm android-tools
  clear
fi
echo "Please connect your phone. Make sure USB debugging is turned on in Developer settings. If you are a ColorOS (Oppo) user, please disable permission monitoring in the same section."
adb wait-for-device
clear
echo "Checking deive permissions..."
adb devices
echo "If you see 'no permissions', please make sure you enabled usb debugging, in your device dev settings, set the usb mode to 'File Transfer', and granted the device dubug in a promt on your phone, then run the script again. If not, press enter."
read
echo "Proceeding..."
echo "Detecting and granting the shades..."
adb shell pm grant com.treydev.mns android.permission.WRITE_SECURE_SETTINGS
adb shell pm grant com.treydev.pns android.permission.WRITE_SECURE_SETTINGS
adb shell pm grant com.treydev.ons android.permission.WRITE_SECURE_SETTINGS
adb shell pm grant com.treydev.micontrolcenter android.permission.WRITE_SECURE_SETTINGS
clear
echo "All done! You can disconnect your device now."
