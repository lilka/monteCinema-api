# frozen_string_literal: true

module Movies
  module UseCases
    class Update
      def initialize(id:, params:, repository: Movies::Repository.new)
        @id = id
        @repository = repository
        @params = params
      end

      def call
        raise ActiveRecord::RecordNotFound if repository.find(id).present? == false

        repository.update(params, id)
      end

      private

      attr_reader :params, :repository, :id
    end
  end
end
