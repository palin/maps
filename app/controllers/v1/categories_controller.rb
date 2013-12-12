class V1::CategoriesController < V1::BaseController

  expose(:categories) { Category.all.sort_by(&:created_at) }
end
