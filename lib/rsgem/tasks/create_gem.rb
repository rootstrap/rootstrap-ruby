# frozen_string_literal: true

module RSGem
  module Tasks
    class CreateGem
      attr_reader :context

      def initialize(context:)
        @context = context
      end

      def create
        `#{shell_command}`
        puts message
      end

      private

      def bundler_options
        context.bundler_options
      end

      def message
        [
          "\tGem created",
          ("with options: #{bundler_options}" if bundler_options)
        ].compact.join(' ')
      end

      def shell_command
        [
          "bundle gem #{context.gem_name}",
          bundler_options
        ].compact.join(' ')
      end
    end
  end
end