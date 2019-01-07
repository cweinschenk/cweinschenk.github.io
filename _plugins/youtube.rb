# Snagged from https://gist.github.com/joelverhagen/1805814
module Jekyll
  class YouTube < Liquid::Tag
    Syntax = /^\s*([^\s]+)(\s+(\d+)\s+(\d+)\s*)?/

    def initialize(tagName, markup, tokens)
      super

      if markup =~ Syntax then
        @id = $1

        if $2.nil? then
            @width = 640
            @height = 360
        else
            @width = $2.to_i
            @height = $3.to_i
        end
      else
        raise "No YouTube ID provided in the \"youtube\" tag"
      end
    end

    def render(context)
      %(<iframe width="#{@width}" height="#{@height}" src="https://www.youtube.com/embed/#{@id}" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowfullscreen></iframe>)
    end
  end
end

Liquid::Template.register_tag("youtube", Jekyll::YouTube)
