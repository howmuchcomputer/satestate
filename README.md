# SatEstate

A Ruby on Rails lunar real estate satellite monitoring system.

### System dependencies
You will need the following installed on your system:

- ruby: >= 2.5.3
- rails: ~> 6.1.3

### Getting started

##### clone the repository
``` bash
$ git clone https://github.com/howmuchcomputer/satestate.git
```
##### bundle
``` bash
$ cd satestate
$ bundle install
```

##### start the server
``` bash
$ rails s
```

### Usage
- for health updates visit: `localhost:3000/satellite/health`
- for current stats visit: `localhost:3000/satellite/stats`

### Configuration
Modify the following configuration block inside `config/initializers/satellite.rb` if you wish 
to change the API url, what defines a stable altitude, etc.

```ruby
Satellite.configure do |config|
  # configure API here
end
```


