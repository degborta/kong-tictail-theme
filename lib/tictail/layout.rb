module Tictail
  class Layout
    attr_reader :content
    
    def initialize
      pages = about_page + list_page + product_page
      @content = layout.sub(/\{\{\{yield\}\}\}/, pages)
    end

    def about_page
      page = File.read("./templates/about_page.mustache")
      page = page.sub(/\{\{\{price_with_currency\}\}\}/, '{{price_with_currency}}')

      page.sub(/\{\{\{store_description\}\}\}/, '{{store_description}}')
    end

    def list_page
      page = File.read("./templates/list_page.mustache")

      page.sub(/\{\{\{price_with_currency\}\}\}/, '{{price_with_currency}}')
    end

    def product_page
      page = File.read("./templates/product_page.mustache")
      page = page.sub(/\{\{\{social_buttons\}\}\}/, '{{social_buttons}}')
      page = page.sub(/\{\{\{price_with_currency\}\}\}/, '{{price_with_currency}}')

      page.sub(/\{\{\{description\}\}\}/, '{{description}}')
    end

    def layout
      layout_string = File.read("./templates/layout.mustache")
      layout_string = layout_string.sub(/\{\{\{search\}\}\}/, '{{search}}')
      layout_string = layout_string.sub(/\<script id=\"theme-builder\" src=\"\/theme-builder.js\"\>\<\/script\>/, '')
      layout_string = layout_string.sub(/\<script src=\"\/assets\/dist\/application.min.js\"\>\<\/script\>/, '<script src="//cdn.konginitiative.com/static/assets/dist/application.min.js"></script>')
      layout_string = layout_string.sub(/\<link href=\"\/assets\/dist\/application\.css\" rel=\"stylesheet\" type=\"text\/css\"\>/, '<link rel="stylesheet" type="text/css" href="//cdn.konginitiative.com/static/assets/dist/application.css">')
      layout_string = layout_string.sub(/\{\{\> tictail\/misc\}\}/, '')
      layout_string = layout_string.gsub(/\{\{#has_children\}\}/, '{{#children?}}')

      layout_string.gsub(/\{\{\/has_children\}\}/, '{{/children?}}')
    end
  end
end
