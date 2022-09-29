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
        "#{'%.2f' % amount} ETH  (~ #{usd_str} USD)"
      elsif amount >= 0.0015
        "#{'%.3f' % amount} ETH  (~ #{usd_str} USD)"
      else
        "#{amount} ETH  (~ #{usd_str} USD)"
      end
   end
end





cols = []
Collection =  Struct.new(:date, :buf)


each_dir( './cache/*' ) do |dir|
   puts "==> #{dir}"

   meta = OpenSea::Meta::Collection.read( dir )


   buf = String.new('')
   buf << "##  #{meta.name}\n\n"

   buf << "opensea: [#{meta.slug}](https://opensea.io/collection/#{meta.slug}) - created on #{fmt_date(meta.created_date)}<br>\n"
   buf << "web:  <#{meta.external_url}><br>\n"   if meta.external_url?
   buf << "twitter: [#{meta.twitter_username}](https://twitter.com/#{meta.twitter_username})<br>\n"  if meta.twitter_username?

   buf << "\n"
   buf << "contracts (#{meta.contracts.size}):\n"
   meta.contracts.each do |contract|
      buf << "- **#{contract.name} (#{contract.symbol})**"
      buf << " created on #{fmt_date(contract.created_date)}"
      buf << " @ [#{contract.address}](https://etherscan.io/address/#{contract.address})\n"
   end
   buf << "\n"

   buf << "stats:\n"
   buf << "- count / total supply: #{meta.stats.count} / #{meta.stats.total_supply},"
   buf << " num owners:  #{meta.stats.num_owners}\n"
   buf << "- total sales:  #{meta.stats.total_sales},"
   buf << " total volume: #{fmt_eth( meta.stats.total_volume ) }\n"
   buf << "- average price: #{fmt_eth( meta.stats.average_price ) }\n"
   buf << "- floor price: #{fmt_eth( meta.stats.floor_price ) }\n"
   buf << "\n"

   buf << "fees:"
   buf << " seller - #{fmt_fees( meta.fees.seller_fees )},"
   buf << " opensea - #{fmt_fees( meta.fees.opensea_fees )}\n"
   buf << "\n"

   buf << "payments (#{meta.payment_methods.size}): #{meta.payment_methods.join(', ')}\n"
   buf << "\n"

   attribute_categories = meta.attribute_categories( count: true )
   buf << "attribute categories (#{attribute_categories.size}):\n"
   attribute_categories.each do |cat|
      buf << "- #{cat}\n"
   end
   buf << "\n"


   date =  if meta.contracts.size > 0
                   meta.contracts[0].created_date
               else
                   meta.created_date
               end

   cols << Collection.new( date, buf )
end


## sort  cols by date

cols = cols.sort { |l,r| r.date <=> l.date }
buf =  cols.map { |col| col.buf }.join( "\n\n" )


write_text( "./cache/README.md", buf )

puts "bye"