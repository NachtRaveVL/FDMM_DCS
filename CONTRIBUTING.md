# Contributing

Please feel free to reach out to NR before contributing.

## Environment Setup

### Clone FDMM

Clone the FDMM repository into the "%USERPROFILE%/Saved Games/DCS/Missions/FDMM" folder so that you can dynamically debug scripts out-of-the-box. If you want to use a different folder it is recommended to create a symlink from this folder, as opening the FDMM_Caucasus.miz mission file in the Mission Editor and updating the fdmm_path variable in the Setup triggers to point at the correct folder location also makes it so that you cannot as easily check binary miz file changes in.

### MissionScripting.lua setup

As per regular FDMM server installation instructions, be sure to edit your "<DCSWorldMainFolder>/Scripts/MissionScripting.lua" file to ensure that, nearer to the bottom of the file, the sanitizeModule('io'), sanitizeModule('lfs'), and 'require = nil' lines are commented-out. This will make it so your installation of FDMM can access the io and lfs Lua modules, which we use in various parts of FDMM.

This file will also get modified later on in the debugger setup section.

### LDT workspace paths setup

LDT really loves its absolute pathing, and outside of custom batch files doesn't respect %ENV% variables. We instead have to offload user-specific path strings onto LDT's general workspace linked resources variables and LDT's run/debug string substitution variables, accessible via Window->Preferences. For new workspace setups, you will have to set these variables up manually, which are listed below:

General -> Workspace -> Linked Resources:

| Variable Name | Typical Value | Notes |
| --- | --- | --- |
| DCS_MISSIONEDITOR_LOC | <steamapps/common>/DCSWorld/MissionEditor | Main DCS installation MissionEditor folder. |
| DCS_SCRIPTS_LOC | <steamapps/common>/DCSWorld/Scripts | Main DCS installation Scripts folder. |
| USER_DCS_MISSIONEDITOR_LOC | %USERPROFILE%/Saved Games/DCS/MissionEditor | User saved games DCS MissionEditor folder. |
| USER_DCS_SCRIPTS_LOC | %USERPROFILE%/Saved Games/DCS/Scripts | User saved games DCS Scripts folder. |

Run/Debug -> String Substitution:

| Variable Name | Typical Value | Notes |
| --- | --- | --- |
| npm_loc | %APPDATA%/npm | Location of npm (only used in 'Build All' script). |

### 'Build All' setup

While ability to 'Build All' isn't exactly required for development, here's how it works.

We follow the common practice of compiling all of our various Lua script files down into one master mission script file for release. While we do accomplish this with the master mission script file "FDMM_MissionStart.lua", we do so with some added complexity.

The building of all of FDMM's various Lua scripts down into one master mission script file is currently being handled by [node-lua-distiller](https://github.com/yi/node-lua-distiller), which is a CoffeeScript script that accomplishes this task rather nicely. As well, we also run the optionally recommended luasrcdiet after compilation - which is a performance enhancing stripper/obfuscator of sorts (or at least, that's the idea - jury is still out on its usefulness).

However, due to how this process works, require() call captures are limited to the require() hierarchy parsed out of the master mission script file we use to compile down with. We thus have to ensure that all FDMM source files are included, hierarchially, from our master mission script file (read as: any new files/modules added to FDMM will need a require() hierarchy pathway linking them into the master mission script file for them to be properly included into the compiled-down static output file for release). Thus, for all intents and purposes, "FDMM_MissionStart.lua" can be treated as both a master include as well as the mission start script.

While CoffeeScript is easiest installed via npm (node package manager), node-lua-distiller and luasrcdiet are easiest to install via LuaRocks, a popular Lua package manager. However, one caveat to watch out for: be sure to keep LuaRocks out of your Windows environment variables since you can mess up your DCS installation if you try to globally rewire Lua to not allow DCS to use the Lua binaries it natively ships with (don't quote me on that, though - but if your DCS install stops loading up and bails out at launch, never getting to the main menu, like it did some of us, that's probably why).

Lastly, you will have to add the location of npm (commonly "%APPDATA%/npm") to an "npm_loc" string subsitution variable in LDT's string substituion preference panel, via Window->Preferences, if you haven't done so previously.

#### Rewired require()

Since we don't get require() by default in DCS scripts (unless we change "DCSWorld/Scripts/MissionScripting.lua" to not nil out such) we take full advantage of repurposing it. This has a lot of advantages, the primary one being that we can introduce our own debug/release mechanics into it.

We have it set up such that the mission files in the main development branch are in debug/dynamic load mode, while it's planned to have mission files in release branches in release/static load mode.

##### Dynamically loaded / debuggable environment

In a dynamically loaded, and thus debugging-enabled (essentially what we devs use 90% of the time), environment the require() method acts somewhat similiarly like it does in proper Lua, but instead being behind a guarded dofile() call, with check to ensure that dofile() isn't called on any particular module/file require()'ed more than once (copy of this code exists in "support/Dynamic Mission Start Script.lua", which is copied into our debug mode LoadDynamic do-script mission start trigger in the mission editor).

However, this means that require()'ed files in FDMM cannot actually return anything (as it is in proper Lua), and thus should utilize the global namespace.

Additionally, scripts being loaded into DCS via dofile() also require use of absolute file location to function. FDMM handles this by first starting, via lfs.writedir(), at the "%USERPROFILE%/Saved Games/DCS" folder. Our require() replacement then adds "<fdmmPath/>workspace/FDMM/src/" to the line so that our require() calls treat FDMM's main src folder as the initial file lookup folder path. This keeps our require() methods short and tidy, while also allowing us to use those same require() calls in our build process.

This however also means that FDMM's require() calls should always be treated as starting from the file path from FDMM's main src folder. If that path doesn't resolve, then the native require() call is used instead.

##### Statically loaded / non-debuggable environment

At the same time, in a statically loaded, and thus release, environment the require() method is rewired via node-lua-distiller, which does a great job of wrapping each require()'ed file in a single clojure that then gets called when needed in the final static master mission script file.

### Debugger setup

In order to debug dynamically, you will need to follow the [MOOSE Interactive Debug Guide](https://flightcontrol-master.github.io/MOOSE_DOCS/Interactive_Debug_Guide.html) instructions for how to get DCS debug mode to work, and also be working on the FDMM development branch files (or have debug mission user flag set).

The main gotcha is that you don't want to start the "dcsserver" debug server (which you must painfully select from the debug menu option dropdown, each time) until you have launched into the actual mission, in which, if you have it set up correctly, DCS will pause at 50% load and spend 5 seconds or so looking for a debug server connection before continuing - in which time you must start the debug server up from LDT in order for debugging to connect/work.

(If you don't use the debug menu dropdown option for "dcsserver", despite having it set as that menu option's favorite (which should make it not do this, but alas), then LDT will likely auto-create a build process for the file you currently have opened, which of course will fail, and you'll have to remove said build entry from the project files prior to check-in. All of which is just a large hassle.) (I would also love to see someone fix this.)

As you start the mission, however, be aware that before the game actually launches the main DCS instance (where this debug server connection occurs) you will be presented with a pre-launch screen that must be clicked away for the main DCS instance itself to start loading. It is only after this initial pre-launch screen is clicked away that it's best to alt-tab back to LDT and begin the "dcsserver" debug server, then alt-tab back into game to finish loading and click through the briefing screen in order for the mission to start, and thus your debug breakpoints to start getting hit as the mission loads and progresses.
