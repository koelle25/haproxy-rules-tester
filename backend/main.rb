#!/usr/bin/env ruby
require 'sinatra'

set :bind, '0.0.0.0'
set :port, ARGV[1]

get '*' do
  "#{ARGV[0]}<br>Host: #{request.host}<br>Path: #{request.path}<br>Forwarded: #{request.forwarded?}<br>IP: #{request.ip}<br>X-Forwarded-For: #{request.env['HTTP_X_FORWARDED_FOR']}<br>X-Forwarded-Host: #{request.env['HTTP_X_FORWARDED_HOST']}<br>X-Forwarded-Server: #{request.env['HTTP_X_FORWARDED_SERVER']}"
end
