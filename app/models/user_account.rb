class UserAccount < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name, :value

  def self.get(name)
    begin
      self.where("user_id = ? and name = ?", User.current_user.id, name).first.value
    rescue
      ''
    end
  end
end
