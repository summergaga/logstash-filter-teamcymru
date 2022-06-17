# encoding: utf-8
require "logstash/filters/base"
require "watir"
require "headless"
require "webdrivers/geckodriver"

class LogStash::Filters::Teamcymru < LogStash::Filters::Base
  config_name "teamcymru"
  config :ip, :validate => :string, :required => true
  config :target, :validate => :string, :default => "teamcymru_score"
  config :info, :validate => :string, :default => "reputation"
  public
  def register
    # Add instance variables
  end # def register
  public
  def filter(event)
    browser = Watir::Browser.new :firefox, headless: true
    browser.goto('https://reputation.team-cymru.com')
    browser.textarea(class: 'input').set(event.get(@ip))
    browser.button(id: 'search').click
    browser.element(xpath: '/html/body/section[1]/div/div[2]/table/tbody/tr/td[2]').wait_until(&:present?)
    if (event.get(@info) == "reputation")
      answer = browser.element(xpath: '/html/body/section[1]/div/div[2]/table/tbody/tr/td[2]').text
    end
    if (event.get(@info) == "days_observed")
      answer = browser.element(xpath: '/html/body/section[1]/div/div[2]/table/tbody/tr/td[3]').text
    end
    if (event.get(@info) == "category")
      answer = browser.element(xpath: '/html/body/section[1]/div/div[2]/table/tbody/tr/td[4]').text
    end
    event.set(@target, answer)
    browser.close
    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Teamcymru