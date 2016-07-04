require "mysql"
require "pool/connection"
require "http"

macro conn
  env.mysql.connection
end

macro release
  env.mysql.release
end

def mysql_connect(options, capacity = 25, timeout = 0.1)
  Kemal.config.add_handler Kemal::MySQL.new(options, capacity, timeout)
end

class HTTP::Server::Context
  @mysql : ConnectionPool(MySQL::Connection) | Nil
  property! mysql
end

class Kemal::MySQL < HTTP::Handler
  @mysql : ConnectionPool(MySQL::Connection)
  getter mysql

  def initialize(options={} of String => String, capacity = 25, timeout = 0.1)
    @mysql = ConnectionPool(MySQL::Connection).new(capacity: capacity, timeout: timeout) do
      ::MySQL.connect(options["host"], options["user"], options["password"], options["db"], 3306_u16, nil)
    end
  end

  def call(context)
    context.mysql = @mysql
    call_next(context)
  end
end
