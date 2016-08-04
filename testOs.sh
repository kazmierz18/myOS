echo 'Enetring .bootloader...'
cd ./bootloader
echo 'Compiling bootloader...'
make	#compile all bootloader files
echo 'Enering os folder...'
cd ../kernel #compile 
echo 'Compiling system kernel...'
make	#compile all kernel files
echo 'Enering root folder...'
cd ..
if [ ! -f "myos.img" ]
then
	echo 'Creating virtal disk for qemu...'
	qemu-img create -f qcow2 myos.img 1M #create imgae file for qemu if not exist
fi
echo 'Writing OS to virtual disk...'
dd if=bootloader/bin/boot.bin of=myos.img		#put in first boot sector
												#here should be file tabel in 2nd sector
dd if=bootloader/binboot2.bin of=myos.img seek=2 #skip to the 3 sector and put here 2nd stage bootloader
hexdump myos.img	# display hex map of disk
echo 'Starting machine..'
qemu-system-i386 myos.img #run Virtual PC
