# frozen_string_literal: true

require 'kramdown'

require_relative 'markdown/parser'
require_relative 'markdown/version'

module TTY
  module Markdown
    SYMBOLS = {
      arrow: '»',
      bullet: '●',
      bar: '┃',
      diamond: '◈',
      pipe: '│',
      line: '─',
      top_left: '┌',
      top_right: '┐',
      top_center: '┬',
      mid_left: '├',
      mid_right: '┤',
      mid_center: '┼',
      bottom_right: '┘',
      bottom_left: '└',
      bottom_center: '┴'
    }

    WIN_SYMBOLS = {
      arrow: '->',
      bullet: '*',
      diamond: '*',
      bar: '│',
      pipe: '|',
      line: '─',
      top_left: '+',
      top_right: '+',
      top_center: '+',
      mid_left: '+',
      mid_right: '+',
      mid_center: '+',
      bottom_right: '+',
      bottom_left: '+',
      bottom_center: '+'
    }

    THEME = {
      em: :italic,
      header: [:cyan, :bold],
      hr: :yellow,
      link: [:blue, :underline],
      list: :yellow,
      strong: [:yellow, :bold],
      table: :blue,
      quote: :yellow,
    }

    # Parse a markdown string
    #
    # @param [Hash] options
    # @option options [String] :colors
    #   a number of colors supported
    # @option options [String] :width
    #
    # @param [String] source
    #   the source with markdown
    #
    # @api public
    def parse(source, **options)
      doc = Kramdown::Document.new(source, options)
      Parser.convert(doc.root, doc.options).join
    end
    module_function :parse

    # Pase a markdown document
    #
    # @api public
    def parse_file(path, **options)
      parse(::File.read(path), options)
    end
    module_function :parse_file

    def symbols
      @symbols ||= windows? ? WIN_SYMBOLS : SYMBOLS
    end
    module_function :symbols

    def windows?
      ::File::ALT_SEPARATOR == "\\"
    end
    module_function :windows?
  end # Markdown
end # TTY
