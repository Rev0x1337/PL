#!/bin/bash
while [ 1 ]
do

echo "/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\\"
echo "----------------This is multitool---------------"
echo "\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/"
echo "Please select function: "
echo "[1] Update system."
echo "[2] Upgrade system."
echo "-------------------------------------------------"
echo "[3] Ping."
echo "-------------------------------------------------"
echo "[4] Add user."
echo "[5] Delete user."
echo "[6] cat /etc/passwd"
echo "-------------------------------------------------"
echo "[7] File execution permission (+x)."
echo "*************************************************"
echo "[0] Exit"



echo -n "->"
read choice
case $choice in
1)
echo "*************************************************"
echo -n "Updating system...."
sudo apt-get update
echo "*************************************************"
;;
2)
echo "*************************************************"
echo -n "Upgrade system...."
sudo apt-get upgrade -y
echo "*************************************************"
;;
3)
echo -n "->"
echo "Enter address: "
read address
echo "*************************************************"
ping -c 5 $address
echo "*************************************************"
;;
4)
echo -n "->"
echo "Enter username: "
read username
echo "*************************************************"
sudo useradd -m -s /bin/bash $username
echo "Enter password for new user: "
sudo passwd $username
echo "*************************************************"
;;
5)
echo -n "->"
echo "Enter username: "
read username
echo "*************************************************"
sudo userdel -r $username
echo "*************************************************"
;;
6)
echo "*************************************************"
cat /etc/passwd
echo "*************************************************"
;;
7)
echo -n "->"
echo "Enter the path to the file: "
read path
echo "*************************************************"
sudo chmod +x $path
echo "*************************************************"
;;
0)
echo "Good Bye!"
break
;;
*)
echo "Bad case!"
;;
esac
done

