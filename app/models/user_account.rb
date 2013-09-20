class UserAccount < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name, :value

  def self.get(user_id, name)
    puts "__________________________"

    begin
      self.where("user_id = ? and name = ?", user_id, name).first.value
    rescue => ex
      puts ex.message

    end
  end

  def self.get(name)
    puts "__________44444444________________"

    begin
      self.where("user_id = ? and name = ?", 1, name).first.value
    rescue => ex
      puts ex.message
      raise
    end
  end
end
