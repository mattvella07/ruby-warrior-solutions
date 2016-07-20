class Player
    def play_turn(warrior)
        if @set.nil?
            @directions = [:forward, :backward, :right, :left]
            @set = true
        end
        
        if @directions.length > 0
            @directions.each do |i|
                @directions.delete(i)
                if warrior.feel(i).captive?
                    warrior.rescue!(i)
                    break
                else
                    warrior.bind!(i)
                    break
                end
            end
        else
            if warrior.feel(warrior.direction_of_stairs).empty?
                warrior.walk!(warrior.direction_of_stairs)
            else
                warrior.attack!(warrior.direction_of_stairs)
            end
        end
    end
end
