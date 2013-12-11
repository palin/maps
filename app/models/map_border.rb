# -*- encoding : utf-8 -*-
class MapBorder

  def self.prepare_coords
    coords = []
    File.open("app/assets/poznan_coords", "r") do |f|
      while (line = f.gets)
        values = line.split(', ')

        coords.push [values.first.to_f, values.last.to_f]
      end
    end

    coords
  end
end
