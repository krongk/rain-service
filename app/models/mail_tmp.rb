class MailTmp < ActiveRecord::Base
  self.per_page = 50
  belongs_to :user

  validates_presence_of :title, :content
end
