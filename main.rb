require './satellite'
def satellite_map(input_lines)
  satellites = []
  regex = /SAT(\d+),(-?[\d.]+),(-?[\d.]+),(-?[\d.]+)/
  input_lines.each do |l|
    begin
      id, latitude, longitude, altitude = l.scan(regex).flatten
      satellites << Satellite.new(id.to_i, latitude.to_f, longitude.to_f, altitude.to_f)
    rescue Exception => e
      p "Unable to parse input line #{l}"
      p e.message
    end
  end
  satellites.each do |s|
    s.add_visibles(satellites)
  end

  satellites
end

def satellite_positions
  File.open('data.txt').readlines[1..-2]
end

satellites = satellite_map(satellite_positions)
satellites.map { |s| p s.to_s }
