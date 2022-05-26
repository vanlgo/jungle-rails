require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User Validations' do
    it 'should validate that password and password_confirmation are the same' do
      @user = User.create(first_name: 'Alan', last_name: 'Smithee', email: 'try@example.com', password: 'password', password_confirmation: 'password')
      expect([@user.password, @user.password_confirmation]).to eq(['password', 'password'])
    end

    it 'should validate that the e-mail is unique' do
      @user = User.create(first_name: 'Alan', last_name: 'Smithee', email: 'try@example.com', password: 'password', password_confirmation: 'password')
      @user_two = User.create(first_name: 'Alan', last_name: 'Smithee', email: 'try@example.com', password: 'password', password_confirmation: 'password')
      expect(@user_two.errors.full_messages).to include('Email has already been taken')
    end

    it 'should not validate user registration if email, first name, and last name are not provided' do
      @user = User.create(first_name: 'Alan', last_name: 'Smithee', email: nil, password: 'password', password_confirmation: 'password')
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
  end

  describe 'Password Minimum Length' do
    it 'should have a minimum length of 8 characters for the password' do
      @user = User.create(first_name: 'Alan', last_name: 'Smithee', email: 'try@example.com', password: 'pass', password_confirmation: 'pass')
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end

    describe 'New Authentication Method' do
      it 'should '    
    end

    
  end


  

end
