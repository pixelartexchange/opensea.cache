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
  aliens-vs-punks
  aloha-chi-chi-onchain
  onchainchopper

  dank-punks-v2
  dos-phunks-nft
  on-chain-death
  onchainpeople
  larvadickbutts
  cryptobabyteddies
  mad-masks
  long-live-kevin
  cryptofuks
  inversepunks-v2
  madcamels
  non-fungible-league
  no-mad-nomads
  proofofpepe
  punkin-spicies

  ether-birds-on-chain
  pecasso
]



check_slugs( slugs )


puts "bye"
