env.info('---FDMM_MISTAdditions Start---')

assert(mist, 'MIST not initialized.')

do --FDMM_MISTAdditions

  --- Returns distance in meters squared between two points.
  -- @tparam Vec2|Vec3 point1 first point
  -- @tparam Vec2|Vec3 point2 second point
  -- @treturn number distance squared between given points.
  function mist.utils.get2DDistSqrd(point1, point2)
    point1 = mist.utils.makeVec3(point1)
    point2 = mist.utils.makeVec3(point2)
    return mist.vec.magSqrd({x = point1.x - point2.x, y = 0, z = point1.z - point2.z})
  end

  --- Returns distance in meters squared between two points in 3D space.
  -- @tparam Vec3 point1 first point
  -- @tparam Vec3 point2 second point
  -- @treturn number distance squared between given points in 3D space.
  function mist.utils.get3DDistSqrd(point1, point2)
    return mist.vec.magSqrd({x = point1.x - point2.x, y = point1.y - point2.y, z = point1.z - point2.z})
  end

  --- Vector magnitude squared
  -- @tparam Vec3 vec vector
  -- @treturn number magnitude squared of vector vec
  function mist.vec.magSqrd(vec)
    return (vec.x^2 + vec.y^2 + vec.z^2)
  end

end --FDMM_MISTAdditions

env.info('---FDMM_MISTAdditions End---')
