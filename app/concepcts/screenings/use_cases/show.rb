# frozen_string_literal: true

module Screenings
  module UseCases
    class Show
      def initialize(id:, repository: Screenings::Repository.new)
        @repository = repository
        @id = id
      end

      def call
        raise ActiveRecord::RecordNotFound if repository.find(id).present? == false

        repository.find(id)
      end

      private

      attr_reader :id, :repository
    end
  end
end
