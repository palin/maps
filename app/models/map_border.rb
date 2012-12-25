# -*- encoding : utf-8 -*-
class MapBorder

  def self.prepare_coords
    coords = []
    File.open("app/assets/poznan_coords", "r") do |f|
      while (line = f.gets)
        splitted = line.split(', ')
        single_coord = []

        single_coord.push splitted.first.to_f
        single_coord.push splitted.last.to_f

        coords.push single_coord
      end
    end

    coords
  end
end