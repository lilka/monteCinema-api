# frozen_string_literal: true

module Screenings
  module UseCases
    class Update
      def initialize(id:, params:, repository: Screenings::Repository.new)
        @id = id
        @repository = repository
        @params = params
      end

      def call
        raise ActiveRecord::RecordNotFound if repository.find(id).present? == false

        if movie_exists?(params) == false
          raise ActiveRecord::RecordNotFound,
                "Couldn't find move with id #{params[:movie_id]}"
        end

        repository.update(params, id)
      end

      private

      attr_reader :params, :repository, :id

      def movie_exists?(params)
        Movies::Repository.new.find(params[:movie_id]).present?
      end
    end
  end
end
