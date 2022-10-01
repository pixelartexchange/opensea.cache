#############
#  build a (cache) report page
#  to run use:
#
#  $ ruby sandbox/report.rb

$LOAD_PATH.unshift( "../../pixelart/artbase/artbase-opensea/lib" )
require 'artbase-opensea'



## check - move each_dir helper upstream to cocos - why? why not?
def each_dir( glob, exclude: [], &blk )
  dirs = Dir.glob( glob ).select {|f| File.directory?(f) }

  puts "  #{dirs.size} dir(s):"
  pp dirs

  dirs.each do |dir|
     basename = File.basename( dir )
     ## check for sandbox/tmp/i/etc.  and skip
     next if exclude.include?( basename )

     blk.call( dir )
  end
end




def fmt_date( date )
   date.strftime( '%b %d, %Y' )
end

def fmt_fees( basis )
   ## in basis point e.g. 100  => 1%
   ##                     250  => 2.5%
   ##                    1000  => 10%

   if basis == 0
      "-"
   else
      "#{'%.1f%%' % (basis/100.0)}"
   end
end


ETH_IN_USD = 1300.0

def fmt_eth( amount )
   if amount.nil?
      "???"
   elsif amount == 0.0
      "0"
   else
      usd = amount*ETH_IN_USD

      usd_str = if usd / 1_000_000 >= 1
                   "#{'%.1f' % (usd / 1_000_000)} million(s)"
                elsif usd >= 1000
                   "#{'%.0f' % usd}"
                else
                   "#{'%.2f' % usd}"
                end

      if amount >= 0.015
        "#{'Ξ%.2f' % amount} (~ US$ #{usd_str})"
      elsif amount >= 0.0015
        "#{'Ξ%.3f' % amount} (~ US$ #{usd_str})"
      else
        "Ξ#{amount} (~ US$ #{usd_str})"
      end
   end
end




class TrendingCollectionsReport

   Collection =  Struct.new(:thirty_day_volume,
                            :date,
                            :buf)


def build( root_dir )

   cols = []

each_dir( "#{root_dir}/*" ) do |dir|
   puts "==> #{dir}"

   meta = OpenSea::Meta::Collection.read( dir )

      date =  if meta.contracts.size > 0
                   meta.contracts[0].created_date
               else
                   meta.created_date
               end

   buf = String.new('')

   buf << "- "
   if meta.stats.thirty_day_sales > 0
      buf << " #{meta.stats.thirty_day_sales} in 30d - #{fmt_eth( meta.stats.thirty_day_volume )},"
      if meta.stats.seven_day_sales > 0
         buf << " #{meta.stats.seven_day_sales} in 7d - #{fmt_eth( meta.stats.seven_day_volume )},"
         if meta.stats.one_day_sales > 0
            buf << " #{meta.stats.one_day_sales} in 1d - #{fmt_eth( meta.stats.one_day_volume )},"
         else
            buf << " 0 in 1d "
         end
      else
         buf << " 0 in 7d/1d "
      end
   else
      buf << " 0 in 30d/7d/1d "
   end

   buf << " **[#{meta.stats.total_supply} #{meta.name} (#{fmt_date(date)}), #{fmt_fees( meta.fees.seller_fees )}](https://opensea.io/collection/#{meta.slug})**\n"
   buf << "   - owners: #{meta.stats.num_owners},"
   if meta.stats.total_sales > 0
     buf << "   sales:  #{meta.stats.total_sales}"
     buf << "   -  #{fmt_eth( meta.stats.total_volume )} @ "
     buf << "   price avg #{fmt_eth( meta.stats.average_price ) },"
     buf << "   floor #{fmt_eth( meta.stats.floor_price ) }"
   else
      buf << "   sales: 0"
   end
   buf << "\n"

   cols << Collection.new( meta.stats.thirty_day_volume, date, buf )

end
  cols = cols.sort do |l,r|
                     res = r.thirty_day_volume <=> l.thirty_day_volume
                     res = r.date <=> l.date   if res == 0
                     res
                   end

  buf = "# Trending Collections\n\n"
  buf +=  cols.map { |col| col.buf }.join( '' )
  buf
end
end   # class TrendingCollectionReport





class TopCollectionsReport

   Collection =  Struct.new(:total_volume, :buf)


def build( root_dir )

   cols = []

