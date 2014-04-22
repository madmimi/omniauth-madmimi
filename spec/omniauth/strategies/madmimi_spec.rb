require 'spec_helper'

describe OmniAuth::Strategies::Madmimi do
  let(:request) { double('Request', :params => {}, :cookies => {}, :env => {}) }

  subject do
    args = ['appid', 'secret', @options || {}].compact
    OmniAuth::Strategies::Madmimi.new(*args).tap do |strategy|
      strategy.stub(:request) { request }
    end
  end

  describe 'options' do
    it 'should have correct name' do
      subject.options.name.should eq('madmimi')
    end

    it 'should have correct site' do
      subject.options.client_options.site.should eq('http://localhost:3001')
    end
  end

  describe "#uid" do
    before(:each) { subject.stub(:raw_info) { { 'id' => '123' } } }

    it "returns the user id" do
      subject.uid.should eq('123')
    end
  end

  describe "#info" do
    before :each do
      raw_info = {
        "name" => "Great Name",
        "email" => "Great.Name@example.com"
      }
      subject.stub(:raw_info) { raw_info }
    end

    it "returns name" do
      subject.info["name"].should eq("Great Name")
    end

    it "returns email" do
      subject.info["email"].should eq("Great.Name@example.com")
    end
  end
end
