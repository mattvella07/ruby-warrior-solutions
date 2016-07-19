class Player
    def play_turn(warrior)
        if @rescued.nil? 
            if warrior.feel(:backward).empty?
                warrior.walk!(:backward)
            elsif warrior.feel(:backward).captive?
                @rescued = true
                warrior.rescue!(:backward)
            end
        elsif warrior.feel.empty?
            if !@health.nil? and warrior.health < @health and warrior.health < 14
                warrior.walk!(:backward)
            elsif warrior.health < 20 and warrior.health >= @health
                warrior.rest! 
            else
                warrior.walk!
            end
        elsif warrior.feel.captive?
            warrior.rescue!
        else
            warrior.attack!
        end
        @health = warrior.health
    end
end
