class V1::CategoriesController < V1::BaseController

  expose(:categories) { Category.order(:created_at) }
end
