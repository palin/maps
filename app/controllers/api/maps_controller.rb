class Api::MapsController < Api::ApiController

  def border
    render_json :border => MapBorder.prepare_coords
  end
end
