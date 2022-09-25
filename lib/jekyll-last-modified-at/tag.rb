# frozen_string_literal: true

module Jekyll
  module LastModifiedAt
    class Tag < Liquid::Tag
      def initialize(tag_name, path, tokens)
        super
        @path = path
      end

      def render(context)
        site = context.registers[:site]
        path = @path || site.config.dig('last-modified-at', 'path')
        article_file = context.environments.first['page']['path']
        Determinator.new(site.source, article_file, path)
                    .formatted_last_modified_date
      end
    end
  end
end

Liquid::Template.register_tag('last_modified_at', Jekyll::LastModifiedAt::Tag)
