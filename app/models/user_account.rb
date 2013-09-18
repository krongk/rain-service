class UserAccount < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name, :value
end
