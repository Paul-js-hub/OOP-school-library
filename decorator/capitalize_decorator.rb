require_relative 'base_decorator'

class CapitalizeDecorator < BaseDecorator
  def correct_name
    name = @nameable.correct_name
    name[0].upcase + name[1..]
  end
end
