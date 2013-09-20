class UserAccount < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name, :value

  def self.get(name)
    puts "__________________________"
    User.current_user.id
    puts "__________________________"
    begin
      self.where("user_id = ? and name = ?", User.current_user.id, name).first.value
    rescue => ex
      puts ex.message
      raise
    end
  end
end
