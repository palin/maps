class V1::MapsController < V1::BaseController

  def border
    respond_with MapBorder.prepare_coords
  end
end
