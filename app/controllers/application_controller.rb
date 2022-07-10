class ApplicationController < Sinatra::Base
  # Add this line to set the Content-Type header for all responses
  set :default_content_type, 'application/json'

  get '/games' do
    # get all the games from the database
    # return a JSON response with an array of all the game data
    games = Game.all.order(:title)
    games.to_json
  end

  # use the :id syntax to create a dynamic route
  get '/games/:id' do
    game = Game.find(params[:id])

    # include associated reviews in the JSON response
    game.to_json(only: %i[id title genre price], include: {
                   reviews: { only: %i[comment score], include: {
                     user: { only: [:name] }
                   } }
                 })
  end
end
