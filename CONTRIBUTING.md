# Contributing

Please feel free to reach out to NR before contributing.

## Downloading & Building

### Downloading

Make sure to clone this repository into a "Saved Games/DCS/Missions/FDMM" folder so that you can dynamically debug scripts out-of-the-box, or at the least make a symlink of some kind to the folder you're using for development.

### Building

Since DCS users love keeping things to the book, it follows common pratice to compile all our various sripts down into one master script file for release.

The building of the various lua scripts combined down into one is currently being handled by [node-lua-distiller](https://github.com/yi/node-lua-distiller), which is the CoffeeScript script that accomplishes this task. As well, we also run the optionally included luasrcdiet afterwards - which is a performance enhancing stripper and clojure-based require() method replacer. This module, along with CoffeeScript, requires that LuaRocks be installed, but be sure to keep LuaRocks out of your windows environment variables since you can mess up your DCS install if you try to rewire Lua to not be the one DCS natively wants to use (but don't quote me on that).

#### Note: require() re-routing

Since we don't get require() natively in DCS scripts we take full advantage of repurposing it. This has a lot of advantages, the primary one being that we can introduce our own build system mechanics.

In a dynamically loaded, and thus debugging-enabled (essentially what we devs use 90% of the time), environment the require() method acts much like it does in proper Lua: behind a guarded dofile() call, with check to ensure dofile() isn't called on any particular module/file more than once (copy of this code exists in "support/Dynamic Mission Start Script.lua", and placed in our debug mode load script).

While this is nice, DCS scripts have a CWD natively as the "Saved Games/DCS/" folder, which our replacement then adds "/Missions/FDMM/workspace/FDMM/src/" to so that your require() calls treat CWD as the main src folder. This keeps our require() methods short and tidy, and allows us to require() calls into our build system.

At the same time, in a statically loaded, and thus release, environment the require() method is rewired via lua-src-diet, which does a great job of wrapping each require()'ed file in a clojure that then gets called when needed in the final mission file.
