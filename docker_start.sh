#!/bin/bash
echo "========== Bundle =========="
bundle
echo "========== Migrate ========="
rake db:migrate db:seed
echo "========== Server =========="
rm -v tmp/pids/server.pid
bundle exec sidekiq &
rails s -b 0.0.0.0
