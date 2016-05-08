require './polar_coordinate'
EARTH_RADIUS = 6371.0

class Satellite < PolarCoordinate
  def initialize(id, latitude, longitude, altitude)
    super(latitude, longitude, EARTH_RADIUS + altitude)
    @id = id
    @visible_satellites = []
  end
  attr_reader :id

  def add_visibles(other_satellites)
    other_satellites.each do |s|
      @visible_satellites.push(s) if s.id != @id and sees? s
    end
  end

  def sees?(other_satellite)
    Math.acos(EARTH_RADIUS / r) + Math.acos(EARTH_RADIUS / other_satellite.r) > angle_with(other_satellite)
  end

  def to_s
    result = ""
    result << "Id: #{@id} "
    result << "Coordinates: #{@latitude.round(3)}, #{@longitude.round(3)}, #{(@r - EARTH_RADIUS).round(3)} "
    result << "Visibles: "
    @visible_satellites.map {|s| result << "#{s.id} "}
    result
  end
end
