#############
#  download / cache opensea collection data via api
#  to run use:
#
#  $ ruby sandbox/download.rb



$LOAD_PATH.unshift( "../../pixelart/artbase/opensea-lite/lib" )
require 'opensea-lite'


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
  theedgepunks
  cryptofuks
  inversepunks-v2
  madcamels
  crypto-marcs
  non-fungible-league
  no-mad-nomads
  phunk-ape-origins
  proofofpepe
  punk-ape-yacht-club-v2
  punkin-spicies

  ether-birds-on-chain
  pecasso
]

# cache.download( slugs, :stats )
cache.download( slugs )


puts "bye"
