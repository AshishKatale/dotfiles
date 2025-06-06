- #### **Connect to Wi-Fi**

```bash
iwctl

station wlan0 scan
station wlan0 get-networks
station wlan0 connect {SSID}

timedatectl set-ntp true
```

- #### **Create Partitions**

```bash
lsblk # show filesystem info

cfdisk # create partitions
# create partitions for Linux Filesystem (ext4), swap, efi. (can reuse windows efi '/boot')
mkfs.ext4 /dev/{ext4} # create ext4 FS
mkswap /dev/{swap}    # create swap partition
swapon /dev/{swap}

# create efi partition. (if not re-using windows efi)
mkfs.vfat -F32 /dev/{efi}
```

- #### **Mount Partitions**

```bash
mount /dev/{ext4} /mnt
mkdir /mnt/{efi}  # '/boot' if re-using windows efi 
mount /dev/{efi} /mnt/{efi}
```

- #### **Install linux filesystem**

```bash
pacstrap -K /mnt base linux linux-firmware intel-ucode gvim

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt # change root to /mnt
```

- #### **Set time zone and locale**

```bash
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc

# Uncomment locale en_US.UTF-8 from /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
```

- #### **Host settings**

```bash
echo "{hostname}" >> /etc/hostname
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	{hostname}.localdomain	{hostname}" >> /etc/hosts

passwd #set root password
```

- #### **Configure GRUB bootloader**

```bash
pacman -s grub efibootmgr os-prober ntfs-3g mtools dosfstool networkmanager network-manager-applet wpa_supplicant wireless_tools base-devel linux-headers git openssh bluez bluez-utils blueman pulseaudio pulseaudio-bluetooth xdg-user-dirs xdg-user-dirs-gtk

grub-install --target=x86_64-efi --efi-directory=/{efi} --bootloader-id=GRUB
# uncomment GRUB_DISABLE_OS_PROBER=false /etc/default/grub
# windows needs to be fully shutdown or grub won't detect windows efi
grub-mkconfig -o /boot/grub/grub.cfg
```

- #### **Enable services**

```bash
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable sshd
```

- #### **Add User**

```bash
useradd -mG wheel {username}
passwd {username}

# give sudo access
EDITOR=vim visudo # uncomment %wheel ALL=(ALL:ALL) ALL

exit # exit from installer
reboot
```

- #### **Configure display server**

```bash
nmcli device wifi connect {SSID} password {password}

pacman -S xorg xorg-xinit xf86-video-intel lightdm lightdm-slick-greeter stow alacritty i3 i3lock

git clone dotfiles
cd dotfiles
stow */
cd scripts/bin
./updaterc
./setupzsh

echo "background=/etc/lightdm/bg.jpg" >> etc/lightdm/slick-greeter.conf
# uncomment below options in etc/lightdm/lightdm.conf
greeter-session=lightdm-slick-greeter
autologin-user={username}

cp /etc/X11/xinit/xinitrc $HOME/.xinitrc
echo "exec i3" >> $HOME/.xinitrc

systemctl enable lightdm
```
