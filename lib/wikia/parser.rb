require 'nokogiri'

module Wikia
  class Parser
    class Resource < Struct.new(:page_id, :revision_id, :title, :address, :phone, :email, :website, :contacts, :hours, :languages, :summary, :content, :categories)
    end
    @@namespace = "http://www.mediawiki.org/xml/export-0.6/"

    def initialize(file, logger)
      @file = file
      @logger = logger
      @doc = Nokogiri::XML(@file.read)
    end

    def resources()
      @doc.xpath("//x:page[x:ns = '0']", "x" => @@namespace).map { |page| parse_page(page) }
    end

    private

    def parse_page(page)
      content = page.at_xpath("x:revision/x:text", "x" => @@namespace).text
      summary_info = summary_info(content)

      resource_hash = {
        page_id: page.at_xpath("x:id", "x" => @@namespace).text,
        revision_id: page.at_xpath("x:revision/x:id", "x" => @@namespace).text,
        title: page.at_xpath("x:title", "x" => @@namespace).text,
        address: summary_info['Address'],
        phone: summary_info['Phone'],
        email: summary_info['Email'],
        website: summary_info['Website'],
        contacts: summary_info['Contact(s)'],
        hours: summary_info['Hours'],
        laguages: summary_info['Language(s)'],
        summary: summary_info['SummaryText'],
        categories: categories(content),
        content: content
      }

      Resource.new(*resource_hash.values_at(*Resource.members))
    end

    def categories(text)
      text.scan(/\[\[Category:([^\]]+)\]\]/).flatten
    end

    # Extract summary info attributes from text
    def summary_info(text)
      summary_info = /{{SummaryInfo(.*?)}}/m.match(text)
      return {} unless summary_info

      Hash[summary_info[1].scan(/^\|(?<key>[^=]*)=(?<value>[^|]*)/).map { |pair| pair.map(&:strip) }]
    end
  end
end
