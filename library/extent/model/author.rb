require "liquid"

module RelevantCodes
  module Model
    class Author < Liquid::Drop
      attr_reader :name

      def initialize(name)
        @name = name
      end
    end
  end
end
