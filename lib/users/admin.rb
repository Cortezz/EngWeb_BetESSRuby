$LOAD_PATH << '.'
require "user"

class Admin < User

    def initialize (name, email, pwd, coco)
      super(name,email,pwd)
    end

end
