# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_units_time.rb


require 'helper'


class TestUnitsTime < MiniTest::Test

def test_timstamp
  now = Timestamp.now

  assert_equal Timestamp.new( now.to_i ), now

  assert_equal now+31_536_000.secs,  now+1.year
  assert_equal now+1_209_600.secs,   now+1.fortnight
  assert_equal now+604_800.secs,     now+1.week
  assert_equal now+86_400.secs,      now+1.day
  assert_equal now+3600.secs,        now+1.hour
  assert_equal now+60.secs,          now+1.minute
  assert_equal now+1.sec,            now+1.second

  assert_equal true,  now+1.second >  now
  assert_equal true,  now+1.second >= now
  assert_equal false, now+1.second <  now
  assert_equal false, now+1.second <= now
end


def test_timedelta
  assert_equal 31_536_000.secs,      1.year
  ## assert_equal 31_536_000,      1.y
  assert_equal 31_536_000.secs*2,    2.years
  assert_equal 31_536_000.secs*2,    1.year*2
  ## assert_equal 31_536_000*2,    1.y*2
  assert_equal 31_536_000.secs,      365.days
  assert_equal 31_536_000.secs,      24.hours*365  ## note: uses coerce for type coercion
  assert_equal 31_536_000.secs,      365*24.hours

  assert_equal 1_209_600.secs,     1.fortnight
  assert_equal 1_209_600.secs*2,   2.fortnights
  assert_equal 1_209_600.secs*2,   1.fortnight*2
  assert_equal 1_209_600.secs,     2.weeks
  assert_equal 1_209_600.secs,     14.days
  assert_equal 1_209_600.secs,     14*24.hours  ## note: uses coerce for type coercion
  assert_equal 1_209_600.secs,     24.hours*14

  assert_equal 604_800.secs,       1.week
  ## assert_equal 604_800,       1.w
  assert_equal 604_800.secs*2,     2.weeks
  assert_equal 604_800.secs*2,     1.week*2
  assert_equal 604_800.secs,       7.days
  assert_equal 604_800.secs,       7*24.hours  ## note: uses coerce for type coercion
  assert_equal 604_800.secs,       24.hours*7

  assert_equal 86_400.secs,     1.day
  ## assert_equal 86_400,     1.d
  assert_equal 86_400.secs*2,   2.days
  assert_equal 86_400.secs*2,   1.day*2
  assert_equal 86_400.secs,     24.hours
  assert_equal 86_400.secs,     24*1.hour  ## note: uses coerce for type coercion
  assert_equal 86_400.secs,     1.hour*24

  assert_equal 3600.secs,     1.hour
  ## assert_equal 3600,     1.h
  assert_equal 3600.secs*2,   2.hours
  assert_equal 3600.secs*2,   1.hour*2
  assert_equal 3600.secs,     60.minutes
  assert_equal 3600.secs,     60*1.minute  ## note: uses coerce for type coercion
  assert_equal 3600.secs,     1.minute*60

  assert_equal 60.secs,       1.minute
  assert_equal 60.secs,       1.min
  ## assert_equal 60,       1.m
  assert_equal 60.secs*2,     2.minutes
  assert_equal 60.secs*2,     2.mins
  assert_equal 60.secs*2,     1.minute*2
  assert_equal 60.secs,       60.seconds
  assert_equal 60.secs,       60*1.second  ## note: uses coerce for type coercion
  assert_equal 60.secs,       1.second*60

  assert_equal 1.sec,     1.second
  assert_equal 1.sec,     1.sec
  ## assert_equal 1,     1.s
  assert_equal 1.sec*2,   2.seconds
  assert_equal 1.sec*2,   2.secs
  assert_equal 1.sec*2,   1.second*2
end

def test_timedelta_ops
  assert_equal (31_536_000+1_209_600+604_800).secs, 1.year+1.fortnight+1.week

  now = Timestamp.now
  assert_equal Timedelta,         (100 * 1.hour).class
  assert_equal now+100*3600.secs, now + (100 * 1.hour)
  assert_equal Timestamp,         (now + (100 * 1.hour)).class

  assert_equal 2.weeks,           (now+2.weeks) - now
  assert_equal Timedelta,         ((now+2.weeks) - now).class
end

def test_conv
  assert_equal Timestamp.new(0), Timestamp(0)
  assert_equal Timedelta.new,    Timedelta(0)

  assert_equal Timestamp.zero, Timestamp(0)
  assert_equal Timedelta.zero, Timedelta(0)

  assert_equal 0.secs, Timedelta(0)
end

def test_zero
  assert_equal true, Timestamp(0).zero?
  assert_equal true, Timedelta(0).zero?

  assert_equal true, Timestamp.zero.zero?
  assert_equal true, Timedelta.zero.zero?

  assert_equal true, Timestamp.new(0).zero?
  assert_equal true, Timedelta.new(0).zero?

  assert_equal false, Timestamp.new(1).zero?
  assert_equal false, Timestamp.new.zero?
  assert_equal false, Timedelta.new(1).zero?
end

end # class TestUnitsTime
