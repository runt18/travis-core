require 'travis/config'

module Travis
  class Config < Hashr
    HOSTS = {
      production:  'travis-ci.org',
      staging:     'staging.travis-ci.org',
      development: 'localhost:3000'
    }

    define  host:  'travis-ci.org',
            shorten_host:  'trvs.io',
            tokens:        { internal: 'token' },
            auth:          { target_origin: nil },
            assets:        { host: HOSTS[Travis.env.to_sym] },
            amqp:          { username: 'guest', password: 'guest', host: 'localhost', prefetch: 1 },
            database:      { adapter: 'postgresql', database: "travis_#{Travis.env}", encoding: 'unicode', min_messages: 'warning', variables: { statement_timeout: 10_000 } },
            s3:            { access_key_id: '', secret_access_key: '' },
            pusher:        { app_id: 'app-id', key: 'key', secret: 'secret' },
            sidekiq:       { namespace: 'sidekiq', pool_size: 1 },
            smtp:          {},
            email:         {},
            github:        { api_url: 'https://api.github.com', token: 'travisbot-token' },
            async:         {},
            notifications: [], # TODO rename to event.handlers
            metrics:       { reporter: 'librato' },
            logger:        { thread_id: true },
            queues:        [],
            default_queue: 'builds.linux',
            jobs:          { retry: { after: 60 * 60 * 2, max_attempts: 1, interval: 60 * 5 } },
            queue:         { limit: { default: 5, by_owner: {} }, interval: 3 },
            logs:          { shards: 1, intervals: { vacuum: 10, regular: 180, force: 3 * 60 * 60 } },
            email:         {},
            roles:         {},
            archive:       {},
            ssl:           {},
            redis:         { url: 'redis://localhost:6379' },
            repository:    { ssl_key: { size: 4096 } },
            repository_filter: { include: [/^rails\/rails/], exclude: [/\/rails$/] },
            encryption:    Travis.env == 'development' || Travis.env == 'test' ? { key: 'secret' * 10 } : {},
            sync:          { organizations: { repositories_limit: 1000 } },
            states_cache:  { memcached_servers: 'localhost:11211' },
            sentry:        { },
            services:      { find_requests: { max_limit: 100, default_limit: 25 } },
            settings:      { timeouts: { defaults: { hard_limit: 50, log_silence: 10 }, maximums: { hard_limit: 180, log_silence: 60 } },
                             rate_limit: { defaults: { api_builds: 10 }, maximums: { api_builds: 200 } } },
            endpoints:     { }

    default :_access => [:key]
  end
end
