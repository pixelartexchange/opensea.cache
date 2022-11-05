#############
#  download / cache opensea collection data via api
#  to run use:
#
#  $ ruby sandbox/download.rb



$LOAD_PATH.unshift( "../../pixelart/artbase/artbase-opensea/lib" )
require 'artbase-opensea'


# CHROME_PATH = 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'
# OpenSea::Puppeteer.chrome_path = CHROME_PATH


## add / try a lookup by contract - why? why not?
##  see https://docs.opensea.io/reference/retrieving-a-single-contract


##
## add / try a update stats query  - why? why not?
##    see https://docs.opensea.io/reference/retrieving-collection-stats
##
##   same as stats section in collection???



cache_dir = ->(data) { if data['primary_asset_contracts'].size > 0
                         './ethereum'    ## assume ethereum contract
                       else
                         './openstore'   ## assume openstore (opensea shared ethereum) contract
                       end
                     }

cache = OpenSea::Cache.new( cache_dir )


recs = read_csv( './collections.csv' )
puts "  #{recs.size} collection(s)"

slugs = recs.map { |rec| rec['slug'] }
slugs = slugs.sort    ## sort a-z




slugs = %w[

  luckyirish
  thepharaohs7000
  the-californians-nft
  thegreeksnft
  theeuropeansnft

]

# cache.download( slugs, :stats )
cache.download( slugs )


puts "bye"
