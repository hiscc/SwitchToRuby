module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes['style'] = 'display: none'
    end
    content_tag('div', attributes, &block)
  end

  def page_title
     @page_title || 'PAGE TITLE'
  end

end
