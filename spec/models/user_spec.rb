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

    it 'should have a minimum length of 8 characters for the password' do
      @user = User.create(first_name: 'Alan', last_name: 'Smithee', email: 'try@example.com', password: 'pass', password_confirmation: 'pass')
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should return an instance of the user when succesfully authenticating credentials' do
      @user = User.create(first_name: 'Alan', last_name: 'Smithee', email: 'try@example.com', password: 'password', password_confirmation: 'password')
      expect(User.authenticate_with_credentials(@user.email, @user.password)).to eq(@user)
      end
      
    it 'should work, even with extra spaces in the email' do
      @user = User.create(first_name: 'Alan', last_name: 'Smithee', email: 'try@example.com', password: 'password', password_confirmation: 'password')
      expect(User.authenticate_with_credentials('   try@example.com   ', 'password')).to eq(@user)
    end

    it 'should work, even with when the email is the wrong typecase' do
      @user = User.create(first_name: 'Alan', last_name: 'Smithee', email: 'try@example.com', password: 'password', password_confirmation: 'password')
      expect(User.authenticate_with_credentials('try@EXAMPLE.com', 'password')).to eq(@user)
    end
  end
end

