# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:user) do
    User.create!(username: 'm3ghdad', password: '123456')
  end

  describe 'validations' do
    # user = User.new(username: 'm3ghdad', password: '123456')
      it {should validate_presence_of(:username)}
      it {should validate_uniqueness_of(:username)}
      it {should validate_presence_of(:password_digest)}
      it { should validate_length_of(:password).is_at_least(6)}
  end

  describe 'class methods' do
    describe 'password encryption' do
      it 'should not save password to database' do
        User.create!(username: 'James Bond', password: 'secret_password_007')
        user = User.find_by_username('James Bond')
        expect(user.password).to_not be('secret_password_007')
      end

      it 'should encrypt password using BCrypt' do
        expect(BCrypt::Password).to receive(:create)
        User.new(username: 'm3ghdad', password: '123456')
      end

    end
  end


end
