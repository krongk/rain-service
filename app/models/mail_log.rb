class MailLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :mail_item
  belongs_to :mail_tmp
end
