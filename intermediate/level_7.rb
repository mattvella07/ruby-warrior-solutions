class Player
    def play_turn(warrior)
        @direction = ''
        warrior.listen.each do |i|
            if String.try_convert("#{i}") == 'Captive' and i.ticking?
                @captive = i
                @direction = warrior.direction_of(i)
                break 
            end
        end
        if warrior.listen.empty?
            warrior.walk!(warrior.direction_of_stairs)   
        elsif !@direction.nil? and @direction != '' and warrior.feel(@direction).empty?
            if warrior.health < 20 and warrior.health >= @health and !@captive.ticking?
                warrior.rest!
            else    
                warrior.walk!(@direction)
            end
        elsif !@direction.nil? and @direction != '' and warrior.feel(@direction).captive?
            warrior.rescue!(@direction)
        elsif !@direction.nil? and @direction != ''
            if @assigned.nil? 
                @otherDirections = [:forward, :backward, :left, :right]
                @assigned = true 
            end
            @attack = true
            @otherDirections.delete(@direction)
            @otherDirections.each do |x|
                if !warrior.feel(x).empty?
                    @attack = false
                    @otherDirections.delete(x)
                    warrior.bind!(x)
                    break
                end
            end
            if @attack
                warrior.attack!(@direction)
            end
        else
            if warrior.feel(warrior.direction_of(warrior.listen.first)).empty?
                if warrior.health < 20 and warrior.health >= @health
                    warrior.rest!
                else
                    warrior.walk!(warrior.direction_of(warrior.listen.first))
                end
            elsif warrior.feel(warrior.direction_of(warrior.listen.first)).captive?
                warrior.rescue!(warrior.direction_of(warrior.listen.first))
            else
                warrior.attack!(warrior.direction_of(warrior.listen.first))
            end
        end
        @health = warrior.health
    end
end
