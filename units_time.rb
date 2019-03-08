# encoding: utf-8

##
#  todo/fix: use module
##   use Timestamp and Timedelta classes etc.


class Integer

  ######################################
  ## note: there's NO month (for now)!!!
  ##   why?  month might be 28,29,30,31  days
  ##    use days e.g. 30.days or 31.days etc.

  HOUR_IN_SECONDS       =  60 * 60                # 60 minutes * 60 seconds
  DAY_IN_SECONDS        =  24 * HOUR_IN_SECONDS   # 24 hours * 60 * 60
  WEEK_IN_SECONDS       =   7 * DAY_IN_SECONDS    #  7 days * 24 * 60 * 60
  FORTNIGHT_IN_SECONDS  =  14 * DAY_IN_SECONDS    # 14 days * 24 * 60 * 60
  YEAR_IN_SECONDS       = 365 * DAY_IN_SECONDS    # 365 days * 24 * 60 * 60

  def second()    self; end
  def minute()    self * 60; end
  def hour()      self * HOUR_IN_SECONDS; end
  def day()       self * DAY_IN_SECONDS;  end
  def week()      self * WEEK_IN_SECONDS; end
  def fortnight() self * FORTNIGHT_IN_SECONDS; end
  def year()      self * YEAR_IN_SECONDS; end

  ########################################################
  ## alias - use alias or alias_method - why? why not?
  def seconds() second; end
  def secs()    second; end
  def sec()     second; end
  def s()       second; end

  def minutes() minute; end
  def mins()    minute; end
  def min()     minute; end
  def m()       minute; end

  def hours()   hour; end
  def h()       hour; end

  def days() day; end
  def d()    day; end

  def weeks() week; end
  def w()     week; end

  def fortnights() fortnight; end

  def years() year; end
  def y()     year; end

end # class Integer
