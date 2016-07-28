class Player
    def play_turn(warrior)
        @captiveCount = 0
        @sludgeCount = 0
        warrior.look.each do |i|
            if  String.try_convert("#{i}") == 'Sludge' or String.try_convert("#{i}") == 'Thick Sludge'
                @sludgeCount += 1 
            elsif String.try_convert("#{i}") == 'Captive'
                @captiveCount += 1
            end
        end
        if @sludgeCount > 0 and @captiveCount == 0 and !warrior.feel.empty?
            warrior.detonate!
        elsif warrior.feel.empty?
            warrior.walk!
        elsif warrior.feel.captive?
            warrior.rescue!
        end
    end
end
