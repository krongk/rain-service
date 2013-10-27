class CommentForm < Liquid::Block
  include ActionView::Helpers::FormHelper
  Syntax = /(#{Liquid::VariableSignature}+)/

  def initialize(tag_name, markup, tokens)
    if markup =~ Syntax
      @variable_name = $1
      @attributes = {}
    else
      raise SyntaxError.new("Syntax Error in 'comment_form' - Valid syntax: comment_form [post]")
    end

    super
  end

  def render(context)
    post = context[@variable_name]

    context.stack do
      context['form'] = {
        'posted_successfully?' => context.registers[:posted_successfully],
        'errors' => context['site_comment.errors'],
        'mobile_phone' => context['site_comment.mobile_phone'],
        'email'  => context['site_comment.email'],
        'content'   => context['site_comment.content']
      }
      wrap_in_form(post, render_all(@nodelist, context))
    end
  end

  def wrap_in_form(post, input)
    %Q{<form accept-charset="UTF-8" id="comment-form" class="form-horizontal" method="post" action="/site_comments">
      <div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /></div>
      \n#{input}\n</form>
    }
  end
end
