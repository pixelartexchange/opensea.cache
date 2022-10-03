#############
#  build report pages from (cached) datasets)
#  to run use:
#
#  $ ruby sandbox/reports.rb

$LOAD_PATH.unshift( "../../pixelart/artbase/artbase-opensea/lib" )
require 'artbase-opensea'


report = Opensea::TimlineCollectionsReport.new( './ethereum' )
report.save( './ethereum/README.md' )

report = Opensea::TimlineCollectionsReport.new( './openstore' )
report.save( './openstore/README.md' )


report = Opensea::CollectionsReport.new( './ethereum' )
report.save( './ethereum/COLLECTIONS.md' )

report = Opensea::CollectionsReport.new( './openstore' )
report.save( './openstore/COLLECTIONS.md' )


report = Opensea::TopCollectionsReport.new( './ethereum' )
report.save( './ethereum/TOP.md' )

report = Opensea::TopCollectionsReport.new( './openstore' )
report.save( './openstore/TOP.md' )


report = Opensea::TrendingCollectionsReport.new( './ethereum' )
report.save( './ethereum/TRENDING.md' )

report = Opensea::TrendingCollectionsReport.new( './openstore' )
report.save( './openstore/TRENDING.md' )



puts "bye"
