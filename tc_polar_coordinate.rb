require 'test/unit'
require_relative 'polar_coordinate'

class TestPolarCoordinate < Test::Unit::TestCase
  def test_polar_coordinate_pure_axes
    coordx = PolarCoordinate.new(0.0, 0.0, 1000.0)
    assert_equal(1000.0, coordx.x.round(3))
    assert_equal(0.0, coordx.y.round(3))
    assert_equal(0.0, coordx.z.round(3))
    coordx2 = PolarCoordinate.new(0.0, 180.0, 1000.0)
    assert_equal(-1000.0, coordx2.x.round(3))
    assert_equal(0.0, coordx2.y.round(3))
    assert_equal(0.0, coordx2.z.round(3))
    coordy = PolarCoordinate.new(0.0, 90.0, 1000.0)
    assert_equal(0.0, coordy.x.round(3))
    assert_equal(1000.0, coordy.y.round(3))
    assert_equal(0.0, coordy.z.round(3))
    coordy2 = PolarCoordinate.new(0.0, -90.0, 1000.0)
    assert_equal(0.0, coordy2.x.round(3))
    assert_equal(-1000.0, coordy2.y.round(3))
    assert_equal(0.0, coordy2.z.round(3))
    coordz = PolarCoordinate.new(90.0, 0.0, 1000.0)
    assert_equal(0.0, coordz.x.round(3))
    assert_equal(0.0, coordz.y.round(3))
    assert_equal(1000.0, coordz.z.round(3))
    coordz2 = PolarCoordinate.new(-90.0, 0.0, 1000.0)
    assert_equal(0.0, coordz2.x.round(3))
    assert_equal(0.0, coordz2.y.round(3))
    assert_equal(-1000.0, coordz2.z.round(3))
  end

  def test_polar_coordinate_mixed_angles
    coord1 = PolarCoordinate.new(60.0, 30.0, 1000.0)
    assert_equal(433.013, coord1.x.round(3))
    assert_equal(250.0, coord1.y.round(3))
    assert_equal(866.025, coord1.z.round(3))
  end

  def test_angle_with_whenOnlyLongitudeChanged
    base = PolarCoordinate.new(0.0, 0.0, 1000.0)
    for n in -180..180
      coord2 = PolarCoordinate.new(0.0, 1.0*n, 1000.0)
      assert_equal(n.abs, (coord2.angle_with(base) * 180.0 / Math::PI).round(3))
    end
  end
  def test_angle_with_whenOnlyLatitudeChanged
    base = PolarCoordinate.new(0.0, 0.0, 1000.0)
    for n in -90..90
      coord2 = PolarCoordinate.new(1.0*n, 0.0, 1000.0)
      assert_equal(n.abs, (coord2.angle_with(base) * 180.0 / Math::PI).round(3))
    end
  end
end
