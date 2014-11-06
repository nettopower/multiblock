require "spec_helper"

describe Multiblock do
  it "should construct wrapper" do
    described_class.wrapper.inspect.should =~ /Multiblock::Wrapper/
  end

  it "should construct wrapper with custom default block" do
    wrapper = described_class.wrapper { "foo" }
    wrapper.call(:bar).should == "foo"
  end

  it 'should wrap block' do
    wrapper = described_class.wrap {|w| w.foo { 'foo'} }
    wrapper.call(:foo).should == 'foo'
  end

  it 'should wrap block with defaults' do
    wrapper = described_class.wrap(->{ 'bar' }) {|w| w.foo { 'foo'} }
    wrapper.call(:foo).should == 'foo'
    wrapper.call(:bar).should == 'bar'
  end
end
