# frozen_string_literal: true

module Rootstrap
  module Tasks
    #
    # Gemfile should only have the gemspec directive.
    # An exception is when you need to develop against a gem that hasn't yet been released,
    # in this case you can declare that dependency in the Gemfile:
    #
    #   gem 'rack', github: 'rack/rack'
    #
    # gemspec is the place to declare dependencies.
    #
    # https://github.com/rootstrap/tech-guides/blob/master/open-source/developing_gems.md#gemfilegemfilelockgemspec
    #
    class CleanGemfile
      attr_reader :context

      def initialize(context:)
        @context = context
      end

      def clean
        gemfile.gsub!(/gem .+\n/, '') # Remove all gem definitions
        gemfile.sub!(/\n\z/, '') # Remove last new line character
        write_to_gemfile
        puts "\t Gemfile cleaned"
      end

      private

      def gemfile
        @gemfile ||= File.open(context.gemfile_path).read
      end

      def write_to_gemfile
        File.open(context.gemfile_path, 'w') do |file|
          file.puts gemfile
        end
      end
    end
  end
end
