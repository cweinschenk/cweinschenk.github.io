# hacked from https://gist.github.com/joelverhagen/1805814
module Jekyll
  class Video < Liquid::Tag
    Syntax = /^\s*([^\s]+)(\s+(\d+)\s+(\d+)\s*)?/

    def initialize(name, markup, tokens)
      super

      if markup =~ Syntax then
        id = $1

        @vid = Jekyll.sites.first.data['videos'].select do |a|
          a['id'].to_s == id
        end.first

        if @vid.nil? then
          raise "Video ID #{id} does NOT exist in videos.yml"
        end

        if !['vimeo', 'youtube'].include? @vid['type'] then
          raise "Invalid video provider (type): #{@vid['type']}"
        end

        if $2.nil? then
            @width = 720
            @height = 360
        else
            @width = $2.to_i
            @height = $3.to_i
        end
      else
        raise "No video ID provided in the \"video\" tag"
      end
    end

    def render(context)
      if @vid['type'].downcase == 'vimeo' then
        %(<iframe width="#{@width}" height="#{@height}" src="https://player.vimeo.com/video/#{@vid['id']}" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>)
      elsif @vid['type'].downcase == 'youtube' then
        %(<iframe width="#{@width}" height="#{@height}" src="https://www.youtube.com/embed/#{@vid['id']}" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowfullscreen></iframe>)
      end
    end
  end
end

Liquid::Template.register_tag('video', Jekyll::Video)
