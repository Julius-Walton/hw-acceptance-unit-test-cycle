require 'rails_helper'

describe MoviesController, type: 'controller' do
    context '#create' do
        describe 'add movie to database' do
            it 'creates a movie and redirects to movies path' do
                movie_attributes = FactoryBot.attributes_for(:movie)
                expect{post :create, movie: movie_attributes}.to change{Movie.count}.by(1)
                expect(response).to redirect_to movies_path
            end
        end
    end
    
    context '#delete' do
        describe 'delete movie from database' do
            it 'deletes a movie and redirects to movies path' do
                movie = FactoryBot.create(:movie)
                allow(Movie).to receive(:find).and_return movie
                expect{delete :destroy, id: movie.id}.to change{Movie.count}.by(-1)
                expect(response).to redirect_to movies_path
            end
        end
    end
    
    context '#search_directors' do
        describe 'movie has a director' do
            it 'responds to the search_directors route' do
                movie = double('movie', :director => "test")
                allow(Movie).to receive(:find).and_return movie
                get :search_directors, {id: 1}
                expect(response).to render_template :search_directors
            end
            
            it 'queries the Movie model about similar movies' do
                movie = double('movie', :director => "test")
                allow(Movie).to receive(:find).and_return movie
                expect(Movie).to receive(:find_movies_with_same_director).with("1")
                get :search_directors, {id: 1}
            end
            
            let(:movies) { ['star wars', 'raiders']}
            it 'assigns similar movies to the template' do
                movie = double('movie', :director => "test")
                allow(Movie).to receive(:find).and_return movie
                allow(Movie).to receive(:find_movies_with_same_director).and_return movies
                get :search_directors, {id: 1}
                expect(assigns(:movies)).to eq movies
            end
            
            it 'assigns the director movies to the template' do
                movie = double('movie', :director => "test")
                allow(Movie).to receive(:find).and_return movie
                allow(Movie).to receive(:find_movies_with_same_director).and_return movies
                get :search_directors, {id: 1}
                expect(assigns(:director)).to eq 'test'
            end
        end
        describe 'movie has no director' do
            it 'should redirect to the home page with a sad message' do
                movie = double('fake movie').as_null_object
                expect(Movie).to receive(:find).with("1").and_return(movie)
                get :search_directors, {id: 1}
                expect(response).to redirect_to movies_path
            end
        end
    end
end