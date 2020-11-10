devmodel=$(adb shell getprop ro.product.manufacturer)
adpackage=android-tools

if ! [ $(id -u) = 0 ]; then
   echo "Please run this script as root (same command you did but with sudo at beginning)"
   exit 1
fi

if pacman -Qs $adpackage > /dev/null ; then
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
    if pacman -Qs $adpackage > /dev/null ; then
      echo "Installation successful, proceeding..."
      clear
    fi
fi
