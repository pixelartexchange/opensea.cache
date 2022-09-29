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
  thesaudis
  thejews-nft
  the-americans-nft
  cryptopunks
  official-v1-punks
  proof-moonbirds
  acclimatedmooncats
  chain-runners-nft

  24px
  anime-punks
  athletes-101
  basicboredapeclub
  beautiful-female-punks
  bladerunner-punks
  blockydoge
  blockydogeguilds
  bwpunks
  cinepunkss
  wastelandpunks
  clout-punks
  cryptoapes-official
  cryptogreats
  cryptoluxurypunks
  cryptomasterpiecez
  cryptowiener-4
  dogepunks-collection
  dooggies
  dubaipeeps
  figurepunks
  frontphunks
  genius-punks
  ghozalipunk
  goodbye-punks
]

# slugs = %w[
# ]


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

  data_payments = data['payment_tokens']
  data.delete( 'payment_tokens' )

  ## clean payment - remove keys:
  ##   - eth_price
  ##   - usd_price
  ##  - will change daily
  data_payments = data_payments.map do |payment|
                                        payment.delete( 'eth_price' )
                                        payment.delete( 'usd_price' )
                                        payment
                                    end

  ## clean collection  - remove deprecated (duplicate keys):
  ##  - dev_buyer_fee_basis_points
  ##  - dev_seller_fee_basis_points
  ##  - opensea_buyer_fee_basis_points
  ##  - opensea_seller_fee_basis_points
  ##  - payout_address
  data.delete( 'dev_buyer_fee_basis_points' )
  data.delete( 'dev_seller_fee_basis_points' )
  data.delete( 'opensea_buyer_fee_basis_points' )
  data.delete( 'opensea_seller_fee_basis_points' )
  data.delete( 'payout_address' )


  ## clean collection - remove deprecated (duplicate keys):
  ##   - dev_buyer_fee_basis_points
  ##   - dev_seller_fee_basis_points
  ##   - opensea_buyer_fee_basis_points
  ##   - opensea_seller_fee_basis_points
  ##   - buyer_fee_basis_points
  ##   - seller_fee_basis_points
  ##   - payout_address
  data_contracts = data_contracts.map do |contract|
                                    contract.delete( 'dev_buyer_fee_basis_points' )
                                    contract.delete( 'dev_seller_fee_basis_points' )
                                    contract.delete( 'opensea_buyer_fee_basis_points' )
                                    contract.delete( 'opensea_seller_fee_basis_points' )
                                    contract.delete( 'buyer_fee_basis_points' )
                                    contract.delete( 'seller_fee_basis_points' )
                                    contract.delete( 'payout_address' )
                                    contract
                                      end



  cache_dir = if data_contracts.size > 0
                 './ethereum'    ## assume ethereum contract
              else
                 './openstore'   ## assume openstore (opensea shared ethereum) contract
              end


  path = "#{cache_dir}/#{slug}/collection.json"
  write_json( path, data )

  ## note: only save if contracts present  - why? why not?
  if data_contracts.size > 0
    path = "#{cache_dir}/#{slug}/contracts.json"
    write_json( path, data_contracts )
  end

  ## FileUtils.remove_file( "#{cache_dir}/#{slug}/traits.json" )

  if data_traits.size > 0
    path = "#{cache_dir}/#{slug}/traits.json"
    write_json( path, data_traits )
  end


  path = "#{cache_dir}/#{slug}/stats.json"
  write_json( path, data_stats )


  path = "#{cache_dir}/#{slug}/payments.json"
  write_json( path, data_payments )


  puts "  sleeping #{delay_in_s}s..."
  sleep( delay_in_s )
end

puts "bye"
