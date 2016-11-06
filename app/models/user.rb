class User < ActiveRecord::Base
  belongs_to :corporate
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
