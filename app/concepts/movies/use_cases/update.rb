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
        raise ActiveRecord::RecordNotFound unless repository.find(id).present?
        raise ActiveRecord::RecordInvalid unless repository.update(params, id)

        repository.find(id)
      end

      private

      attr_reader :params, :repository, :id
    end
  end
end
