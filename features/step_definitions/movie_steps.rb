Given /the following movies exist/ do |movies_table|
  @movies_count = movies_table.hashes.length
  movies_table.hashes.each do |movie|
    Movie.new( movie ).save() if Movie.where(movie).empty?
  end
end

Then /the director of "([^"]*)" should be "([^"]*)"/ do |movie,director|
  db_dir = Movie.where( :title => movie ).first[:director] 
  if db_dir.respond_to? :should
    db_dir.should == director
  else
    assert_equal db_dir, director
  end
end
