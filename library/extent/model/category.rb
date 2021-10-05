# frozen_string_literal: true

require 'liquid'

module RelevantCodes
  module Model
    class Category < Liquid::Drop
      attr_reader :name

      def initialize(name)
        @name = name
      end
    end
  end
end
