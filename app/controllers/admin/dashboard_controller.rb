class Admin::DashboardController < ApplicationController

  def show
    @count_prod = Product.count
    @count_cat = Category.count
  end
end
