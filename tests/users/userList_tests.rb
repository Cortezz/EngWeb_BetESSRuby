require_relative '../../lib/users/userList'
require 'test/unit'

class UserList_Tests < Test::Unit::TestCase

   def setup
      @users = Users::UserList.new
      @email = "j@gmail.com"
      @bookieEmail = "b@gmail.com"
      @users.addPunter("user",@email,"12345")
      @users.addBookie("bookie", @bookieEmail, "b123")
   end

   ######### USERS ###########

   ## validateEmail tests
   def test_validateEmail1
      assert_equal(false, @users.validateEmail(@email))
   end

   def test_validateEmail2
      assert_equal(true, @users.validateEmail("aaaaaaa"))
   end

   ## checkCredentials tests
   def test_checkCredentials1
      assert_equal(true, @users.checkCredentials(@email,"12345"))
   end

   def test_checkCredentials2
      assert_equal(false, @users.checkCredentials(@email, "asdfasdf"))
   end

   def test_checkCredentials3
      assert_equal(false, @users.checkCredentials(@email, "1234 5"))
   end

   ########### NOTIFICATIONS ############

   ##pushNotificationTo tests
   def test_pushNotificationTo1
      @users.pushNotificationTo(@email, "Not!")
      u = @users.getUser(@email)
      assert_equal(u.amountOfNotifications,1)
   end

   ## amountOfNotificationsFrom tests
   def test_amountOfNotificationsFrom1
      assert_equal(@users.amountOfNotificationsFrom(@email),0)
   end

   def test_amountOfNotificationsFrom2
      @users.pushNotificationTo(@email, "Not!")
      assert_equal(@users.amountOfNotificationsFrom(@email),1)
   end

   def test_amountOfNotificationsFrom3
      @users.pushNotificationTo(@email, "Not!")
      @users.pushNotificationTo(@email, "Not!")
      @users.pushNotificationTo(@email, "Not!")
      @users.pushNotificationTo(@email, "Not!")
      assert_equal(@users.amountOfNotificationsFrom(@email),4)
   end

   def test_amountOfNotificationsFrom4
      assert_equal(@users.amountOfNotificationsFrom(@bookieEmail),0)
   end

   def test_notificationListFrom1
      s = "List of notifications:\n"
      assert_equal(@users.notificationListFrom(@email),s)
   end

   ## notificationListFrom tests
   def test_notificationListFrom2
      @users.pushNotificationTo(@email,"Not1!")
      s = "List of notifications:\n"
      s << "Not1!\n"
      assert_equal(@users.notificationListFrom(@email),s)
   end

   ## removeNotificationsFrom tests
   def test_removeNotificationsFrom1
      @users.removeNotificationsFrom(@email)
      assert_equal(@users.amountOfNotificationsFrom(@email),0)
   end

   ## removeNotificationsFrom tests
   def test_removeNotificationsFrom2
      @users.pushNotificationTo(@email,"Not1!")
      @users.removeNotificationsFrom(@email)
      assert_equal(@users.amountOfNotificationsFrom(@email),0)
   end

   ## removeNotificationsFrom tests
   def test_removeNotificationsFrom3
      @users.pushNotificationTo(@email,"Not1!")
      @users.pushNotificationTo(@email,"Not1!")
      @users.removeNotificationsFrom(@email)
      @users.pushNotificationTo(@email,"Not1!")
      assert_equal(@users.amountOfNotificationsFrom(@email),1)
   end
   ###########################

   ######### PUNTER #########

   ## addPunter tests
   def test_addPunter1
      @users.addPunter("aaa","bbb@","ccc")
      u = @users.getUser("bbb@")
      assert_equal("aaa", u.name)
   end

   def test_addPunter2
      assert_kind_of(Users::Punter,@users.getUser(@email), )
   end

   ## creditCoinsTo/DebitCoinsFrom/getBetESSCoinsFrom tests
   def test_creditCoinsTo1
      @users.creditCoinsTo(@email, 150)
      assert_equal(150, @users.getBetESSCoinsFrom(@email))
   end

   def test_debitCoinsFrom1
      @users.creditCoinsTo(@email, 150)
      @users.debitCoinsFrom(@email, 50)
      assert_equal(100, @users.getBetESSCoinsFrom(@email))
   end

   def test_debitCoinsFrom2
      @users.creditCoinsTo(@email, 150)
      @users.debitCoinsFrom(@email, 150)
      assert_equal(0, @users.getBetESSCoinsFrom(@email))
   end

   def test_getBetESSCoinsFrom1
      assert_equal(@users.getBetESSCoinsFrom(@email),0)
   end
   ################################

   ############ BOOKIE ############

   ## addBookie tests
   def test_addBookie1
      @users.addBookie("name","email","pwd")
      assert_kind_of(Users::Bookie, @users.getUser("email"))
   end

   ## addSubscribedEventTo/getSubscribedEventsFrom tests
   def test_getSubscribedEventsFrom1
      @users.addBookie("name","email","pwd")
      assert_equal(0,@users.getSubscribedEventsFrom("email").size())
   end


   def test_addSubscribedEventTo1
      @users.addBookie("name","email","pwd")
      @users.addSubscribedEventTo("email",2)
      events = @users.getSubscribedEventsFrom("email")
      assert_equal(true, events.include?(2))
   end

   ################################

   ########### ADMIN ##############

   ## addAdmin tests
   def test_addAdmin1
      @users.addAdmin("admin", "email", "12345")
      assert_kind_of(Users::Admin, @users.getUser("email"))
   end
   ################################
end
