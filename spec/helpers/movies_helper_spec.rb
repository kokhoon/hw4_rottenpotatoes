require 'spec_helper'

describe MoviesHelper do

  describe '.oddness' do
    it 'should returns "odd" or "even" for a given count' do
      m = mock('count')
      m.stub(:odd?).and_return( true )
      helper.oddness( m ).should == "odd"
#      MoviesHelper.oddness( 2 ).should == "even"
#      MoviesHelper.oddness( -2 ).should == "even"
#      MoviesHelper.oddness( 1 ).should == "odd"
#      MoviesHelper.oddness( -1 ).should == "odd"
#      MoviesHelper.oddness( 3 ).should == "odd"
    end

  end

end
