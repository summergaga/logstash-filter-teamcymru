# logstash-filter-teamcuymru

This is a Logstash filter plgin for teamcymru IP reputation service  
Run

    bundle install
    gem build logstash-filter-teamcymru.gemspec
    $LS_HOME/bin/logstash-plugin install logstash-filter-teamcymru-0.1.0.gem

to install this

Also, you need to install chrome-webdriver from https://sites.google.com/chromium.org/driver/ and put it to the system PATH
