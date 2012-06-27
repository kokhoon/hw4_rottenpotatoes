#require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "app", "models", "movie"))
require 'spec_helper'

describe Movie do
  describe ".all_ratings" do
    it "returns an array of MPAA ratings" do
      Movie.all_ratings.should ==  %w(G PG PG-13 NC-17 R)
    end
  end 

  describe ".same_director" do
    it "returns an array of movies of the same director" do
      m1 = Movie.create!( { :title => "M1", :director => "Mr. D" } )
      m2 = Movie.create!( { :title => "M2", :director => "Mr. D" } )
      m2.same_director.should == [ m1, m2 ]
    end
  end
end
