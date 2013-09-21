class UserTheme < ActiveRecord::Base
  belongs_to :user
  belongs_to :theme

  def self.has?(user_id, theme_id)
    self.where(:user_id => user_id, :theme_id => theme_id).any?
  end
  
end
