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
############ EVENTS TESTS #########
require_relative './events/normalEvent_tests'
############ SPORTS TESTS #########
require_relative './sports/football_tests'
require_relative './sports/sportsList_tests'
############ OBSERVER TESTS #######
require_relative './observer/BookieObserver_Tests'
############ FACADE ESS ###########
require_relative 'facade_tests'




##Test Suite
require 'test/unit/testsuite'
