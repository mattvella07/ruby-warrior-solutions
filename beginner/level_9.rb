class Player
    def play_turn(warrior)
        @pivot = false
        @shoot = false
        warrior.look(:backward).each do |i| 
            if String.try_convert("#{i}") == 'Archer' or String.try_convert("#{i}") == 'Wizard'
                @pivot = true
            end
        end
        warrior.look.each do |i| 
            if String.try_convert("#{i}") == 'Archer' or String.try_convert("#{i}") == 'Wizard' or String.try_convert("#{i}") == 'Thick Sludge'
                @shoot = true
            end
        end
        if @pivot or @rescued
            @rescued = false 
            warrior.pivot!
        elsif @shoot
            warrior.shoot!
        elsif warrior.feel.captive?
            @rescued = true
            warrior.rescue!
        elsif warrior.feel.empty?
            if warrior.health >= @health and warrior.health < 20
                warrior.rest!
            elsif warrior.health < @health  
                warrior.shoot!
            else
                warrior.walk! 
            end
        else 
            warrior.attack!
        end
        @health = warrior.health
    end
end
