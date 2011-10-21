module ApplicationHelper
  
  def home_selector(sortable, text)
    param = params[:menu_show].blank? ? "top" : params[:menu_show]
    # raise params[:menu_show].inspect
    css_id = sortable == param ? "active-selection" : nil
    if param == sortable
      link_to params.merge(:menu_show => sortable) do
        content_tag(:li, text, :id => css_id)
      end
    else
      link_to params.merge(:menu_show => sortable) do
        content_tag(:li, text)
      end      
    end
  end
  
end
