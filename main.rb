require './satellite'
def satellite_map(satellite_lines, endpoints_line)
  satellites = []
  regex = /SAT(\d+),(-?[\d.]+),(-?[\d.]+),(-?[\d.]+)/
  satellite_lines.each do |l|
    begin
      id, latitude, longitude, altitude = l.scan(regex).flatten
      satellites << Satellite.new(id.to_i, latitude.to_f, longitude.to_f, altitude.to_f)
    rescue Exception => e
      p "Unable to parse input line #{l}"
      p e.message
    end
  end
  start_latitude, start_longitude, end_latitude, end_longitude = endpoints_line.scan(/ROUTE,(-?[\d.]+),(-?[\d.]+),(-?[\d.]+),(-?[\d.]+)/).flatten
  satellites << Satellite.new(-1, start_latitude.to_f, start_longitude.to_f, 0)
  satellites << Satellite.new(-2, end_latitude.to_f, end_longitude.to_f, 0)
  satellites.each do |s|
    s.add_visibles(satellites)
  end

  satellites
end

def satellite_positions
  File.open('data.txt').readlines[1..-2]
end

def endpoints
  File.open('data.txt').readlines[-1]
end


satellites = satellite_map(satellite_positions, endpoints)
satellites.map { |s| p s.to_s }
