require_relative '../../spec_helper'
require_relative 'fixtures/classes'

describe "IO#pid" do
  before :each do
    @io = IOSpecs.io_fixture "lines.txt"
  end

  after :each do
    @io.close if @io
  end

  it "returns nil for IO not associated with a process" do
    @io.pid.should == nil
  end
end

describe "IO#pid" do
  before :each do
    @io = IO.popen ruby_cmd('STDIN.read'), "r+"
  end

  after :each do
    @io.close if @io && !@io.closed?
  end

  it "returns the ID of a process associated with stream" do
    @io.pid.should_not be_nil
  end

  it "raises an IOError on closed stream" do
    @io.close
    -> { @io.pid }.should raise_error(IOError)
  end
end
