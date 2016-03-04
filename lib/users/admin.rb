$LOAD_PATH << '.'
require_relative "user"


module Users
  class Admin < User

      def initialize (name, email, pwd)
        super(name,email,pwd)
      end

   end
end
