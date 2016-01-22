# ADTech API Ruby Client

## Getting Started

Install Java (JDK 1.8 Above)

```
$ brew tap caskroom/cask
$ brew install brew-cask
$ brew cask install java
```

Install JRuby with rbenv
```
$ rbenv install jruby-1.7.22
```

## Installation

Add this line to your application's Gemfile

```
gem 'adtech-api-client', git: 'git@github.com:factorymedia/adtech-api-ruby-client.git'
```

And then execute:

```
$ bundle install
```

## Tests
To run tests, please use:
```
env JRUBY_OPTS="--debug -Xcli.debug=true" bundle exec rspec -f d
```
You can see the coverate report with:
```
open coverage/index.html
```

## Usage

### Basic Usage

To use an API, we need to authenticate with the chosen region server with ADTech verified `username` / `password`
```
require 'adtech-api-client'

ADTech::Client.region = ADTech::EU_SERVER # Set API server
ADTech::Client.user = 'tester' # API username
ADTech::Client.password = 'test' # API password
```

### Retrieving report

To retrieve a report, create an instance and pass relevant dates / `report_type_id`. `report_type_id` can be found from `Reports` menu in `adtech` portal.

```
report = ADTech::API::Report.new
report_type_id = 1285 # Our test report type id by network
reporting_day = Date.today - 1 # Yesterday
# Retrieve a report url
report_url = report.get_report_url(report_type_id,
                                   reporting_day,
                                   reporting_day,
                                   nil)
opts = {
  encoding: "UTF-8",
  col_sep:';',
  headers: :first_row,
  header_converters: [:symbol],
  converters: [:numeric],
}

# Download the report and display each line
CSV.new(open(report_url) { |f| f.read }, opts).each do |r|
  puts r.inspect
end
```

### Retrieving object list

A list of website
```
# A list of website
Admin.new.websites

# A list of website ids
Admin.new.website_ids
```
A list of customer
```
# A list of customer
Admin.new.customers

# A list of customer ids
Admin.new.customer_ids
```

A list of advertiser
```
# A list of advertiser
Admin.new.advertisers

# A list of advertiser ids
Admin.new.advertiser_ids
```

## Examples

Examples can be found in the `example` directory.


## Coding standard

This project has been following [Factory Media Ruby Standard](https://github.com/factorymedia/standards/tree/master/coding-styles/ruby) and [Factory Media Rspec Standard](https://github.com/factorymedia/standards/tree/master/testing/rspec)


## License

(The MIT License)

Copyright (c) 2016 Factory Media Ltd

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
