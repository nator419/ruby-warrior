class Player
    def play_turn(warrior)
        # add your code here
        if warrior.feel.empty?
            warrior.walk!
        end    
    end
end