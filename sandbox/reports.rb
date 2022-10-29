#############
#  build report pages from (cached) datasets)
#  to run use:
#
#  $ ruby sandbox/reports.rb

$LOAD_PATH.unshift( "../../pixelart/artbase/artbase-opensea/lib" )
require 'artbase-opensea'

report = Opensea::CollectionsDataset.new( './ethereum' )
report.export( './ethereum/collections.csv' )

report = Opensea::CollectionsDataset.new( './openstore' )
report.export( './openstore/collections.csv' )



report = Opensea::TimelineCollectionsReport.new( './ethereum' )
report.save( './ethereum/README.md' )

report = Opensea::TimelineCollectionsReport.new( './openstore' )
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
