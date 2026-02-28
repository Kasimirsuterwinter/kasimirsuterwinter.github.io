#!/usr/bin/env ruby
# frozen_string_literal: true

require 'yaml'
require 'date'

def front_matter_for(path)
  text = File.read(path)
  match = text.match(/\A---\s*\n(.*?)\n---\s*\n/m)
  return [nil, ["missing YAML front matter"]] unless match

  data = YAML.safe_load(match[1], permitted_classes: [Date, Time], aliases: true)
  return [nil, ["front matter must be a YAML object"]] unless data.is_a?(Hash)

  [data, []]
rescue Psych::SyntaxError => e
  [nil, ["invalid YAML: #{e.message}"]]
end

def string_present?(value)
  value.is_a?(String) && !value.strip.empty?
end

def validate_posts(path, fm)
  errors = []
  required_keys = %w[layout title image categories]
  required_keys.each do |key|
    errors << "missing required key `#{key}`" unless fm.key?(key)
  end

  errors << "`layout` must be `posts`" unless fm['layout'] == 'posts'
  errors << "`title` must be a non-empty string" unless string_present?(fm['title'])
  errors << "`image` must be a non-empty string" unless string_present?(fm['image'])

  categories = fm['categories']
  unless categories.is_a?(Array) && categories.all? { |c| string_present?(c) }
    errors << "`categories` must be an array of non-empty strings"
  end

  if fm.key?('excerpt_seperator')
    errors << "`excerpt_seperator` is misspelled; use `excerpt_separator`"
  end
  if fm.key?('excerpt_separator') && !string_present?(fm['excerpt_separator'])
    errors << "`excerpt_separator` must be a non-empty string when provided"
  end

  errors
end

def validate_work(path, fm)
  errors = []
  required_keys = %w[layout title style image categories]
  required_keys.each do |key|
    errors << "missing required key `#{key}`" unless fm.key?(key)
  end

  errors << "`layout` must be `work`" unless fm['layout'] == 'work'
  %w[title style image].each do |key|
    errors << "`#{key}` must be a non-empty string" unless string_present?(fm[key])
  end

  categories = fm['categories']
  unless categories.is_a?(Array) && categories.all? { |c| string_present?(c) }
    errors << "`categories` must be an array of non-empty strings"
  end

  errors
end

def validate_page(path, fm)
  errors = []
  required_keys = %w[layout title description navigation_weight menu_style background]
  required_keys.each do |key|
    errors << "missing required key `#{key}`" unless fm.key?(key)
  end

  errors << "`layout` must be `default`" unless fm['layout'] == 'default'
  %w[title description].each do |key|
    errors << "`#{key}` must be a non-empty string" unless string_present?(fm[key])
  end

  unless fm['navigation_weight'].is_a?(Integer)
    errors << "`navigation_weight` must be an integer"
  end

  unless %w[light dark].include?(fm['menu_style'])
    errors << "`menu_style` must be either `light` or `dark`"
  end

  bg = fm['background']
  valid_bg = (bg == false) || string_present?(bg)
  errors << "`background` must be `false` or a non-empty string token" unless valid_bg

  errors
end

checks = {
  '_posts/*.md' => method(:validate_posts),
  '_work/*.md' => method(:validate_work),
  'index.html' => method(:validate_page),
  'blog.html' => method(:validate_page),
  'work.html' => method(:validate_page)
}

all_errors = []
checks.each do |pattern, validator|
  Dir.glob(pattern).sort.each do |path|
    fm, parse_errors = front_matter_for(path)
    if parse_errors.any?
      parse_errors.each { |e| all_errors << "#{path}: #{e}" }
      next
    end

    validator.call(path, fm).each do |error|
      all_errors << "#{path}: #{error}"
    end
  end
end

if all_errors.any?
  warn "Content model validation failed:"
  all_errors.each { |error| warn "- #{error}" }
  exit 1
end

puts 'Content model validation passed.'
