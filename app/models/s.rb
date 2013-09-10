class S < ActiveRecord::Base
  self.table_name = 'sites'
  has_many :site_pages
  has_many :site_posts
end
