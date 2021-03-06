
# ----- Wireless -----

wlan-up:
	sudo ip link set wlan0 up
	sudo systemctl start wpa_supplicant@wlan0

wlan-down:
	sudo systemctl stop wpa_supplicant@wlan0
	sudo ip link set wlan0 down

wlan-scan:
	sudo ip link set wlan0 up
	sudo iw dev wlan0 scan | grep SSID

wlan-set:
	sudo ln -sf /etc/wpa_supplicant/wpa_supplicant-$(SSID).conf /etc/wpa_supplicant/wpa_supplicant-wlan0.conf

wlan-add:
	sudo wpa_passphrase '$(SSID)' '$(PASS)' > /etc/wpa_supplicant/wpa_supplicant-$(SSID).conf
	$(MAKE) wlan-set

wlan-list:
	cat /etc/wpa_supplicant/wpa_supplicant-*.conf | grep ssid

lan-scan:
	sudo arp-scan -l

# --- Share ---

SHARE_HOST=192.168.0.26/share
SHARE_PATH=/mnt/smb-share

mount-smb-share:
	@ sudo mount -t cifs -o username=nullptr,password=2662 //$(SHARE_HOST) $(SHARE_PATH)

umount-smb-share:
	sudo umount $(SHARE_PATH)

# --- Backups ---

BACKUPS_HOST=192.168.0.3/backups
BACKUPS_PATH=/mnt/smb-backups

mount-smb-backups:
	@ sudo mount -t cifs -o username=nullptr,password=2662 //$(BACKUPS_HOST) $(BACKUPS_PATH)

umount-smb-backups:
	sudo umount $(BACKUPS_PATH)


# --- Spkb Share ---

SP_SHARE_HOST=192.168.55.30/smb
SP_SHARE_PATH=/mnt/smb-spkb-share

mount-smb-spkb-share:
	@ mount -t cifs -o username=smb,password=mysmb //$(SP_SHARE_HOST) $(SP_SHARE_PATH)

umount-smb-spkb-share:
	umount $(SP_SHARE_PATH)

mount-phone:
	su -l nullptr -c "simple-mtpfs /mnt/phone"

umount-phone:
	umount /mnt/phone

# --- Battery ---

power-verbose:
	sudo upower -i $(shell upower -e | grep BAT)
	
power-info:
	sudo upower -i $(shell upower -e | grep BAT) | grep --color=never -E "state|to full|to empty|percentage"


# --- Mount USB ---

mount-usb:
	sudo mount /dev/sdb1 /mnt/usb -o uid=nullptr,gid=nullptr

umount-usb:
	sudo umount /mnt/usb

mount-ssh:
	sshfs srv.remote:/home/nullptr /mnt/srv
umount-ssh:
	sudo umount /mnt/srv

mount-cdrom:
	sudo mount -o loop -t iso9660 /dev/sr0 /mnt/cdrom

# --- Updates ---
update:
	sudo apt-get update
	sudo apt-get upgrade


# --- Power ---
off:
	-systemctl poweroff 
lock:
	-light-locker-command -l
sleep:
	-systemctl suspend

reboot:
	-systemctl reboot

# luks

LUKS_PART?=/dev/dummy
LUKS_NAME?=luks
LUKS_MOUNT?=$(LUKS_NAME)

setup-luks:
	sudo cryptsetup -y -v luksFormat $(LUKS_PART)
	sudo cryptsetup luksOpen $(LUKS_PART) $(LUKS_NAME)
	sudo mkfs.ext4 /dev/mapper/$(LUKS_NAME)
	sudo mount /dev/mapper/$(LUKS_NAME) $(LUKS_MOUNT)
	sudo chown -R $(USER):$(USER) $(LUKS_MOUNT)
	sudo rm -rf $(LUKS_MOUNT)/lost+found
	sudo umount $(LUKS_MOUNT)
	sudo cryptsetup luksClose $(LUKS_NAME)
mount-luks:
	sudo cryptsetup luksOpen $(LUKS_PART) $(LUKS_NAME)
	sudo mount /dev/mapper/$(LUKS_NAME) $(LUKS_MOUNT)
	-sudo systemctl start syncthing@$(USER)
umount-luks:
	-sudo systemctl stop syncthing@$(USER)
	sudo umount $(LUKS_MOUNT)
	sudo cryptsetup luksClose $(LUKS_NAME)
