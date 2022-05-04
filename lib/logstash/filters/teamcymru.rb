# encoding: utf-8
require "logstash/filters/base"
require "watir"
require 'webdrivers/chromedriver'

class LogStash::Filters::Teamcymru < LogStash::Filters::Base
  config_name "teamcymru"
  config :ip, :validate => :string, :required => true
  config :target, :validate => :string, :default => "teamcymru"
  public
  def register
    # Add instance variables
  end # def register
  public
  def filter(event)
    browser = Watir::Browser.new :chrome, headlesss: true
    browser.goto('https://reputation.team-cymru.com')
    browser.textarea(class: 'input').set(event.get(@ip))
    browser.button(id: 'search').click
    browser.element(xpath: '//*[@id="ipCheckContainer"]/table/tbody/tr/td[2]').wait_until(&:present?)
    answer = browser.element(xpath: '//*[@id="ipCheckContainer"]/table/tbody/tr/td[2]').text
    event.set(@target, answer)
    browser.close
    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Teamcymru
