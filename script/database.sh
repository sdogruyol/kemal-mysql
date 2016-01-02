#!/bin/bash

set -xe

echo 'DROP DATABASE IF EXISTS `mysql-sample`' | mysql -uroot
echo 'CREATE DATABASE `mysql-sample`'         | mysql -uroot

mysql -uroot mysql-sample < table.sql
