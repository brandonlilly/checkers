class String
  def style(code)
    "\033[#{code}m#{self}\033[0m"
  end
end
