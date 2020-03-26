# frozen_string_literal: true

RSpec.describe Rootstrap::Gem do
  gem_name = 'test'

  describe '#create' do
    before(:all) { described_class.new(gem_name: gem_name).create }
    after(:all) { `rm -rf ./#{gem_name}` }

    let(:list_files) { `ls -a`.split("\n") }
    let(:list_files_gem) { `ls -a #{gem_name}`.split("\n") }
    let(:gemspec) { File.open("./#{gem_name}/#{gem_name}.gemspec").read }

    it 'creates a new folder' do
      expect(list_files).to include gem_name
    end

    it 'adds the default gems to the gemspec' do
      expect(gemspec).to include 'rake'
      expect(gemspec).to include 'reek'
      expect(gemspec).to include 'rspec'
      expect(gemspec).to include 'rubocop'
      expect(gemspec).to include 'simplecov'
    end

    it 'assigns a version to simplecov' do
      expect(gemspec).to include "'simplecov', '~> 0.17.1'"
    end

    it 'adds the rubocop config file' do
      expect(list_files_gem).to include '.rubocop.yml'
    end

    it 'adds the reek config file' do
      expect(list_files_gem).to include '.rubocop.yml'
    end
  end
end
