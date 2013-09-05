class Player
    DYING_HEALTH = 9
    MAX_HEALTH = 20

  def initialize
      @last_health = MAX_HEALTH
  end

  def play_turn(warrior)
    # add your code here
    @state = 16
    @w = warrior
    next_action = Array(pick)
    until next_action.first.to_s.end_with? "!"
        update next_action
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
        :rest!
    when 8
        [:walk!, :backward]
    when 9
        [:feel, :backward]
    when 10
        :health
    when 11
        :health
    when 12
        :rescue!
    when 13
        :feel
    when 14
        [:feel, :backward]
    when 15
        [:rescue!, :backward]
    when 16
        :feel
    when 17
        :pivot!
    end
  end

  def perform action
    if action.length > 1
        @w.send action.first, action[1]
    else
        @w.send action.first
    end
  end

  def update action
    value = perform action
    case @state
    when 2
        @state = value.empty? ? 1 : 3
    when 4
        @state = injured?(value) ? 6 : 2
    when 5
        @state = value.empty? ? 4 : 3
    when 9
        @state = value.wall? ? 7 : 8
    when 10
        @state = dying?(value) ? 9 : 11
    when 11
        @state = taking_damage?(value) ? 2 : 5
    when 13
        @state = value.captive? ? 12 : 10
    when 14
        @state = value.captive? ? 15 : 13
    when 16
        @state = value.wall? ? 17 : 14
    end
  end

  def injured? value
      value < MAX_HEALTH
  end

  def dying? value
      value < DYING_HEALTH
  end

  def taking_damage? value
      value < @last_health
  end

end
