require 'matrix'
class PolarCoordinate
  def initialize(latitude, longitude, r)
    phi = (90.0 - latitude) * Math::PI / 180.0
    theta = longitude * Math::PI / 180.0

    x = r * Math.sin(phi) * Math.cos(theta)
    y = r * Math.sin(phi) * Math.sin(theta)
    z = r * Math.cos(phi)
    @cartesian = Vector[x, y, z]
    @latitude = latitude
    @longitude = longitude
    @r = r
  end
  attr_reader :latitude
  attr_reader :longitude
  attr_reader :r
  attr_reader :cartesian
  def x
    @cartesian[0]
  end
  def y
    @cartesian[1]
  end
  def z
    @cartesian[2]
  end
  def angle_with(other_coordinate)
    @cartesian.angle_with(other_coordinate.cartesian)
  end
end
