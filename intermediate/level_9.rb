class Player
    def play_turn(warrior)
        @direction = ''
        warrior.listen.each do |i|
            if String.try_convert("#{i}") == 'Captive' and i.ticking?
                @direction = warrior.direction_of(i)
                @tooClose = warrior.distance_of(i) <= 2
                break 
            end
        end
        if warrior.listen.empty?
            warrior.walk!(warrior.direction_of_stairs)   
        elsif !@direction.nil? and @direction != '' and warrior.feel(@direction).empty?
            if warrior.health < 20 and warrior.health >= @health and !@tooClose
                warrior.rest!
            else    
                @assigned = false
                warrior.walk!(@direction)
            end
        elsif !@direction.nil? and @direction != '' and warrior.feel(@direction).captive?
            warrior.rescue!(@direction)
            
        elsif !@direction.nil? and @direction != ''        
            if @assigned.nil? or !@assigned 
                @otherDirections = [:forward, :backward, :left, :right]
                @assigned = true 
            end
            @attack = true
            @otherDirections.delete(@direction)
            @otherDirections.each do |x|
                if !warrior.feel(x).empty? and !warrior.feel(x).wall?
                    @attack = false
                    @otherDirections.delete(x)
                    warrior.bind!(x)
                    break
                end
            end
            if @attack and warrior.health < 20 and warrior.health >= @health
                warrior.rest!
            elsif @attack and warrior.health > 8 and !@tooClose
                warrior.detonate!(@direction)
            elsif @attack
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
