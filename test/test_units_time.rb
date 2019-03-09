# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_units_time.rb


require 'helper'


class TestUnitsTime < MiniTest::Test

def test_time
  now = Time.now.to_i

  assert_equal 31_536_000,      1.year
  assert_equal 31_536_000,      1.y
  assert_equal 31_536_000*2,    2.years
  assert_equal 31_536_000*2,    1.y*2
  assert_equal now+31_536_000,  now+1.year
  assert_equal 31_536_000,      365.days
  assert_equal 31_536_000,      365*24.hours

  assert_equal 1_209_600,     1.fortnight
  assert_equal 1_209_600*2,   2.fortnights
  assert_equal 1_209_600*2,   1.fortnight*2
  assert_equal now+1_209_600, now+1.fortnight
  assert_equal 1_209_600,     2.weeks
  assert_equal 1_209_600,     14.days
  assert_equal 1_209_600,     14*24.hours

  assert_equal 604_800,       1.week
  assert_equal 604_800,       1.w
  assert_equal 604_800*2,     2.weeks
  assert_equal 604_800*2,     1.week*2
  assert_equal now+604_800,   now+1.week
  assert_equal 604_800,       7.days
  assert_equal 604_800,       7*24.hours

  assert_equal 86_400,     1.day
  assert_equal 86_400,     1.d
  assert_equal 86_400*2,   2.days
  assert_equal 86_400*2,   1.day*2
  assert_equal now+86_400, now+1.day
  assert_equal 86_400,     24.hours
  assert_equal 86_400,     24*1.hour

  assert_equal 3600,     1.hour
  assert_equal 3600,     1.h
  assert_equal 3600*2,   2.hours
  assert_equal 3600*2,   1.hour*2
  assert_equal now+3600, now+1.hour
  assert_equal 3600,     60.minutes
  assert_equal 3600,     60*1.minute

  assert_equal 60,       1.minute
  assert_equal 60,       1.min
  assert_equal 60,       1.m
  assert_equal 60*2,     2.minutes
  assert_equal 60*2,     2.mins
  assert_equal 60*2,     1.minute*2
  assert_equal now+60,   now+1.minute
  assert_equal 60,       60.seconds
  assert_equal 60,       60*1.second

  assert_equal 1,     1.second
  assert_equal 1,     1.sec
  assert_equal 1,     1.s
  assert_equal 1*2,   2.seconds
  assert_equal 1*2,   2.secs
  assert_equal 1*2,   1.second*2
  assert_equal now+1, now+1.second
end

end # class TestUnitsTime
