class V2::MapsController < V2::BaseController

  def border
    respond_with MapBorder.prepare_coords
  end
end
