require_relative 'base_decorator'

class TrimmerDecorator < BaseDecorator
  def correct_name
    name = @nameable.correct_name
    name[0..10]
  end
end
