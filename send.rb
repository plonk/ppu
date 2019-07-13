#!/usr/bin/ruby --disable-gems
require 'socket'

PORT = 7143

fail unless ARGV.size == 2
bin = Marshal.dump({ :type => :post, :summary => ARGV[0], :message => ARGV[1] })

sock = TCPSocket.new('localhost', PORT)
sock.write(bin)
sock.close
