class Exception
  def full_backtrace
    ([self.to_s] + self.backtrace).join("\n")
  end
end
