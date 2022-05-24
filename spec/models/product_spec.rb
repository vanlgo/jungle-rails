require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here

    it 'should validate if all fields are available' do
      @category = Category.create!(name: 'New Category')
      @product = Product.create!(name: 'New Product', price_cents: 1500, quantity: 3, category_id: @category.id )
      expect([@product.name, @product.price_cents, @product.quantity, @product.category_id]).to be_present
    end

    it 'should not validate if the :name is not present' do
      @category = Category.create!(name: 'New Category')
      @product = Product.create!(name: nil, price_cents: 1500, quantity: 3, category_id: @category.id )
      expect(@product.errors.full_messages).to include("Name can't be blank") 
    end

    it 'should not validate if the :price is not present' do
      @category = Category.create!(name: 'New Category')
      @product = Product.create!(name: 'New Product', price_cents: nil, quantity: 3, category_id: @category.id )
      expect(@product.errors.full_messages).to include("Price can't be blank") 
    end

    it 'should not validate if the :quantity is not present' do
      @category = Category.create!(name: 'New Category')
      @product = Product.create!(name: 'New Product', price_cents: 1500, quantity: nil, category_id: @category.id )
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should validate if the :category is present' do
      @category = Category.create!(name: 'New Category')
      @product = Product.create!(name: 'New Product', price_cents: 1500, quantity: 3, category_id: nil )
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
