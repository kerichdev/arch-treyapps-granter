adpackage=android-tools
#adbdevc=$(adb devices)
#oppodev=Oppo
#emuidev=Huawei
awkcheck=$(adb devices | awk 'NR==2 {print $2}')
#devmodel=$(adb shell getprop ro.product.manufacturer)

if ! [ $(id -u) = 0 ]; then
   echo "Please run this script as root (same command you did but with sudo at beginning)"
   exit 1
fi

if pacman -Qs $package > /dev/null ; then
  echo "android-tools are installed, skipping installation"
else
  echo "android-tools are not installed, installing as root, enter your password if prompted"
  sudo pacman -S --noconfirm android-tools
  retval=$?
  if [ $retval -ne 0 ]; then
    echo "Pacman returned $retval, please review the installation log and try again."
    exit 1
  else
    echo "Pacman returned no errors, verifying installation..."
    if pacman -Qs $package > /dev/null ; then
      echo "Installation successful, proceeding..."
      clear
    fi
  fi
fi

echo "Please connect your phone. Make sure USB debugging is turned on in Developer settings. If you're stuck at this step, switch USB mode to File transfer."
adb wait-for-device
echo "Device connected, fetching info..."
#if ! [ $(adb devices | awk 'NR==2 {print $2}') = "device" ]; then
 #echo "Proceeding..."
#else
 #echo "Device not connected properly. Please visit https://github.com/kerichdev/arch-treyapps-granter/blob/v2/guide.txt for a fix"
 #exit 1
#fi

#fix here soon

if echo $(adb shell getprop ro.product.manufacturer) | grep -q -i "OPPO"; then
 echo "OPPO device found, please make sure you have disabled permission monitor in developer settings, then press enter."
 read 
elif echo $(adb shell getprop ro.product.manufacturer) | grep -q -i "Huawei"; then
 echo "Huawei device found, please note that the apps may not work as stable as expected due to system restrictions, and it's not the developer's fault. Press enter to continue."
 read 
fi
