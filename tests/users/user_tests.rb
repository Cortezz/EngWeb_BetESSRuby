require_relative '../../lib/users/user'
require 'test/unit'

class User_Tests < Test::Unit::TestCase

   def setup
      @name = "João"
      @email = "j@gmail.com"
      @password = "12345"
      @u = Users::User.new(@name, @email,@password)
   end

   ### Getters test
   def test_getEmail1
      assert_equal(@email, @u.getEmail)
   end

   def test_getPassword1
      assert_equal(@password, @u.getPassword)
   end

   def test_getName1
      assert_equal(@name, @u.getName)
   end

   ############ NOTIFICATIONS ####################

   ## pushNotification/amountOfNotifications tests
   def test_pushNotification1
      @u.pushNotification("Notification!")
      assert_equal(@u.amountOfNotifications,1)
   end

   def test_pushNotification2
      assert_equal(@u.amountOfNotifications,0)
   end

   def test_pushNotification3
      @u.pushNotification("Notification!")
      @u.pushNotification("Notification!")
      @u.pushNotification("Notification!")
      assert_equal(@u.amountOfNotifications,3)
   end

   ## removeNotifications/amountOfNotifications tests
   def test_removeNotifications1
      @u.pushNotification("Notification!")
      @u.removeNotifications
      assert_equal(@u.amountOfNotifications,0)
   end

   def test_removeNotifications2
      @u.pushNotification("Notification!")
      @u.pushNotification("Notification!")
      @u.pushNotification("Notification!")
      @u.removeNotifications
      assert_equal(@u.amountOfNotifications,0)
   end

   ## notificationList tests

   def test_notificationList1
      @u.pushNotification("Not1!")
      s = "List of notifications:\n"
      s << "Not1!\n"
      assert_equal(@u.notificationList, s)
   end

   def test_notificationList2
      s = "List of notifications:\n"
      assert_equal(@u.notificationList,s)
   end
   ###############################################

end
