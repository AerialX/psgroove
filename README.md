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
This payload makes use of the /app\_home/PS3\_GAME menu item. You may place
an application on a USB drive under the PS3\_GAME folder to run it without
installing a package.
**Note that simply extracting a .pkg onto the USB drive is not quite enough
for a program to run. EBOOT.BIN must be slightly modified to boot properly.**


Cloning
-------
The repository uses the LUFA library as a submodule.  To clone, use something like:

    git clone git://github.com/psgroove/psgroove.git
    cd psgroove
    git submodule init
    git submodule update


Configuring
-----------
Chip and board selection can be handled in the Makefile.conf file.


Building
--------
On Linux, use the AVR GCC toolchain (Debian/Ubuntu package: gcc-avr).
On Windows, WinAVR should do the trick.

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

**This software is not intended to enable piracy, and such features
have been disabled.  This software is intended to allow the execution
of unsigned third-party apps and games on the PS3.**
