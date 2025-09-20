# frozen_string_literal: true

require "test_helper"
require "calltally/erb"

class Calltally::TestErb < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Calltally::Erb::VERSION
  end

  def test_plugin_registration
    # Plugin should register .erb extension
    assert_includes Calltally::Plugin.registered_exts, ".erb"
  end

  def test_erb_extraction
    erb_content = <<~ERB
      <h1><%= @post.title %></h1>
      <% if @post.published? %>
        <p>Published on <%= @post.published_at.strftime("%Y-%m-%d") %></p>
      <% end %>
    ERB

    result = Calltally::Plugin.handle("test.erb", erb_content, {})

    refute_nil result
    assert_includes result, "@post.title"
    assert_includes result, "@post.published?"
    assert_includes result, "strftime"
  end

  def test_non_erb_file_returns_nil
    ruby_content = "puts 'Hello, World!'"

    result = Calltally::Plugin.handle("test.rb", ruby_content, {})

    assert_nil result
  end

  def test_integration_with_calltally
    # This test requires calltally to be installed
    begin
      require "calltally/scanner"
      require "calltally/config"
    rescue LoadError
      skip "calltally gem not available for integration test"
    end

    sample_dir = File.expand_path("../samples", __dir__)
    config = {
      "dirs"    => ["."],
      "exclude" => [],
      "top"     => 100,
      "verbose" => false,
      "mode"    => "methods",
      "plugins" => ["erb"]
    }

    scanner = Calltally::Scanner.new(base_dir: sample_dir, config: config)
    _, rows = scanner.scan

    method_names = rows.map(&:first)

    assert_includes method_names, "title"
    assert_includes method_names, "published?"
    assert_includes method_names, "strftime"
    assert_includes method_names, "each"
    assert_includes method_names, "name"
  end
end
