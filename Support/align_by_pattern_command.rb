#!/usr/bin/env ruby

require ENV['TM_SUPPORT_PATH'] + '/lib/textmate'
require ENV['TM_SUPPORT_PATH'] + '/lib/ui'

input   = STDIN.readlines
pattern = TextMate::UI.request_string(:title => 'Align by Pattern', :prompt => 'Please enter a pattern to align text:')

if pattern.nil?
  STDOUT.print input.join
  exit
end

PATTERN_SEPARATOR = "   "  # 3 spaces

first_pattern, *more_patterns = pattern.split PATTERN_SEPARATOR

# Strip extra spaces
more_patterns.each {|pattern| pattern.strip!}

require File.expand_path(File.dirname(__FILE__) + '/align_by_pattern')
include AlignByPattern

result = align_by_pattern input, first_pattern, *more_patterns

STDOUT.print result.join
