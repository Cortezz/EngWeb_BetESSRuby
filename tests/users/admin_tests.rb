require_relative '../../lib/users/admin'
require 'test/unit'

class Admin_Tests < Test::Unit::TestCase

   def setup
      @name = "Administrador"
      @email = "admin@gmail.com"
      @password = "aa12345"
      @a = Users::Admin.new(@name, @email,@password)
   end

   ## Getters tests
   def test_getAdminName1
      assert_equal(@a.name, @name)
   end

   def test_getAdminEmail1
      assert_equal(@a.email, @email)
   end

   def test_getAdminPassword1
      assert_equal(@a.password, @password)
   end
   ##########################
end
