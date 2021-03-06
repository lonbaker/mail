require File.dirname(__FILE__) + '/../../../spec_helper'

require 'mail'

describe Mail::ParameterHash do
  it "should return the values in the hash" do
    hash = Mail::ParameterHash.new
    hash.merge!({'value1' => 'one', 'value2' => 'two'})
    hash.keys.should == ['value1', 'value2']
    hash.values.should == ['one', 'two']
  end

  it "should return the correct value if they are not encoded" do
    hash = Mail::ParameterHash.new
    hash.merge!({'value1' => 'one', 'value2' => 'two'})
    hash['value1'].should == 'one'
    hash['value2'].should == 'two'
  end
  
  it "should return a name list concatenated" do
    hash = Mail::ParameterHash.new
    hash.merge!({'value*1' => 'one', 'value*2' => 'two'})
    hash['value'].should == 'onetwo'
  end
  
  it "should return a name list concatenated and unencoded" do
    hash = Mail::ParameterHash.new
    hash.merge!({'value*0*' => "us-ascii'en'This%20is%20even%20more%20",
                 'value*1*' => '%2A%2A%2Afun%2A%2A%2A%20',
                 'value*2*' => "isn't it"})
    hash['value'].should == "This is even more ***fun*** isn't it"
  end
  
end
