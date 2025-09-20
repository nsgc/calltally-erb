# frozen_string_literal: true

require_relative "erb/version"

module Calltally
  module Erb
    class Error < StandardError; end

    def self.setup
      require "calltally/plugin"
      require "herb"

      Calltally::Plugin.register(".erb") do |path, src, _cfg|
        begin
          ruby_code = Herb.extract_ruby(src)
          ruby_code.strip.empty? ? nil : ruby_code
        rescue => e
          warn "Error processing ERB file #{path}: #{e.message}"
          nil
        end
      end
    rescue LoadError => e
      if e.message.include?("calltally/plugin")
        warn "calltally-erb requires calltally with plugin support"
      elsif e.message.include?("herb")
        warn "calltally-erb requires 'herb' gem. Install with: gem install herb"
      else
        warn "calltally-erb failed to load: #{e.message}"
      end
    end
  end
end

# Register when loaded
Calltally::Erb.setup
