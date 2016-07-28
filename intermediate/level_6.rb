class Player
    def play_turn(warrior)
        @direction = ''
        warrior.listen.each do |i|
            if String.try_convert("#{i}") == 'Captive'
                @direction = warrior.direction_of(i)
                break 
            end
        end
        if warrior.listen.empty?
            warrior.walk!(warrior.direction_of_stairs)
        elsif !@direction.nil? and @direction != '' and warrior.feel(@direction).empty?
            if warrior.health < 20 and warrior.health >= @health 
                warrior.rest!
            else    
                warrior.walk!(@direction)
            end
        elsif !@direction.nil? and @direction != '' and warrior.feel(@direction).captive?
            warrior.rescue!(@direction)
        elsif !@direction.nil? and @direction != '' and !warrior.feel(@direction).empty?
            @otherDirections = [:forward, :left, :right]
            @otherDirections.delete(@direction)
            @otherDirections.each do |i|
                if warrior.feel(i).empty?
                    warrior.walk!(i)
                    break
                end
            end
        else
            if warrior.feel(warrior.direction_of(warrior.listen.first)).empty?
                warrior.walk!(warrior.direction_of(warrior.listen.first))
            else
                warrior.attack!(warrior.direction_of(warrior.listen.first))
            end
        end
        @health = warrior.health
    end
end
