# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

require 'mail'

describe "Round Tripping" do

  it "should round trip a basic email" do
    mail = Mail.new('Subject: FooBar')
    mail.body "This is Text"
    parsed_mail = Mail.new(mail.to_s)
    parsed_mail.subject.value.to_s.should == "FooBar"
    parsed_mail.body.to_s.should == "This is Text"
  end


  it "should round trip a html multipart email" do
    mail = Mail.new('Subject: FooBar')
    mail.text_part = Mail::Part.new do
      body "This is Text"
    end
    mail.html_part = Mail::Part.new do
      content_type = "text/html; charset=US-ASCII"
      body "<b>This is HTML</b>"
    end
    parsed_mail = Mail.new(mail.to_s)
    parsed_mail.message_content_type.should == 'multipart/alternative'
    parsed_mail.boundary.should == mail.boundary
    parsed_mail.parts.length.should == 2
    parsed_mail.parts[0].body.to_s.should == "This is Text"
    parsed_mail.parts[1].body.to_s.should == "<b>This is HTML</b>"
  end


end