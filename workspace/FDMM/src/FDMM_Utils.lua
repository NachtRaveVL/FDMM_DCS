env.info("---FDMM_Utils Start---");

fdmm.utils = {}

do --FDMM_Utils

  function fdmm.utils.pos2ToReadableString(vec2)
    return '~{' .. mist.utils.round(vec2.x, -2) .. ',' .. mist.utils.round(vec2.y, -2) .. '}'
  end

  function fdmm.utils.pos3ToReadableString(vec3)
    return '~{' .. mist.utils.round(vec3.x, -2) .. ',' .. mist.utils.round(vec3.z, -2) ..
           ',a:' .. mist.utils.round(vec3.y,-1) .. '}'
  end

end --FDMM_Utils

env.info("---FDMM_Utils End---");
