#############
#  check collection datasets
#  to run use:
#
#  $ ruby sandbox/check.rb

require 'cocos'




def check_slugs( q )
  recs = read_csv( './collections.csv' )
  # pp recs

  puts "  #{recs.size} collection(s)"

  slugs = recs.map { |rec| rec['slug'] }
  slugs = slugs.sort    ## sort a-z
  ## pp slugs

  missing_slugs = []
  q.each do |slug|
     if slugs.include?( slug )
        puts "  OK #{slug}"
     else
        puts "!! >#{slug}< not found"
        missing_slugs << slug
     end
  end


  if missing_slugs.size > 0
    puts "!! WARN: #{missing_slugs.size} slug(s) not found:"
    pp missing_slugs
  else
    puts "OK - all #{q.size} slug(s) found / present"
  end

  missing_slugs
end





slugs = %w[
  halloweenpunks-here
  cryptopepepunks
  theedgepunks
  theaussies
  haunted-punks-666
]



check_slugs( slugs )


puts "bye"
