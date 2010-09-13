all:
	@make -f Makefile.lufa
	@make -f Makefile.payload
	@make -f Makefile.psgroove

clean:
	@make -f Makefile.lufa clean
	@make -f Makefile.payload clean
	@make -f Makefile.psgroove clean

include Makefile.conf

install: all
	sudo teensy-loader-cli -mmcu=$(MCU) -v -n psgroove.hex
