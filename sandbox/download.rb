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


slugs = %w[
  pixel-goblintown
  morepunks
  galacticaliensocialclub
  binaryapes
  eightbitme
]

slugs = %w[
  thesaudis
  thejews-nft
  the-americans-nft
]


delay_in_s = 2

slugs.each do |slug|

  puts
  puts "==> fetching #{slug}..."

  raw = Opensea.collection( slug )

  ## note: simplify result
  ##  remove nested 'collection' level

  data = raw['collection']

  ## remove editors  - do not care for now
  data.delete( 'editors' )


  data_contracts = data['primary_asset_contracts']
  data.delete( 'primary_asset_contracts' )

  data_traits = data['traits']
  data.delete( 'traits')

  data_stats  = data['stats']
  data.delete( 'stats')

  data_payment = data['payment_tokens']
  data.delete( 'payment_tokens' )


  path = "./cache/#{slug}/collection.json"
  write_json( path, data )

  path = "./cache/#{slug}/contracts.json"
  write_json( path, data_contracts )

  path = "./cache/#{slug}/traits.json"
  write_json( path, data_traits )

  path = "./cache/#{slug}/stats.json"
  write_json( path, data_stats )

  path = "./cache/#{slug}/payment.json"
  write_json( path, data_payment )


  puts "  sleeping #{delay_in_s}s..."
  sleep( delay_in_s )
end

puts "bye"
