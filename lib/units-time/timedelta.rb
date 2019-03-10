# encoding: utf-8


class Timedelta

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


  ## todo/fix: always freeze by default (timedelta is immutable) - why? why not?
  def self.zero()  @@zero ||= new(0).freeze; end

  alias_method :to_i,   :seconds     ## add to integer conversion - why? why not?
  alias_method :to_int, :seconds
  ## note: same as:
  ##  def to_i()   @seconds; end    ## add to integer conversion - why? why not?
  ##  def to_int() @seconds; end
end # class Timedelta
