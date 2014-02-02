# -*- encoding : utf-8 -*-
class Admin::CategoriesController < Admin::AdminController

  expose(:categories) { Category.order(sort_column("Category") + " " + sort_direction).page(params[:page]).per(10) }
  expose(:category) { Category.find(params[:id]) }

  rescue_from ActiveRecord::RecordNotFound, with: :no_record_handler

  def update
    if category.update_attributes(category_params)
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
    params.require(:category).permit(:unique_id)
  end

  def no_record_handler
    flash[:alert] = "Nie znaleziono takiej kategorii"
    redirect_to admin_categories_path
  end
end
