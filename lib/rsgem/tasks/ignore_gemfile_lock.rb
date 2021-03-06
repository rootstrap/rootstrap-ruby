# frozen_string_literal: true

module RSGem
  module Tasks
    #
    # Gemfile.lock should be gitignored when developing gems
    #
    # https://github.com/rootstrap/tech-guides/blob/master/open-source/developing_gems.md#gemfilegemfilelockgemspec
    #
    class IgnoreGemfileLock < Base
      OUTPUT = OutputStruct.new(name: 'Ignore gemfile.lock')

      def perform
        gitignore << "\nGemfile.lock\n"
        write_to_gitignore
      end

      private

      def gitignore
        @gitignore ||= File.read(context.gitignore_path)
      end

      def write_to_gitignore
        File.open(context.gitignore_path, 'w') do |file|
          file.puts gitignore
        end
      end
    end
  end
end
