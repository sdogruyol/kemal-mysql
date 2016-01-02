# kemal-mysql

Easily add MySQL database to your  [Kemal](https://github.com/sdogruyol/kemal) application.

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  kemal-mysql:
    github: sdogruyol/kemal-mysql
```


## Usage

This middleware adds `MySQL` connection pool to [Kemal](https://github.com/sdogruyol/kemal) as a middleware.

```crystal
require "kemal"
require "kemal-mysql"

CONN_OPTS = {
  "host" => "127.0.0.1",
  "user" => "root",
  "password" => "",
  "db" => "your_db"
}

mysql_connect CONN_OPTS, 25, 0.1

# Make sure to yield `env`.
get "/" do |env|
  env.content_type = "application/json"
  users = conn.query("SELECT * FROM users")
  # Release the connection after you are done with exec
  release
  # Renders the users as JSON
  users
end
```

You can configure the connection pool capacity and timeout like:

```ruby
mysql_connect CONN_OPTS, capacity: 10, timeout: 0.1
```

The default value for connection pool capacity is `25` and timeout is `0.1`.

## Contributing

1. Fork it ( https://github.com/sdogruyol/kemal-mysql/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [sdogruyol](https://github.com/sdogruyol) Sdogruyol - creator, maintainer
