#############
#  build a (cache) report page
#  to run use:
#
#  $ ruby sandbox/report.rb

require 'cocos'

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



def find_payments( data )
   values = []
   data.each do |h|
      values << "#{h['name']} (#{h['symbol']})"
   end
   values
end

def find_traits( data )
  values = []
  data.each do |k,h|
     values << "#{k} (#{h.size})"
  end
  values
end


def fmt_date( str )
   date = DateTime.iso8601( str )
   date.strftime( '%b %d, %Y' )
end




cols = []
Collection =  Struct.new(:date, :buf)


each_dir( './cache/*' ) do |dir|
   puts "==> #{dir}"

   data = read_json( "#{dir}/collection.json" )

   data_contracts = read_json( "#{dir}/contracts.json" )

   data_traits = read_json( "#{dir}/traits.json" )

   data_stats  = read_json( "#{dir}/stats.json" )


   data_payment = read_json( "#{dir}/payment.json" )


   buf = String.new('')
   buf << "##  #{data['name']}\n\n"

   buf << "opensea: [#{data['slug']}](https://opensea.io/collection/#{data['slug']}) - created on #{fmt_date(data['created_date'])}<br>\n"
   buf << "web:  <#{data['external_url']}><br>\n"   if data['external_url']
   buf << "twitter: [#{data['twitter_username']}](https://twitter.com/#{data['twitter_username']})<br>\n"  if data['twitter_username']


   buf << "\n\n"
   buf << "contracts (#{data_contracts.size}):\n"
   data_contracts.each do |data_contract|
      buf << "- **#{data_contract['name']} (#{data_contract['symbol']})**"
      buf << " created on #{fmt_date( data_contract['created_date'])}"
      buf << " @ [#{data_contract['address']}](https://etherscan.io/address/#{data_contract['address']})\n"
   end
   buf << "\n\n"

   traits = find_traits( data_traits )
   buf << "attributes (#{traits.size}): #{traits.join(', ')}<br>\n"

   data_stats_redux = {
     'count'        => data_stats['count'],
     'total_supply' => data_stats['total_supply'],
     'total_volume' => data_stats['total_volume'],
     'total_sales'  => data_stats['total_sales'],
     'num_owners'   => data_stats['num_owners'],
     'average_price'=> data_stats['average_price'],
     'floor_price'  => data_stats['floor_price']
   }
   buf << "\n\n"
   buf << "stats:\n"
   buf << "```\n"
   buf << data_stats_redux.pretty_inspect
   buf << "```\n\n"

   payments = find_payments( data_payment )
   buf << "payments (#{payments.size}): #{payments.join(', ')}<br>\n"

   buf << "fees:\n"
   buf << "```\n"
   buf << data['fees'].pretty_inspect
   buf << "```\n\n"

   date_str =  if data_contracts[0]
                   data_contracts[0]['created_date']
               else
                   data['created_date']
               end
   date = DateTime.iso8601( date_str )
   cols << Collection.new( date, buf )
end


## sort  cols by date

cols = cols.sort { |l,r| r.date <=> l.date }
buf =  cols.map { |col| col.buf }.join( "\n\n" )


write_text( "./cache/README.md", buf )

puts "bye"