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
  high-effort-punks
  histopunks
  kimono-punks
  mafia-punks-club
  monkepunks
  onlypunksnft
  pixel-gals
  pixelmeows
  punkoftheday
  scifipunks
  the-pixel-portraits-og
  the-pixel-portraits
  thecryptogenius
  unofficialpunks
  weape24
  wow-pixies-v2
]


slugs = %w[
  wunks
  youtubepunks
]


cache_dir = ->(data) { if data['primary_asset_contracts'].size > 0
                         './ethereum'    ## assume ethereum contract
                       else
                         './openstore'   ## assume openstore (opensea shared ethereum) contract
                       end
                     }

cache = OpenSea::Cache.new( cache_dir )
cache.download( slugs, :stats )


puts "bye"
