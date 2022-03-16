# encoding: utf-8
require "logstash/filters/base"
require "watir"

# This  filter will replace the contents of the default
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an .
class LogStash::Filters::Teamcymru < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #    {
  #     message => "My message..."
  #   }
  # }
  #
  config_name "teamcymru"

  # Replace the smessage with this value.
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
    browser.wait_until(browser.element(xpath: '//*[@id="ipCheckContainer"]/table/tbody/tr/td[2]').present?)
    answer = event.get(@ip) +" reputation score = " + browser.element(xpath: '//*[@id="ipCheckContainer"]/table/tbody/tr/td[2]').text
    event.set(@target, answer)
    browser.close
    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Teamcymru
