# Contributing

Please feel free to reach out to NR before contributing.

## Building

### Downloading

Make sure to clone this repository into the "Saved Games/DCS/Missions/FDMM" folder so that you can dynamically debug scripts out-of-the-box, or at the very least make a symlink of some kind from this location to the folder you're using for development.

### Getting LDT's 'Build All' to work

While ability to 'Build All' isn't required for development, here's how you can make yours work.

Since pilots love keeping things to the book, it follows common practice to compile all our various Lua script files down into one master script file for release. While we do accomplish this, we do so with some added complexity.

The building of all of FDMM's various Lua scripts, combined, down into one master file is currently being handled by [node-lua-distiller](https://github.com/yi/node-lua-distiller), which is a CoffeeScript script that accomplishes this task rather nicely. As well, we also run the optionally recommended luasrcdiet after compilation - which is a performance enhancing stripper (or at least, that's the idea - jury is still out on its usefulness) and clojure-based require() function replacer.

However, due to how this process works, require() call captures are limited to the require() hierarchy parsed out of the master file we wish to compile-down. Thus we have to ensure that all FDMM source files are included, hierarchially, from the master file "FDMM_MissionStart.lua" (read as: any new files/modules added to FDMM will need a require() hierarchy pathway linking them from this master file for them to be properly included into the compiled-down static output file for release). Thus, for all intents and purposes, "FDMM_MissionStart.lua" can be treated as the master include as well as the mission start script.

While CoffeeScript is easiest installed via npm (node package manager), node-lua-distiller and luasrcdiet are easiest to install via LuaRocks, a popular Lua package manager. However, one caveat to watch out for: be sure to keep LuaRocks out of your Windows environment variables since you can mess up your DCS installation if you try to globally rewire Lua to not allow DCS to use the one it natively ships with (don't quote me on that, though - but if your DCS install stops loading up and bails out at launch, never getting to the main menu, like it did me, that's probably why).

Lastly, you will have to add the location of npm (commonly "%APPDATA%/npm") to an "npm_loc" string subsitution variable in LDT's string substituion preference panel (via Window->Preferences).

### Note: require() rewiring

Since we don't get require() natively in DCS scripts we take full advantage of repurposing it. This has a lot of advantages, the primary one being that we can introduce our own debug/release mechanics.

We have it set up such that the mission files in the main development branch are in debug/dynamic load mode, while it's planned to have mission files in release branches in release/static load mode.

#### Dynamically loaded / debuggable environment

In a dynamically loaded, and thus debugging-enabled (essentially what we devs use 90% of the time), environment the require() method acts somewhat similiarly like it does in proper Lua, but instead behind a guarded dofile() call, with checks to ensure dofile() isn't called on any particular module/file require()'ed more than once (copy of this code exists in "support/Dynamic Mission Start Script.lua", which is copied into our debug mode LoadDynamic do-script mission start trigger in the mission editor).

However, this means that require()'ed files in FDMM cannot actually return anything (as it is in proper Lua), and thus should utilize the global namespace.

Additionally, scripts being loaded into DCS via dofile() also require use of absolute file location to function. FDMM handles this by first starting, via lfs.writedir(), at the "Saved Games/DCS" folder. Our require() replacement then adds "/Missions/FDMM/workspace/FDMM/src/" to the line so that our require() calls treat FDMM's main src folder as the main lookup folder path. This keeps our require() methods short and tidy, while also allowing us to use those same require() calls in our build process.

This however also means that FDMM's require() calls should always be treated as starting the file path from FDMM's main src folder, never the folder the file may exist inside of, and by convention never to a file existing outside of FDMM's main src folder hierarchy - in which case we probably want to have that file added to the Lua environment in DCS via the LoadDeps do-script-file mission start trigger in the mission editor.

#### Statically loaded / non-debuggable environment

At the same time, in a statically loaded, and thus release, environment the require() method is rewired via lua-src-diet, which does a great job of wrapping each require()'ed file in a single clojure that then gets called when needed in the final mission file.

### Note: LDT build path libraries may not resolve

LDT really wants us to be using absolute pathing as often as possible it seems, and doesn't do a very good job of letting us use %ENV% variables in our path strings, so we've tried to offload as many user-specific path strings into LDT's string substitution panel, mainly just to keep them out of the main checked-in project files.

We would be so happy if LDT made it so that we could specify build path libraries using these %ENV% variables, but it would appear as if such is not supported. Please feel free to add new build path library entries to the project that correspond with your own DCS Scripts and MissionEditor folder locations, and just leave the ones that don't resolve correctly alone as a courtesy to other devs. (Note: I would love for someone to fix this)

## Debugging

In order to debug dynamically, you will need to follow the [MOOSE Interactive Debug Guide](https://flightcontrol-master.github.io/MOOSE_DOCS/Interactive_Debug_Guide.html) instructions for how to get DCS debug mode to work, and also be working on the FDMM development branch files (or have debug mission user flag set).

The main gotcha is that you don't want to start the "dcsserver" debug server (which you must painfully select from the debug menu option dropdown, each time) until you have launched into the actual mission, in which, if you have it set up correctly, DCS will pause at 50% load and spend 5 seconds or so looking for a debug server connection before continuing - in which time you must start the debug server up from LDT in order for debugging to connect/work.

(If you don't use the debug menu dropdown option for "dcsserver", despite having it set as that menu option's favorite (which should make it not do this, but alas), then LDT will likely auto-create a build process for the file you currently have opened, which of course will fail, and you'll have to remove said build entry from the project files prior to check-in. All of which is just a large hassle.) (I would also love to see someone fix this.)

As you start the mission, however, be aware that before the game actually launches the main DCS instance (where this debug server connection occurs) you will be presented with a pre-launch screen that must be clicked away for the main DCS instance itself to start loading. It is only after this initial pre-launch screen is clicked away that it's best to alt-tab back to LDT and begin the "dcsserver" debug server, then alt-tab back into game to finish loading and click through the briefing screen in order for the mission to start, and thus your debug breakpoints to start getting hit as the script loads.
