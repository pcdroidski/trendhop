module PostsHelper

  def delete_chars(trend)
    trend.delete("!").delete("@").delete("#").delete("*").delete("(").delete(")").delete("?").delete(".").delete(",").delete("<").delete(">").delete("/").delete('\\')
  end

end
