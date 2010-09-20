PSGroove
========

This is the PSGroove, an open-source reimplementation of the psjailbreak exploit for
AT90USB and related microcontrollers.

***AerialX's fork of PSGroove was made for easier prototyping of the initial payload.***

It should work on:

- AT90USB162
- AT90USB646
- AT90USB647
- AT90USB1286
- AT90USB1287
- ATMEGA32U4

... and maybe more.

**This software is not intended to enable piracy, and such features
have been disabled.  This software is intended to allow the execution
of unsigned third-party apps and games on the PS3.**


Payloads
--------
This fork comes with multiple payloads, which you can enable by editing
port1_config_descriptor.S. All payloads have been rearranged so that
they do not use hardcoded addresses anymore; you can rewrite and resize
functions without worrying about offsetting others.

### Default Payload
The default payload performs the basic PSGroove exploit; it allows you
to install and run unsigned packages.

### Apploader Payload
This payload makes use of the /app_home/PS3_GAME menu item. You may place
an application on a USB drive under the PS3_GAME folder to run it without
installing a package.
**Note that simply extracting a .pkg onto the USB drive is not quite enough
for a program to run. EBOOT.BIN must be slightly modified to boot properly.**

### Debug Payload
This payload provides two syscalls, 403 and 8. Syscall 403 is a standard
debug write syscall that many apps will write to, including vsh itself. This
payload will log all calls to syscall 403 and hang onto them until syscall 8
is called to pop the oldest debug string from the list. A simple app can use
this syscall to retrieve the debug output accumulated by the payload.


Cloning
-------
The repository uses the LUFA library as a submodule.  To clone, use something like:

    git clone git://github.com/AerialX/psgroove.git
    cd psgroove
    git submodule init
    git submodule update


Configuring
-----------
Chip and board selection can be handled in the Makefile.conf file.


Building
--------
Unlike the original PSGroove, this fork requires three different gcc compilers
installed in order to build:

* gcc: A normal host gcc is required to build the raw2payload application.
* ppu-gcc, ppu-binutils: A version of gcc that will compile 64bit PowerPC instructions is
  required to build the payload. Linux packages can be found on
  [BSC.es](http://www.bsc.es/plantillaH.php?cat_id=461).
* avr-gcc, avr-libc: Like PSGroove, WinAVR or the AVR GCC toolchain are required to build
  the exploit itself.

With these dependencies installed, you can build the exploit by simply running:

    make clean
    make


Board-specific notes
--------------------
Note that port 6 has been removed from this fork, and thus you will not
see any LED confirmation on your device if the exploit succeeds.


Programming
-----------
Now program psgroove.hex into your board and you're ready to go.  For
the AT90USBKEY and other chips with a DFU bootloader preinstalled, you
can get the dfu-programmer tool, put your board in programming mode,
and run
  
    make dfu

For the Teensy boards, you probably have to use the [Teensy
Loader](http://www.pjrc.com/teensy/loader.html) software. The makefile
will use teensy-loader-cli if you run
   
    make install

Using
-----
To use this exploit:
  
* Hard power cycle your PS3 (using the switch in back, or unplug it)
* Plug the dongle into your PS3.
* Press the PS3 power button, followed quickly by the eject button.

After a few seconds, the first LED on your dongle should light up.
After about 5 seconds, the second LED will light up (or the LED will
just go off, if you only have one).  This means the exploit worked!
You can see the new "Install Package Files" menu option in the game
menu.


Notes
-----
A programmed dongle won't enumerate properly on a PC, so don't worry
about that.

This branch has a modified payload that adds peek and poke syscalls 
to the lv2 kernel. A userspace application can use these syscalls to 
dump out the entire memory space of the kernel, or patch the kernel
as it is running.  

Unfortunately, because the free toolchain/sdk is not ready, we can't
distribute an application to do the dumping, so you will have to make
your own.

The lv2 kernel starts at 0x8000000000000000

### Peek
* lv2 syscall 6
* r3 is a 64 bit address to read
* A 64 bit value will be returned in r3

### Poke
* lv2 syscall 7
* r4 is a 64 bit value
* r3 is the address to write that value to
