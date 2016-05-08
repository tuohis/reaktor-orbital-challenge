require 'test/unit'
require_relative 'satellite'

class TestSatellite < Test::Unit::TestCase

  def test_sees_false_when_two_ground_points
    point1 = Satellite.new(1, 0, 0, 0)
    point2 = Satellite.new(2, 1, 0, 0)
    assert_equal(false, point1.sees?(point2))
    assert_equal(false, point2.sees?(point1))
  end

  def test_sees_true_when_same_points
    point1 = Satellite.new(1, 0, 0, 10)
    point2 = Satellite.new(2, 0, 0, 10)
    assert_equal(true, point1.sees?(point2))
    assert_equal(true, point2.sees?(point1))
  end

  def test_sees_false_when_on_opposite_sides_of_globe
    point1 = Satellite.new(1, -90, 0, 600)
    point2 = Satellite.new(2, 90, 0, 600)
    assert_equal(false, point1.sees?(point2))
    assert_equal(false, point2.sees?(point1))
  end

  def test_sees_false_when_on_opposite_sides_of_globe_2
    point1 = Satellite.new(1, 0, 0, 600)
    point2 = Satellite.new(2, 0, 180, 600)
    assert_equal(false, point1.sees?(point2))
    assert_equal(false, point2.sees?(point1))
  end

  def test_sees_false_when_on_opposite_sides_of_globe_3
    point1 = Satellite.new(1, 30, 0, 600)
    point2 = Satellite.new(2, -30, 180, 600)
    assert_equal(false, point1.sees?(point2))
    assert_equal(false, point2.sees?(point1))
  end

  def test_sees_false_when_just_out_of_reach
    altitude = 500
    r_sat = EARTH_RADIUS + altitude
    angle_rad = 2 * Math.acos(EARTH_RADIUS / r_sat)
    angle_deg = angle_rad / Math::PI * 180
    point1 = Satellite.new(1, 0, 0, altitude - 0.1)
    point2 = Satellite.new(2, angle_deg, 0, altitude)
    assert_equal(false, point1.sees?(point2))
    assert_equal(false, point2.sees?(point1))
  end
  def test_sees_true_when_just_in_reach
    altitude = 500
    r_sat = EARTH_RADIUS + altitude
    angle_rad = 2 * Math.acos(EARTH_RADIUS / r_sat)
    angle_deg = angle_rad / Math::PI * 180
    point1 = Satellite.new(1, 0, 0, altitude + 0.1)
    point2 = Satellite.new(2, angle_deg, 0, altitude)
    assert_equal(true, point1.sees?(point2))
    assert_equal(true, point2.sees?(point1))
  end

  def test_sees_false_when_arbitrarily_far_away
    point1 = Satellite.new(18, -16, 128, 668)
    point2 = Satellite.new(7, 48, -1, 574)
    assert_equal(false, point1.sees?(point2))
    assert_equal(false, point2.sees?(point1))
  end
end
