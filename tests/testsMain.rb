$LOAD_PATH << '.'
############ USERS TESTS ##########
require_relative './users/user_tests'
require_relative './users/admin_tests'
require_relative './users/bookie_tests'
require_relative './users/punter_tests'
require_relative './users/userList_tests'
###################################


##Test Suite
require 'test/unit/testsuite'
