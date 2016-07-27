class Player
    def play_turn(warrior)
        if !warrior.listen.first.nil?
            if warrior.direction_of_stairs == warrior.direction_of(warrior.listen.first)
                @directions = [:forward, :left, :right, :backward]
            else
                @directions = [warrior.direction_of(warrior.listen.first)]
            end
        end
        if warrior.listen.empty?
            warrior.walk!(warrior.direction_of_stairs)
        else warrior.direction_of_stairs == warrior.direction_of(warrior.listen.first)
            @directions.each do |i|
                if warrior.feel(i).empty? and !warrior.feel(i).stairs? and !warrior.feel(i).wall?
                    if warrior.health < 20 and warrior.health >= @health 
                        warrior.rest!
                    else    
                        warrior.walk!(i)
                    end
                    break
                elsif warrior.feel(i).captive?
                    warrior.rescue!(i)
                    break
                elsif !warrior.feel(i).stairs? and !warrior.feel(i).wall? and !warrior.feel(i).empty?
                    if warrior.health < 10
                        warrior.walk!(:backward)
                    else
                        warrior.attack!(i)
                    end
                    break
                end
            end
        end
        @health = warrior.health
    end
end
