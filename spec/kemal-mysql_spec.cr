require "./spec_helper"

CONN_OPTS = {
  "host" => "127.0.0.1",
  "user" => "root",
  "password" => "",
  "db" => "mysql-sample"
}

describe Kemal::MySQL do

  it "creates a connection pool" do
    pool = Kemal::MySQL.new CONN_OPTS, 25, 0.1
    pool.should_not be nil
  end
end
