class Player
    DYING_HEALTH = 9
    MAX_HEALTH = 20
    
  def play_turn(warrior)
    # add your code here
    @state = 4
    @w = warrior
    next_action = Array(pick)
    until next_action.first.to_s.end_with? "!"
        update next_action.first
        next_action = Array(pick)
    end
    perform next_action
    @last_health = @w.health
  end

  def pick
    case @state
    when 1
        :walk!
    when 2
        :feel
    when 3
        :attack!
    when 4
        :health
    when 5
        :feel
    when 6
        :rest!
    when 7
        :health
    when 8
        :health
    when 9
        :rest!
    when 10
        :health
    when 11
        [:walk!, :backward]
    end
  end

  def perform action
    @w.send action.first, action[1..-1]
  end

  def update action
    value = @w.send action
    case @state
    when 2
        @state = value.empty? ? 1 : 3
    when 4
        @state = injured?(value) ? 5 : 2
    when 5
        @state = value.empty? ? 6 : 3
    end
  end

  def dying? value
      value < DYING_HEALTH
  end

  def injured? value
      value < MAX_HEALTH
  end

  def last_health
      @last_health || MAX_HEALTH
  end

  def taking_damage? value
      last_health > value
  end

end
