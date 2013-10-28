class PhoneCallLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :phone_call
end
