$LOAD_PATH << '.'
############ USERS TESTS ##########
require_relative './users/user_tests'
require_relative './users/admin_tests'
require_relative './users/bookie_tests'
require_relative './users/punter_tests'
require_relative './users/userList_tests'
############ BET TESTS ############
require_relative './bets/bet_tests'
require_relative './bets/betList_tests'
############ BET ESS ##############
require_relative 'facade_tests'



##Test Suite
require 'test/unit/testsuite'
