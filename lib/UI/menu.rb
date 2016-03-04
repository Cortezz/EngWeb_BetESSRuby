module UI

   class Menu

      attr_reader :option

      def initialize(lines)
         @lines = lines
         @option = 0
      end


      ############
      def showMenu
         i = 1
         puts "##############################"
         @lines.each do |line|
            puts "#{i} - #{line}"
            i = i+1
         end
         puts "0 - Leave\n"
         puts "---------\nOption:"
      end


      def executeMenu
         @option=-1
         while @option==-1
            showMenu
            line = gets.chop
            @option = Integer(line)
            puts "##############################"
         end
      end



   end


end
