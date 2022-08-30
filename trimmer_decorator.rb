require_relative 'decorator'
class TrimmerDecorator < Decorator
  def correct_name
    string = @nameable.correct_name
    if string.length <= 10
      @nameable.correct_name
    else
      string[0..9]
    end
  end
end
