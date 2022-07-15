# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :profile, presence:true
  enum profile: { admin: 1, client: 2 }
end
