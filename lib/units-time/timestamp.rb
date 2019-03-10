# encoding: utf-8


class Timestamp

  def self.now() new( Time.now.to_i ); end

  attr_reader :seconds

  def initialize( seconds=Time.now.to_i )
    @seconds = seconds    ## seconds since Jan 1st, 1970 (unix epoch time)
  end

  def ==( other )
    if other.is_a?( self.class )
      @seconds == other.seconds
    else
      false
    end
  end
  alias_method :eql?, :==

  def +( other )
    if other.is_a?( Timedelta )
      self.class.new( @seconds + other.seconds )
    else
      raise TypeError.new( "[Timestamp] add(ition) - wrong type >#{other.inspect}< #{other.class.name} - Timedelta expected" )
    end
  end

  def -( other )
    if other.is_a?( Timedelta )
      self.class.new( @seconds - other.seconds )
    else
      raise TypeError.new( "[Timestamp] sub(straction) - wrong type >#{other.inspect}< #{other.class.name} - Timedelta expected" )
    end
  end


  include Comparable

  def <=>( other )
    if other.is_a?( self.class )
      @seconds <=> other.seconds
    else
      raise TypeError.new( "[Timestamp] <=> - wrong type >#{other.inspect}< #{other.class.name} - Timestamp expected" )
    end
  end


  ## todo/fix: always freeze by default (timestamp is immutable) - why? why not?
  def self.zero()  @@zero ||= new(0).freeze; end

  alias_method :to_i,   :seconds     ## add to integer conversion - why? why not?
  alias_method :to_int, :seconds
end  ## class Timestamp
