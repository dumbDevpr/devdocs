module Docs
  class Twig
    class CleanHtmlFilter < Filter
      def call
        css('.infobar', '.offline-docs', '.headerlink').remove

        css('.builtin-reference', '.admonition-wrapper', 'h1 > code', 'h2 > code', '.body-web', '.reference em').each do |node|
          node.before(node.children).remove
        end

        css('.section').each do |node|
          node.first_element_child['id'] = node['id'] if node['id']
          node.before(node.children).remove
        end

        doc.child.remove until doc.child.name == 'h1'

        css('.literal-block').each do |node|
          pre = node.at_css('.highlight pre') || node.at_css('pre')
          pre.content = pre.content
          node.replace(pre)
        end

        css('p.versionadded').each do |node|
          node.name = 'div'
        end

        css('h3:contains("Arguments")').each do |node|
          node.name = 'h4'
        end

        css('.navigation').each do |node|
          node['style'] = 'text-align: center'
        end

        doc
      end
    end
  end
end
