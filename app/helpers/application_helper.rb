module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end
  
   def truncate_with_more (text, cutoff) 
        if text.length > cutoff 
          result = text[0, cutoff] 
        else 
              result = text 
        end 
       
        result 
  end 
end
