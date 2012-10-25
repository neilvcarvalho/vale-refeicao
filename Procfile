web: bundle exec rails server -p $PORT
redis: redis-server /usr/local/etc/redis.conf
worker: bundle exec sidekiq
log: tail -f -n 40 log/development.log
