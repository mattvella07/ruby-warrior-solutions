class Player
    def play_turn(warrior)
        @captive = false
        @wizard = false
        warrior.look.each do |i|
            if String.try_convert("#{i}") == 'Captive'
                @captive = true
            elsif String.try_convert("#{i}") == 'Wizard'
                @wizard = true
            end
        end
        if !@captive and @wizard
            warrior.shoot!
        elsif warrior.feel.empty?
            warrior.walk!
        elsif warrior.feel.captive?
            warrior.rescue!
        end
    end
end
