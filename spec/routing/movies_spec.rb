require 'spec_helper'

describe "routing to similar movies" do
  it "routes /movies/:id/director to movies_controller#director" do
    { :get => "/movies/11/director" }.should route_to(
      :controller => "movies",
      :action => "director",
      :id => "11"
    )
  end
end

#describe "routing to update page" do
#  it "routes /movies/:id to movies_controller#edit" do
#    { :post => "/movies/11" }.should route_to(
#      :controller=>"movies", 
#      :action=>"update",
#      :id => "11",
#      :movie=> {:title=>"Star Wars", :director=>"George Lucas"}
#    )
#  end
#end
