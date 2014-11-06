require "spec_helper"

describe 'multiblock/proc_wrap' do

  before(:all) do
    require 'multiblock/proc_wrap'
  end

  after(:all) do
    Proc.send :remove_method, :wrap
  end

  let(:proc) {
    lambda {|wrap| wrap.foo { 'foo' }}
  }

  it 'should wrap a block' do
    proc.wrap.foo.should == 'foo'
  end

  it 'should only evaluate block once when wrapping' do
    counter = 0
    lamb = lambda {|_| counter += 1}
    2.times { lamb.wrap }
    counter.should == 1
  end

end
