---
-- FDMM Utils Module.
-- @module FDMM_Utils
env.info("---FDMM_Utils Start---");

do --FDMM_Utils
  --- FDMM utilities module.
  fdmm.utils = {}

  function fdmm.utils.pos2ToLoggableString(vec2)
    return '~{' .. mist.utils.round(vec2.x, -2) .. ',' .. mist.utils.round(vec2.y, -2) .. '}'
  end

  function fdmm.utils.pos3ToLoggableString(vec3)
    return '~{' .. mist.utils.round(vec3.x, -2) .. ',' .. mist.utils.round(vec3.z, -2) ..
           ',a:' .. mist.utils.round(vec3.y,-1) .. '}'
  end

  function fdmm.utils.isUserFlagSet(flag)
    local flag = trigger.misc.getUserFlag(flag)
    return (type(flag) == 'number' and flag ~= 0) or
           (type(flag) == 'boolean' and flag ~= false) or
           (type(flag) == 'string' and flag ~= 'false' and flag ~= '0' and flag ~= 'no')
  end

  function fdmm.utils.isDebugFlagSet()
    return fdmm.utils.isUserFlagSet(fdmm.consts.UserFlags.DebugFlag)
  end

end --FDMM_Utils

env.info("---FDMM_Utils End---");
