class V1::MapsController < V1::ApiController

  def border
    respond_with MapBorder.prepare_coords
  end
end
