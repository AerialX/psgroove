/* ========================
   === Select a Payload ===
   ======================== */

// This is the minimum PSGroove exploit payload needed to install packages
// #include "payload_default.S"

// This is my modified payload that allows you to run apps directly from USB.
// It only uses the first USB drive plugged in: place your app in a /PS3_GAME folder on the USB drive.
// Select the /app_home/PS3_GAME from the Game menu to launch your application.
// The files in the app folders must be structured like an unpacked .pkg file.
// (eboot.bin will not usually run without modification)
#include "payload_apploader.S"

// The debug payload hooks syscall403 (debug write) and stores it in memory.
// Use syscall8 to retrieve a pointer to pop a debug string.
// This payload is based off of apploader (and will run apps off USB)
// #include "payload_debug.S"

