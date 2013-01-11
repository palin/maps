# -*- encoding : utf-8 -*-
class Admin::CategoriesController < Admin::AdminController

  before_filter :require_admin, :set_cache_buster
  before_filter :find_category, :except => [:index]

  def index
    @categories = Category.order(sort_column("Category") + " " + sort_direction).page(params[:page]).per(10)
  end

  def edit

  end

  def update
    @category.assign_attributes(params[:category])

    if @category.save
      flash[:notice] = "Kategoria została zaktualizowana!"
      redirect_to admin_categories_path and return
    else
      flash[:alert] = "Wystąpił problem. Sprawdź dane formularza."
      render :action => 'edit'
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = "Kategoria została usunięta!"
    else
      flash[:alert] = "Nie można usunąć zgłoszenia!"
    end

    redirect_to admin_categories_path and return
  end

  private

  def find_category
    @category = Category.find_by_id(params[:id])
    unless @category
      flash[:alert] = "Nie znaleziono takiej kategorii"
      redirect_to admin_categories_path and return
    end
  end
end
