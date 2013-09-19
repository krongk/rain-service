#encoding: utf-8
class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one  :user_detail
  has_many :user_accounts, :dependent => :destroy
  has_many :assets, :dependent => :destroy
  has_many :sms_tmps, :dependent => :destroy
  has_many :sms_logs, :dependent => :destroy
  has_many :phone_items, :dependent => :destroy
  has_many :mail_items, :dependent => :destroy
  has_many :mail_tmps, :dependent => :destroy
  has_many :sites, :dependent => :destroy
  has_many :site_posts, :dependent => :destroy
  has_many :site_pages, :dependent => :destroy
  
  before_create :set_default_roles
  after_create :create_user_detail

  #can access current_user on Model
  class << self
    def current_user=(user)
      Thread.current[:current_user] = user
    end

    def current_user
      Thread.current[:current_user]
    end
  end

  private
  def set_default_roles
    self.roles = [Role.find_or_create_by_name('user')]
  end

  def create_user_detail
    UserDetail.find_or_create_by!(
      :user_id => self.id,
      :contact_name => self.name,
      :email => self.email
    )
  end
end
