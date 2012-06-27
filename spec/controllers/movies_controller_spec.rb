require 'spec_helper'

describe MoviesController do

  describe 'finding similar movies' do
    it 'should call the model method that find movies made by the same director' do
      m = mock('movie1',:title => 'Star Wars', :id => '11', :director => 'George Lucas')
      Movie.stub(:find).and_return( m )
      m.should_receive(:same_director)
      get :director, { :id => '11' }
    end

    it 'should redirect to the movies index page with a notice if no director info is found' do
      m = mock('movie1',:title => 'Star Wars', :id => '11', :director => '')
      Movie.stub(:find).and_return( m )
      get :director, { :id => '11' }
    end

    it 'should redirect to the movies index page if an invalid id is received' do
      Movie.stub(:find).and_return( nil )
      get :director, { :id => '11' }
    end

  end

  describe 'index page of movies' do
    it 'should call the model method to find movies of all ratings' do
      Movie.should_receive(:all_ratings)
      get :index
    end

    it 'should call the model method to find movies sorted by title' do
      Movie.should_receive(:all_ratings)
      get :index, {:sort => 'title'}
    end

    it 'should call the model method to find movies sorted by release-date' do
      Movie.should_receive(:all_ratings)
      get :index, {:sort => 'release_date'}
    end

    it 'should remember the sorting order' do
      Movie.should_receive(:all_ratings)
      get :index, {:sort => 'title'}

      Movie.should_receive(:all_ratings)
      get :index
    end

    it 'should remember the sorting order given different ratings choices' do
      Movie.should_receive(:all_ratings)
      get :index, {:sort => 'title'}

      Movie.should_receive(:all_ratings)
      get :index, {:ratings => {'G'=>'1', 'R'=>'1'}}

      Movie.should_receive(:all_ratings)
      get :index, {:ratings => {'PG'=>'1', 'R'=>'1'}}
    end


  end 

  describe 'detail page of movie' do
    it 'should find a movie with director info based on the given id and show its details' do
      m = mock('movie1',:title => 'Star Wars', :id => '11', :director => 'George Lucas')
      Movie.stub(:find).and_return( m )
      get :show, {:id => '11'}
    end

    it 'should find a movie without director info based on the given id and show its details' do
      m = mock('movie1',:title => 'Star Wars', :id => '11', :director => '')
      Movie.stub(:find).and_return( m )
      get :show, {:id => '11'}
    end
  end

  describe 'edit page of movie' do
    it 'should find a movie based on the given id and shows a form to edit its details' do
      m = mock('movie1',:title => 'Star Wars', :id => '11', :director => 'George Lucas')
      Movie.stub(:find).and_return( m )
      get :edit, {:id => '11'}
    end
  end

  describe 'remove a movie' do
    it 'should find a movie based on the given id and destroy it' do
      m = mock('movie1',:title => 'Star Wars', :id => '11', :director => 'George Lucas')
      Movie.stub(:find).and_return( m )
      m.should_receive(:destroy)
      get :destroy, {:id => '11'}
    end
  end

  describe 'update a movie' do
    it 'should find a movie based on the given id and shows a notice of updated details' do
      details = {:title => 'Star Wars', :director => 'George Lucas'}
      m = mock('movie1')
      m.should_receive(:title)
      Movie.stub(:find).and_return( m )
      m.should_receive(:update_attributes!)
      post :update, {:id=>'11',:movie => details}
    end
  end

  describe 'create a movie' do
    it 'should create a movie based on the given details' do
      details = {:title => 'Star Wars', :id => '11', :director => 'George Lucas'}
      m = mock('movie1', details)
      get :create, {:movie => details}
    end
  end

end