each_dir( "#{root_dir}/*" ) do |dir|
   puts "==> #{dir}"

   meta = OpenSea::Meta::Collection.read( dir )

      date =  if meta.contracts.size > 0
                   meta.contracts[0].created_date
               else
                   meta.created_date
               end

   buf = String.new('')

   buf << "- **[#{meta.stats.total_supply} #{meta.name} (#{fmt_date(date)}), #{fmt_fees( meta.fees.seller_fees )}](https://opensea.io/collection/#{meta.slug})**"
   buf << "   owners: #{meta.stats.num_owners},"
   if meta.stats.total_sales > 0
     buf << "   sales:  #{meta.stats.total_sales}"
     buf << "   -  #{fmt_eth( meta.stats.total_volume )} @ "
     buf << "   price avg #{fmt_eth( meta.stats.average_price ) },"
     buf << "   floor #{fmt_eth( meta.stats.floor_price ) }"
   else
     buf << "   sales: 0"
   end
   buf << "\n"


   cols << Collection.new( meta.stats.total_volume, buf )
end
  cols = cols.sort { |l,r| r.total_volume <=> l.total_volume }


  buf = "# Top Collections by Sales Value\n\n"
  buf +=  cols.map { |col| col.buf }.join( '' )
  buf
end
end   # class TopCollectionReport



class CollectionsReport

   Collection =  Struct.new(:date, :buf)

def build( root_dir )

   cols = []

each_dir( "#{root_dir}/*" ) do |dir|
   puts "==> #{dir}"

   meta = OpenSea::Meta::Collection.read( dir )


   buf = String.new('')
   buf << "##  #{meta.name}\n\n"

   buf << "opensea: [#{meta.slug}](https://opensea.io/collection/#{meta.slug}) - created on #{fmt_date(meta.created_date)}<br>\n"
   buf << "web:  <#{meta.external_url}><br>\n"   if meta.external_url?
   buf << "twitter: [#{meta.twitter_username}](https://twitter.com/#{meta.twitter_username})<br>\n"  if meta.twitter_username?

   buf << "\n"

   if meta.contracts.size > 0
     buf << "contracts (#{meta.contracts.size}):\n"
     meta.contracts.each do |contract|
        buf << "- **#{contract.name} (#{contract.symbol})**"
        buf << " created on #{fmt_date(contract.created_date)}"
        buf << " @ [#{contract.address}](https://etherscan.io/address/#{contract.address})\n"
     end
     buf << "\n"
   end

   buf << "stats:\n"
   buf << "- count / total supply: #{meta.stats.count} / #{meta.stats.total_supply},"
   buf << " num owners:  #{meta.stats.num_owners}\n"
   if meta.stats.total_sales > 0
      buf << "- total sales:  #{meta.stats.total_sales},"
      buf << " total volume: #{fmt_eth( meta.stats.total_volume ) }\n"
      buf << "- average price: #{fmt_eth( meta.stats.average_price ) }\n"
      buf << "- floor price: #{fmt_eth( meta.stats.floor_price ) }\n"
   else
      buf << "- total sales:  0\n"
   end
   buf << "\n"


   buf << "fees:"
   buf << " seller #{fmt_fees( meta.fees.seller_fees )},"
   buf << " opensea #{fmt_fees( meta.fees.opensea_fees )}\n"
   buf << "\n"

   buf << "payments (#{meta.payment_methods.size}): #{meta.payment_methods.join(', ')}\n"
   buf << "\n"

   attribute_categories = meta.attribute_categories( count: true )
   if attribute_categories.size > 0
     buf << "<details><summary>attribute categories (#{attribute_categories.size}):</summary>\n"
     buf << "\n"
     attribute_categories.each do |cat|
        buf << "- #{cat}\n"
     end
     buf << "\n"
     buf << "</details>\n"
   end

   date =  if meta.contracts.size > 0
                   meta.contracts[0].created_date
               else
                   meta.created_date
               end

   cols << Collection.new( date, buf )
end

## sort  cols by date

cols = cols.sort { |l,r| r.date <=> l.date }


  buf = "# Collections\n\n"
  buf +=  cols.map { |col| col.buf }.join( "\n\n" )
  buf
end
end # class CollectionsReport


report = TrendingCollectionsReport.new
buf = report.build( './ethereum' )
write_text( "./ethereum/TRENDING.md", buf )

buf = report.build( './openstore' )
write_text( "./openstore/TRENDING.md", buf )




report = TopCollectionsReport.new
buf = report.build( './ethereum' )
write_text( "./ethereum/TOP.md", buf )

buf = report.build( './openstore' )
write_text( "./openstore/TOP.md", buf )



report = CollectionsReport.new
buf = report.build( './ethereum' )
write_text( "./ethereum/README.md", buf )

buf = report.build( './openstore' )
write_text( "./openstore/README.md", buf )


puts "bye"
