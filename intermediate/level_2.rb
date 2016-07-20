class Player
    def play_turn(warrior)
        if warrior.feel(warrior.direction_of_stairs).empty?
            warrior.walk!(warrior.direction_of_stairs) 
        else 
            warrior.attack!(warrior.direction_of_stairs)    
        end
    end
end
