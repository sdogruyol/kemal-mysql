#!/bin/bash

set -xe

{
  echo 'INSERT INTO `users`'
  echo '  (`id`, `name`, `email`) values (1, "sdogruyol", "dogruyolserdar@gmail.com");'
} | mysql -uroot mysql-sample
