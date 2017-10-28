#!/usr/bin/env ruby
# encoding: utf-8

INFO = `amixer get Master`.split("\n")
channels = [['L', -2], ['R', -1]].map do |chan, line|
  INFO[line] =~ /\[(\d+)%\] \[on\]/ ? "#{chan}:#{$1.rjust(3)}" : "#{chan}:off"
end
puts "<fn=1>🔊</fn> #{channels.join('/')}"
