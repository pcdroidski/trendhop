module BlogsHelper

  def delete_chars
    self.delete("!").delete("@").delete("#").delete("*").delete("(").delete(")")
  end
end
