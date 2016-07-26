class Player
    def play_turn(warrior)
        if warrior.listen.empty?
            warrior.walk!(warrior.direction_of_stairs)
        elsif warrior.feel(warrior.direction_of(warrior.listen.first)).empty?
            if warrior.health < 20 and warrior.health >= @health 
                warrior.rest!
            else    
                warrior.walk!(warrior.direction_of(warrior.listen.first))
            end
        elsif warrior.feel(warrior.direction_of(warrior.listen.first)).captive?
            warrior.rescue!(warrior.direction_of(warrior.listen.first))
        else
            if warrior.health < 10
                warrior.walk!(:backward)
            else
                warrior.attack!(warrior.direction_of(warrior.listen.first))
            end
        end
        @health = warrior.health
    end
end
