# frozen_string_literal: true

module Screenings
  module Representers
    class Multiple
      def initialize(screenings: Screenings::UseCases::ShowAll.new.call)
        @screenings = screenings
      end

      def call
        @screenings.map do |screening|
          Screenings::Representers::Single.new(screening).call
        end
      end

      private

      attr_reader :screenings
    end
  end
end
