# frozen_string_literal: true

module Screenings
  module UseCases
    class Update
      def initialize(id:, params:, repository: ScreeningRepository.new)
        @id = id
        @repository = repository
        @params = params
      end

      def call
        raise ActiveRecord::RecordNotFound if repository.find(id).present? == false

        if find_movie(params) == false
          raise ActiveRecord::RecordNotFound,
                "Couldn't find move with id #{params[:movie_id]}"
        end

        repository.update(params, id)
      end

      private

      attr_reader :params, :repository, :id

      def find_movie(params)
        Movies::MovieRepository.new.find(params[:movie_id]).present?
      end
    end
  end
end
