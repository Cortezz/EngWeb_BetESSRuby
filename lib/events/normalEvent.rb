$LOAD_PATH << '.'
require_relative 'event'
require 'ostruct'

module Events

   class NormalEvent < Event

      attr_accessor :odd1
      attr_accessor :odd2
      attr_accessor :drawOdd

      def initialize (id, descr, bookie, odd1, odd2, drawOdd)
         super(id,descr,bookie)
         @odd1 = odd1
         @odd2 = odd2
         @drawOdd = drawOdd
      end

      # Returns a list with all of the odds of a Normal Event (1|X|2).
      def displayOdds
         result = Array.new
         # Home win
         homeWin = OpenStruct.new
         homeWin.desc = "1 - "
         homeWin.odd = @odd1
         # Away win
         awayWin = OpenStruct.new
         awayWin.desc = "2 - "
         awayWin.odd = @odd2
         # Draw
         draw = OpenStruct.new
         draw.desc = "X -"
         draw.odd = @drawOdd

         result.push(homeWin)
         result.push(draw)
         result.push(awayWin)
         result
      end

      # Returns the odd for a specific outcome of a NormalEvent (1/X/2).
      def getSpecificOdd (opt)
         case opt
            when 1 then @odd1
            when 2 then @odd2
            when 0 then @drawOdd
            else -1
         end
      end

      #  When called upon in this subclass (NormalEvent),
      # the list will contain the new odds for Home win, draw and away win, respectively.
      def changeOdds(list)
         @odd1 = list[0]
         @odd2 = list[2]
         @drawOdd = list[1]
         ### NOTIFY OBSERVERS
      end

      def toString
         s = "Normal Event (1|X|2)\n"
         s << super
         s << "1 - " << @odd1.to_s << "\n"
         s << "X - " << @drawOdd.to_s << "\n"
         s << "2 - " << @odd2.to_s << "\n"
         s
      end
   end

end
