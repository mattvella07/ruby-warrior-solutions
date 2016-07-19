class Player
    def play_turn(warrior)
        if warrior.feel.wall?
            warrior.pivot!
        elsif warrior.feel.empty?
            if !@health.nil? and warrior.health < @health and warrior.health < 14
                warrior.walk!(:backward)
            elsif warrior.health < 20 and warrior.health >= @health
                warrior.rest! 
            else
                warrior.walk!
            end
        else
            warrior.attack!
        end
        @health = warrior.health
    end
end
