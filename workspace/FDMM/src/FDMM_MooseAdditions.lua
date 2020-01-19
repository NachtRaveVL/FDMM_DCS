---
-- FDMM MOOSE Additions Module.
-- @module FDMM_MOOSEAdditions
env.info('---FDMM_MOOSEAdditions Start---')

assert(routines, 'MOOSE not initialized.')

do --FDMM_MOOSEAdditions

  --- Distance between two points (2 dimensional).
  -- Gets distance in meters squared between two points in 2 dimensions (no altitude).
  -- Useful for when comparing distances, in which the square root operation isn't necessary.
  -- @param DCS#Vec2 point1 First point.
  -- @param DCS#Vec2 point2 Second point.
  -- @return Distance in meters squared.
  function routines.utils.get2DDistSqrd(point1, point2)
    if point1.z ~= nil then point1 = routines.utils.makeVec2(point1) end
    if point2.z ~= nil then point2 = routines.utils.makeVec2(point2) end
    return routines.vec.magSqrd({x = point1.x - point2.x, y = point1.y - point2.y})
  end

  --- Distance between two points (3 dimensional).
  -- Gets distance in meters squared between two points in 3 dimensions (with altitude).
  -- Useful for when comparing distances, in which the square root operation isn't necessary.
  -- @param DCS#Vec3 point1 First point.
  -- @param DCS#Vec3 point2 Second point.
  -- @return Distance in meters squared.
  function routines.utils.get3DDistSqrd(point1, point2)
    if point1.z == nil then point1 = routines.utils.makeVec3(point1) end
    if point2.z == nil then point2 = routines.utils.makeVec3(point2) end
    return routines.vec.magSqrd({x = point1.x - point2.x, y = point1.y - point2.y, z = point1.z - point2.z})
  end

  --- Vector magnitude squared.
  -- Gets magnitude of vector in meters squared.
  -- Useful for when comparing distances, in which the square root operation isn't necessary.
  -- @param DCS#Vec vec Vector.
  -- @return Magnitude in meters squared.
  routines.vec.magSqrd = function(vec)
    return (vec.x * vec.x) + (vec.y * vec.y) + ((vec.z or 0) * (vec.z or 0))
  end

  --- Constructor to create a ZONE_POLYGON instance, taking the zone name and array of @{DCS#Vec2}, forming a polygon.
  -- The polygon points define the polygon corners. The first and the last point are automatically connected by ZONE_POLYGON.
  -- @param #ZONE_POLYGON self
  -- @param #string ZoneName Name of the zone.
  -- @param #ZONE_POLYGON_BASE.ListVec2 PointsArray An array of @{DCS#Vec2}, forming a polygon.
  -- @return #ZONE_POLYGON self
  function ZONE_POLYGON:NewFromPoints( ZoneName, PointsArray )
    local self = BASE:Inherit( self, ZONE_POLYGON_BASE:New( ZoneName, PointsArray ) )
    self:F( { ZoneName, nil, self._.Polygon } )

    -- Zone objects are added to the _DATABASE and SET_ZONE objects.
    _EVENTDISPATCHER:CreateEventNewZone( self )

    return self
  end

end --FDMM_MOOSEAdditions

env.info('---FDMM_MOOSEAdditions End---')
