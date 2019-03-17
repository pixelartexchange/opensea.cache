# encoding: utf-8


class Timedelta

  ######################################
  ## note: there's NO month (for now)!!!
  ##   why?  month might be 28,29,30,31  days
  ##    use days e.g. 30.days or 31.days etc.

  HOUR_IN_SECONDS       =  60 * 60                # 60 minutes * 60 seconds
  DAY_IN_SECONDS        =  24 * HOUR_IN_SECONDS   # 24 hours * 60 * 60
  WEEK_IN_SECONDS       =   7 * DAY_IN_SECONDS    #  7 days * 24 * 60 * 60
  ## FORTNIGHT_IN_SECONDS  =  14 * DAY_IN_SECONDS    # 14 days * 24 * 60 * 60

  #####
  #  note: for year use 365 days for now and NOT 365.25 (1/4)
  #    - why? why not? discuss
  YEAR_IN_SECONDS       = 365 * DAY_IN_SECONDS    # 365 days * 24 * 60 * 60

  def self.seconds( seconds ) new( seconds ); end
  def self.minutes( minutes ) new( minutes * 60 ); end
  def self.hours( hours )     new( hours * HOUR_IN_SECONDS ); end
  def self.days( days )       new( days * DAY_IN_SECONDS );  end
  def self.weeks( weeks )     new( weeks * WEEK_IN_SECONDS ); end
  def self.years( years )     new( years * YEAR_IN_SECONDS ); end


  attr_reader :seconds

  def initialize( seconds=0 )
    @seconds = seconds
  end


  def ==( other )
    if other.is_a?( self.class )
      @seconds == other.seconds
    else
      false
    end
  end
  alias_method :eql?, :==

  def *( other )
    if other.is_a?( Integer )
      self.class.new( @seconds * other )
    else
      raise TypeError.new( "[Timedelta] mul(tiplication) - wrong type >#{other.inspect}< #{other.class.name} - integer number expected" )
    end
  end

  def +( other )
    if other.is_a?( self.class )
      self.class.new( @seconds + other.seconds )
    else
      raise TypeError.new( "[Timedelta] add(ition) - wrong type >#{other.inspect}< #{other.class.name} - Timedelta expected" )
    end
  end

  def -( other )
    if other.is_a?( self.class )
      self.class.new( @seconds - other.seconds )
    else
      raise TypeError.new( "[Timedelta] sub(straction) - wrong type >#{other.inspect}< #{other.class.name} - Timedelta expected" )
    end
  end


  ### for details on coerce
  ##   see https://blog.dnsimple.com/2017/01/ruby-coercion-protocols-part-2/
  ##   and http://wiki.c2.com/?RubyCoerce
  ##
  ## note: just switch left and right will NOT work with subtraction
  ##   e.g. 2+3.seconds  == 3.seconds+2  BUT
  ##        2-3.seconds  != 3.seconds-2  !!!!!

  ## note: safe integer used for coerce dispatch
  class SafeInteger
    def initialize( value )
      @value = value
    end
    ## it's safe to swap left and right for multiplication (it's communicative)
    def *( other ) other.*( @value ); end
  end

  def coerce( other )
    if other.is_a?( Integer )
      [SafeInteger.new(other), self]
    else
      raise TypeError.new( "[Timedelta] coerce - wrong type >#{other.inspect}< #{other.class.name} - Integer number expected" )
    end
  end


  include Comparable

  def <=>( other )
    if other.is_a?( self.class )
      @seconds <=> other.seconds
    else
      raise TypeError.new( "[Timedelta] <=> - wrong type >#{other.inspect}< #{other.class.name} - Timedelta expected" )
    end
  end


  def zero?() self == self.class.zero; end  ## note: compares values (e.g. 0==0) - not object_id (or frozen) etc.

  ## todo/fix: always freeze by default (timedelta is immutable) - why? why not?
  def self.zero()  @@zero ||= new(0).freeze; end

  alias_method :to_i,   :seconds     ## add to integer conversion - why? why not?
  alias_method :to_int, :seconds
  ## note: same as:
  ##  def to_i()   @seconds; end    ## add to integer conversion - why? why not?
  ##  def to_int() @seconds; end
end # class Timedelta
