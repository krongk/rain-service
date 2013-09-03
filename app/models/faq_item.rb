class FaqItem < ActiveRecord::Base
  belongs_to :faq_cate

  validates_presence_of :title
  validates_uniqueness_of :title, :scope => :faq_cate_id

  def generated_markeddown_content
    Markdowner.to_html(self.content, {:coderay => true })
  end

  def content=(desc)
    self[:content] = desc.to_s.rstrip
    self.markeddown_content = self.generated_markeddown_content
  end

end
