# frozen_string_literal: true

module User
  class Repository
    attr_reader :adapter

    def initialize(adapter: User)
      @adapter = adapter
    end

    def find(id)
      adapter.find(id)
    end
  end
end
