# encoding: utf-8

## stdlibs
require 'pp'
require 'time'


## our own code
require 'units-time/version'    # note: let version always go first
require 'units-time/timestamp'
require 'units-time/timedelta'



#########################
# type constraints:
#
#   note: for now
#    - you CANNOT add a timestamp to another timestamp
#    - you CAN only compare (<=>) timestamp to timestamp but NOT timedelta !!
#    - you CAN only compare (<=>) timedelta to timedelta but NOT timestamp !!


### "global" Kernel converter functions use like
##    Timestamp(0) or Timedelta(0)
module Kernel
  def Timestamp(arg) Timestamp.new( arg ); end
  def Timedelta(arg) Timedelta.new( arg ); end
end


module TimeUnits

  def second()    Timedelta.seconds( self ); end
  def minute()    Timedelta.minutes( self ); end
  def hour()      Timedelta.hours( self ); end
  def day()       Timedelta.days( self );  end
  def week()      Timedelta.weeks( self ); end
  def fortnight() Timedelta.weeks( self * 2 ); end
  def year()      Timedelta.years( self ); end


  ########################################################
  ## alias
  alias_method :seconds, :second
  alias_method :secs,    :second
  alias_method :sec,     :second
  ## def s()       second; end     ### todo/fix: remove/add - why? why not?

  alias_method :minutes, :minute
  alias_method :mins,    :minute
  alias_method :min,     :minute
  ## def m()       minute; end    ### todo/fix: remove/add - why? why not?

  alias_method :hours,   :hour
  ## def h()       hour; end      ### todo/fix: remove/add - why? why not?

  alias_method :days,    :day
  ## def d()    day; end          ### todo/fix: remove/add - why? why not?

  alias_method :weeks,   :week
  ## def w()     week; end        ### todo/fix: remove/add - why? why not?

  alias_method :fortnights, :fortnight

  alias_method :years, :year
  ## def y()     year; end        ### todo/fix: remove/add - why? why not?
end  # module TimeUnits



class Integer
   include TimeUnits
end # class Integer
