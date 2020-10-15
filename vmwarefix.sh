cd /usr/lib/vmware/modules/source

tar xf vmmon.tar

tar xf vmnet.tar

cd vmmon-only

make

cd ../vmnet-only

make

cd ..

mkdir /lib/modules/`uname -r`/misc

cp vmmon.o /lib/modules/`uname -r`/misc/vmmon.ko

cp vmnet.o /lib/modules/`uname -r`/misc/vmnet.ko

depmod -a

/etc/init.d/vmware restart
