class Printer
    def initialize
        about_page = File.read("./templates/about_page.mustache")
        about_page = about_page.sub(/\{\{\{price_with_currency\}\}\}/, '{{price_with_currency}}')
        about_page = about_page.sub(/\{\{\{store_description\}\}\}/, '{{store_description}}')

        layout = File.read("./templates/layout.mustache")
        layout = layout.sub(/\{\{\{search\}\}\}/, '{{search}}')
        layout = layout.sub(/\<script id=\"theme-builder\" src=\"\/theme-builder.js\"\>\<\/script\>/, '')
        layout = layout.sub(/\<script src=\"\/assets\/dist\/application.min.js\"\>\<\/script\>/, '<script src="//cdn.konginitiative.com/static/assets/dist/application.min.js"></script>')

        list_page = File.read("./templates/list_page.mustache")
        list_page = list_page.sub(/\{\{\{price_with_currency\}\}\}/, '{{price_with_currency}}')

        product_page = File.read("./templates/product_page.mustache")
        product_page = product_page.sub(/\{\{\{social_buttons\}\}\}/, '{{social_buttons}}')
        product_page = product_page.sub(/\{\{\{price_with_currency\}\}\}/, '{{price_with_currency}}')
        product_page = product_page.sub(/\{\{\{description\}\}\}/, '{{description}}')

        css = File.read("./static/assets/dist/application.css")

        tictail_misc = File.read("./templates/tictail/misc.mustache")

        layout = layout.sub(/\<link href=\"\/assets\/dist\/application\.css\" rel=\"stylesheet\" type=\"text\/css\"\>/, '<link rel="stylesheet" type="text/css" src="//cdn.konginitiative.com/static/assets/dist/application.css">')
        layout = layout.sub(/\{\{\> tictail\/misc\}\}/, '')
        layout = layout.gsub(/\{\{#has_children\}\}/, '{{#children?}}')
        layout = layout.gsub(/\{\{\/has_children\}\}/, '{{/children?}}')

        content = about_page + list_page + product_page


        layout = layout.sub(/\{\{\{yield\}\}\}/, content)

        File.open("theme.mustache","w") do |f|
            f.write(layout)
        end
        IO.popen('pbcopy', 'w').print layout

        puts "Build successful! View your theme in theme.mustache (and it's added to your clipboard for convinient CMD+v into Tictail.com"
    end
end

Printer.new
