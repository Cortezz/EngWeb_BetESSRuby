$LOAD_PATH << '.'
require "user"

class Admin < User
    def initialize (name, email, pwd, coco)
      super(name,email,pwd)
      @caca = coco
    end

    def printCaca
      @caca
    end
    
end
