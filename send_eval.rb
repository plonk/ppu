#!/usr/bin/env ruby --disable-gems
require 'socket'

PORT = 7143

fail unless ARGV.size == 1
bin = Marshal.dump({ :type => :eval, :string => ARGV[0] })

sock = TCPSocket.new('localhost', PORT)
sock.write(bin)
sock.close
