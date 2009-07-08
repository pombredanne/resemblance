#!/usr/bin/env ruby

single_export = ARGV.include? 'single_export'

if single_export
	nap = File.open('nap','w')
else
	names, addresses, phones = ['names','addresses','phones'].collect { |f| File.open(f,'w') }
end

STDIN.each do |line|
	cols = line.chomp.split '|'

	id = cols[0]
	name = cols[1]
	address = [2,3,4,5].collect{|i| cols[i]}.join('|')	
	phone = cols[6]

	if single_export
		name_addr_phone = [name,address,phone].join('|')
		nap.puts "#{id}|#{name_addr_phone}"
	else
		raise "empty name? [#{line}]" if name.empty?
		names.puts "#{id}|#{name}"
		addresses.puts "#{id}|#{address}" unless address.empty?
		phones.puts "#{id}|#{phone}" unless phone.empty?
	end		
	
end

if single_export
	nap.close
else
	[names, addresses, phones].each { |f| f.close }
end