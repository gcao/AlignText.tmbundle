require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'align_by_pattern'

describe AlignByPattern do
  include AlignByPattern
  
  it "should return input unchanged if pattern is nil" do
    input = <<-TEXT.lines
      a = 1
      bc = 2
    TEXT
    align_by_pattern(input, nil).should == input
  end
  
  it "should align text by pattern" do
    input = <<-TEXT.lines
      a = 1
      bc = 2
    TEXT
    align_by_pattern(input, '=').should == <<-TEXT.lines.to_a
      a  = 1
      bc = 2
    TEXT
  end
  
  it "should align text by multiple patterns" do
    input = <<-TEXT.lines
      validates_presence_of :first_name, :message => error_message(:validates_presence_of_first_name)
      validates_presence_of :last_name, :message => error_message(:validates_presence_of_last_name)
    TEXT
    align_by_pattern(input, ',', '\\)').should == <<-TEXT.lines.to_a
      validates_presence_of :first_name, :message => error_message(:validates_presence_of_first_name)
      validates_presence_of :last_name , :message => error_message(:validates_presence_of_last_name )
    TEXT
  end
  
  it "should skip aligning text by first pattern if it starts with a space" do
    input = <<-TEXT.lines
      validates_presence_of :first_name, :message => error_message(:validates_presence_of_first_name)
      validates_presence_of :last_name, :message => error_message(:validates_presence_of_last_name)
    TEXT
    align_by_pattern(input, ' ,', ':', '\\)').should == <<-TEXT.lines.to_a
      validates_presence_of :first_name, :message => error_message(:validates_presence_of_first_name)
      validates_presence_of :last_name,  :message => error_message(:validates_presence_of_last_name )
    TEXT
  end
end