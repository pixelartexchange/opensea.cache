# Units of Time (Timstamp, Timedelta)


units-time library / gem - units of time (in epoch time) incl. seconds, minutes, hours, days, weeks, fortnights, years and more

* home  :: [github.com/s6ruby/units-time](https://github.com/s6ruby/units-time)
* bugs  :: [github.com/s6ruby/units-time/issues](https://github.com/s6ruby/units-time/issues)
* gem   :: [rubygems.org/gems/units-time](https://rubygems.org/gems/units-time)
* rdoc  :: [rubydoc.info/gems/units-time](http://rubydoc.info/gems/units-time)


## Usage

[Timestamp](#timestamp) • [Timedelta](#timedelta)


The following methods are added on `Integer` (`Fixnum` and `Bignum`)
and always return a `Timedelta` object (in seconds):

``` ruby
# plural versions
2.seconds       #=> <Timedelta seconds=2>
2.secs          #=> <Timedelta seconds=2>
3.minutes       #=> <Timedelta seconds=180>
3.mins          #=> <Timedelta seconds=180>
4.hours         #=> <Timedelta seconds=14_400>
5.days          #=> <Timedelta seconds=432_000>
6.weeks         #=> <Timedelta seconds=3_628_800>
7.fortnights    #=> <Timedelta seconds=8_467_200>
8.years         #=> <Timedelta seconds=252_288_000>

# singular versions
1.second        #=> <Timedelta seconds=1>
1.sec           #=> <Timedelta seconds=1>
1.minute        #=> <Timedelta seconds=60>
1.min           #=> <Timedelta seconds=60>
1.hour          #=> <Timedelta seconds=3600>
1.day           #=> <Timedelta seconds=86_400>
1.week          #=> <Timedelta seconds=604_800>
1.fortnight     #=> <Timedelta seconds=1_209_600>
1.year          #=> <Timedelta seconds=31_536_000>
```


### Time arithmetics

You can add and subtract durations from `Timestamp` or `Timedelta` objects.

``` ruby
Timestamp.now + 2.hours      #=> <Timestamp seconds= >
1.week + 1.day               #=> <Timedelta seconds= >
2.minutes - 1.second         #=> <TimeDelta seconds= >
```

Note: You CANNOT add or subtract integers to `Timestamp` or `Timedelta` objects
and vice versa.

``` ruby
# Bad
10 + 1.minute   #=> Boom! <TypeError>
1.minute + 10   #=> Boom! <TypeError>

# Good
10.seconds + 1.minute   #=> <Timedelta seconds=70>
1.minute.to_i + 10      #=> Integer
```

Note: Multiply an integer with `1.hour` or `1.minute` or `1.second` and so on
to convert to a time unit.

``` ruby
100*1.hour              #=> <Timedelta seconds=360_000>
```


### Timestamp

The `Timestamp` class holds the time in seconds since unix epoch time (that is, January 1st, 1970).

``` ruby
Timestamp.new(0)   # or Timestamp(0)
```

To get the time now use:

``` ruby
Timestamp.now      # or Timestamp.new
```



### Timedelta

The `Timedelta` class holds a time duration in seconds.

``` ruby
Timedelta.new     # or Timedelta(0)
```




## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The `units-time` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the [wwwmake forum](http://groups.google.com/group/wwwmake).
Thanks!
