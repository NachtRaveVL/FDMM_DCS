env.info('---FDMM_MooseAdditions Start---')

assert(routines, 'Moose not initialized.')

do --FDMM_MooseAdditions

  -- gets distance in meters squared between two points (2 dimensional)
  function routines.utils.get2DDistSqrd(point1, point2)
    point1 = routines.utils.makeVec3(point1)
    point2 = routines.utils.makeVec3(point2)
    return routines.vec.magSqrd({x = point1.x - point2.x, y = 0, z = point1.z - point2.z})
  end

  -- gets distance in meters squared between two points (3 dimensional)
  function routines.utils.get3DDistSqrd(point1, point2)
    return routines.vec.magSqrd({x = point1.x - point2.x, y = point1.y - point2.y, z = point1.z - point2.z})
  end

  routines.vec.magSqrd = function(vec)
    return (vec.x^2 + vec.y^2 + vec.z^2)
  end

end --FDMM_MooseAdditions

env.info('---FDMM_MooseAdditions End---')
