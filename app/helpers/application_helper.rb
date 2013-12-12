module ApplicationHelper

  def sortable(model, column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column(model) ? "current #{sort_direction}" : nil
    direction = column == sort_column(model) && sort_direction == "asc" ? "desc" : "asc"
    link_to title, { sort: column, direction: direction }, { class: css_class }
  end
end
