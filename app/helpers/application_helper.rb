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

  def check_user?
    user_signed_in?
  end

  def list_trends(post)
    trend_list = []
    if (post.retrend_post_id == nil)
      post.trends.map do |trend|
        trend_list << "<a id='trend' href='#{url_for(trend_path(trend.name))}'>#{trend.name} </a>"
      end
    else
      repost = Post.where(:id => post.retrend_post_id).first
       repost.trends.map do |trend|
          trend_list << "<a id='trend' href='#{url_for(trend_path(trend.name))}'>#{trend.name} </a>"
        end
    end
    trend_list.to_sentence
  end

end
