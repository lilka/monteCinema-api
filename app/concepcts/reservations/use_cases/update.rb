# frozen_string_literal: true

module Reservations
  module UseCases
    class Update
      def initialize(id:, params:, repository: Reservations::Repository.new)
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
