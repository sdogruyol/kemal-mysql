require "mysql"
require "pool/connection"
require "http"

macro conn
  env.request.mysql.not_nil!.connection
end

macro release
  env.request.mysql.not_nil!.release
end

def mysql_connect(options, capacity = 25, timeout = 0.1)
  Kemal.config.add_handler Kemal::PG.new(conn_url, capacity, timeout)
end

class HTTP::Request
  property mysql
end

class Kemal::MySQL < HTTP::Handler
  getter mysql

  def initialize(options={} of String => String, capacity = 25, timeout = 0.1)
    @mysql = ConnectionPool.new(capacity: capacity, timeout: timeout) do
      ::MySQL.connect(options["host"], options["user"], options["password"], options["db"], 3306_u16, nil)
    end
  end

  def call(request)
    request.mysql = @mysql
    call_next(request)
  end
end
