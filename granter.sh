adpackage=android-tools
awkcheck=$(adb devices | awk 'NR==2 {print $2}')
if ! [ $(id -u) = 0 ]; then
   echo "Please run this script as root (same command you did but with sudo at beginning)"
   exit 1
fi
if pacman -Qs $package > /dev/null ; then
  echo "'android-tools' package is installed, skipping..."
else
  echo "'android-tools' package is not installed, installing..."
  sudo pacman -S --noconfirm android-tools
  retval=$?
  if [ $retval -ne 0 ]; then
    echo "Installation failed with code $retval, please try again."
    exit 1
  else
    echo "Pacman returned no errors, proceeding..."
  fi
fi
echo "Please connect your phone. Make sure USB debugging is turned on in Developer settings. If you're stuck at this step, switch USB mode to File transfer."
adb wait-for-device
echo "Device connected, fetching info..."
[ $awkcheck = device ] && echo "Proceeding..." || echo "Device not connected properly."
if echo $(adb shell getprop ro.product.manufacturer) | grep -q -i "OPPO"; then
 echo "OPPO device found, please make sure you have disabled permission monitor in developer settings, then press enter."
 read 
elif echo $(adb shell getprop ro.product.manufacturer) | grep -q -i "Huawei"; then
 echo "Huawei device found, please note that the apps may not work as expected due to system restrictions. Press enter to continue."
 read 
else
 echo $(adb shell getprop ro.product.manufacturer)" device found."
fi
echo "Granting the shades..."
adb shell pm grant com.treydev.mns android.permission.WRITE_SECURE_SETTINGS
adb shell pm grant com.treydev.pns android.permission.WRITE_SECURE_SETTINGS
adb shell pm grant com.treydev.ons android.permission.WRITE_SECURE_SETTINGS
adb shell pm grant com.treydev.micontrolcenter android.permission.WRITE_SECURE_SETTINGS
clear
echo "Permissions granted, you can disconnect your device now."
