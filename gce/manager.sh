# Basics
sudo apt-get update -q
sudo apt-get install -qy \
	nano htop less locate xauth \
	ca-certificates curl wget bzip2 curl


# Mount shared disk
sudo mkfs.ext4 -F -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/disk/by-id/google-shared
sudo mkdir -p /mnt/shared
echo UUID=`sudo blkid -s UUID -o value /dev/disk/by-id/google-shared` /mnt/shared ext4 discard,defaults,nofail 0 2 | sudo tee -a /etc/fstab
cat /etc/fstab
sudo mount /mnt/shared
sudo chmod a+rxw /mnt/shared


# Serve shared disk
sudo apt-get install -qy nfs-kernel-server
echo /mnt/shared 10.132.0.0/20(rw,async,no_root_squash) | sudo tee -a /etc/exports
sudo systemctl restart nfs-kernel-server


# Misc
sudo updatedb