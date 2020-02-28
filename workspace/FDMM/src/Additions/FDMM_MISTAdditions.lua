---
-- FDMM MIST Additions Module.
-- @module FDMM_MISTAdditions
env.info("---FDMM_MISTAdditions Start---")

assert(mist, 'MIST not initialized.')

do --FDMM_MISTAdditions

  --- DBs object category enum.
  mist.DBs.Category = {
    Vehicle = 'vehicle',
    Ship = 'ship',
    Plane = 'plane',
    Helicopter = 'helicopter',
    Building = 'building',
    Unknown = 'unknown'
  }

  --- Distance between two points (2 dimensional).
  -- Gets distance in meters squared between two points in 2 dimensions (no altitude).
  -- Useful for when comparing distances, in which the square root operation isn't necessary.
  -- @param DCS#Vec2 point1 First point.
  -- @param DCS#Vec2 point2 Second point.
  -- @return DCS#Distance Distance in meters squared.
  function mist.utils.get2DDistSqrd(point1, point2)
    if point1.z ~= nil then point1 = mist.utils.makeVec2(point1) end
    if point2.z ~= nil then point2 = mist.utils.makeVec2(point2) end
    return mist.vec.magSqrd({x = point1.x - point2.x, y = point1.y - point2.y})
  end

  --- Distance between two points (3 dimensional).
  -- Gets distance in meters squared between two points in 3 dimensions (with altitude).
  -- Useful for when comparing distances, in which the square root operation isn't necessary.
  -- @param DCS#Vec3 point1 First point.
  -- @param DCS#Vec3 point2 Second point.
  -- @return DCS#Distance Distance in meters squared.
  function mist.utils.get3DDistSqrd(point1, point2)
    if point1.z == nil then point1 = mist.utils.makeVec3(point1) end
    if point2.z == nil then point2 = mist.utils.makeVec3(point2) end
    return mist.vec.magSqrd({x = point1.x - point2.x, y = point1.y - point2.y, z = point1.z - point2.z})
  end

  --- Vector magnitude squared.
  -- Gets magnitude of vector in meters squared.
  -- Useful for when comparing distances, in which the square root operation isn't necessary.
  -- @param DCS#Vec vec Vector.
  -- @return DCS#Distance Magnitude in meters squared.
  mist.vec.magSqrd = function(vec)
    return (vec.x * vec.x) + (vec.y * vec.y) + ((vec.z or 0) * (vec.z or 0))
  end

end --FDMM_MISTAdditions

env.info("---FDMM_MISTAdditions End---")
