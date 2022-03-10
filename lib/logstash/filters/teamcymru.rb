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

  # Replace the message with this value.
  config :ip, :validate => :string, :required => true
  config :target, :validate => :string, :default => "teamcymru"

  public
  def register
    # Add instance variables
  end # def register

  public
  def filter(event)
    browser = Watir::Browser.new :chrome, headless: true
    #browser.goto('https://reputation.team-cymru.com')
    #text_field = browser.text_field(id: 'ips')
    #text_field.clear
    #text_field.set @ip
    #button = browser.button(value: 'Search')
    #button.click
    #answer = browser.table(id: 'table').tr{1}.cell{1}.text
  	#browser = Watir::Browser.new :chrome
	  browser.goto('https://reputation.team-cymru.com')
	  txt_field = browser.textarea(class: 'input')
	  txt_field.set(@ip)
	  button = browser.button(value: 'Search')
	  button.click
	  answer = browser.table(id: 'table').tr{1}.cell{1}.text
    event.set(@target, answer)
    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Teamcymru
