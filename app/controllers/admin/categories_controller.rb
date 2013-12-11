# -*- encoding : utf-8 -*-
class Admin::CategoriesController < Admin::AdminController

  expose(:categories) { Category.order(sort_column("Category") + " " + sort_direction).page(params[:page]).per(10) }
  expose(:category) { Category.find_by_id(params[:id]) }

  before_filter :find_category, except: [:index]

  def index
  end

  def edit
  end

  def update
    category.assign_attributes(category_params)

    if category.save
      flash[:notice] = "Kategoria została zaktualizowana!"
      redirect_to admin_categories_path
    else
      flash[:alert] = "Wystąpił problem. Sprawdź dane formularza."
      render :edit
    end
  end

  def destroy
    if category.destroy
      flash[:notice] = "Kategoria została usunięta!"
    else
      flash[:alert] = "Nie można usunąć zgłoszenia!"
    end

    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:title, :description, :unique_id)
  end

  def find_category
    unless category
      flash[:alert] = "Nie znaleziono takiej kategorii"
      redirect_to admin_categories_path
    end
  end
end
