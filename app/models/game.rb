class Game
  attr_reader :frame_number, :frame, :error_message

  def initialize(params, frame)
    @frame = frame.nil? ? [nil] : frame
    @ball1 = params[:ball1].to_i if params[:ball1]
    @ball2 = params[:ball2].to_i if params[:ball2]
    frame_number
  end

  def frame_number
    @frame_number ||= valid? ? frame.size : frame.size - 1
  end

  def calc
    @frame[frame_number] = {spare: spare?, strike: strike?, score: calc_frame_score}
  end

  def total
    @frame.inject(0){|rez, item| item ? rez + item[:score] : rez }
  end

  def over?
    frame_number >= 10 + (frame_number == 10 && (strike? || spare?)  ? 1 : 0)
  end

  def strike?
    @ball1 == 10
  end

  def spare?
    @ball1 + @ball2 == 10
  end

  def valid?
    @valid ||= begin
      @error_message = ''
      if !@ball1 || !in_range(@ball1)
        @error_message = 'The 1st ball knocked wrong number of pins'
        return
      end
      if (!strike? && !@ball2) || !in_range(@ball2)
        @error_message = 'The 2nd ball knocked wrong number of pins'
        return
      end
      if !strike? && !in_range(@ball1 + @ball2)
        @error_message = 'The sum of knocked pins is wrong'
        return
      end
      true
    end
  end

  private
  def calc_frame_score
    prev_frame = frame[frame_number - 1]
    if prev_frame && (prev_frame[:strike] || prev_frame[:spare])
      frame[frame_number - 1][:score] = 10 + @ball1 + (prev_frame[:strike] ? @ball2 : 0)
    end
    @ball1 + @ball2
  end

  def in_range(num)
    (0..10) === num
  end

end