#encoding: utf-8
class FaqCate < ActiveRecord::Base
	has_many :faq_items

	validates_presence_of :name
  validates_uniqueness_of :name

  #typo分类 - 主要用于区别某些内部技术教程私密的；某些是使用教程公开的。
  TYPO = ['开发教程', '使用教程']
  def self.typos
  	TYPO
  end
  def self.typo_id(name)
  	TYPO.index(name)
  end

end
