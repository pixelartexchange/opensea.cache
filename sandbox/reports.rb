#############
#  build report pages from (cached) datasets)
#  to run use:
#
#  $ ruby sandbox/reports.rb

$LOAD_PATH.unshift( "../../pixelart/artbase/artbase-opensea/lib" )
require 'artbase-opensea'


report = Opensea::TrendingCollectionsReport.new
buf = report.build( './ethereum' )
write_text( "./ethereum/TRENDING.md", buf )

buf = report.build( './openstore' )
write_text( "./openstore/TRENDING.md", buf )



report = Opensea::TopCollectionsReport.new
buf = report.build( './ethereum' )
write_text( "./ethereum/TOP.md", buf )

buf = report.build( './openstore' )
write_text( "./openstore/TOP.md", buf )



report = Opensea::CollectionsReport.new
buf = report.build( './ethereum' )
write_text( "./ethereum/README.md", buf )

buf = report.build( './openstore' )
write_text( "./openstore/README.md", buf )


puts "bye"
