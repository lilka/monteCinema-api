require 'rails_helper'

module Mutations
    RSpec.describe AddCinemaHall, type: :request, graphql: true do
        describe ".resolve" do

            subject(:add_cinema_hall){
                post '/graphql', params: {  query: query, variables: {name: "test", number_of_seats: 100}  }
      
            }
            it 'creates a cinema hall' do 
                expect(add_cinema_hall).to  change{ CinemaHall}.by(1)
            end
            
        end
        
        
    end
    
end