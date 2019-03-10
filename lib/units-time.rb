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


### "global" converter functions use like
##    Timestamp(0)  or Timedelta(0)
def Timestamp(arg) Timestamp.new( arg ); end
def Timedelta(arg) Timedelta.new( arg ); end



module TimeUnits
  ######################################
  ## note: there's NO month (for now)!!!
  ##   why?  month might be 28,29,30,31  days
  ##    use days e.g. 30.days or 31.days etc.


  HOUR_IN_SECONDS       =  60 * 60                # 60 minutes * 60 seconds
  DAY_IN_SECONDS        =  24 * HOUR_IN_SECONDS   # 24 hours * 60 * 60
  WEEK_IN_SECONDS       =   7 * DAY_IN_SECONDS    #  7 days * 24 * 60 * 60
  FORTNIGHT_IN_SECONDS  =  14 * DAY_IN_SECONDS    # 14 days * 24 * 60 * 60

  #####
  #  note: for year use 365 days for now and NOT 365.25 (1/4)
  #    - why? why not? discuss
  YEAR_IN_SECONDS       = 365 * DAY_IN_SECONDS    # 365 days * 24 * 60 * 60

  def second()    Timedelta.new( self ); end
  def minute()    Timedelta.new( self * 60 ); end
  def hour()      Timedelta.new( self * HOUR_IN_SECONDS ); end
  def day()       Timedelta.new( self * DAY_IN_SECONDS );  end
  def week()      Timedelta.new( self * WEEK_IN_SECONDS ); end
  def fortnight() Timedelta.new( self * FORTNIGHT_IN_SECONDS ); end
  def year()      Timedelta.new( self * YEAR_IN_SECONDS ); end


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
