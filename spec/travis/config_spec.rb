require 'spec_helper'
require 'active_support/core_ext/hash/slice'

describe Travis::Config do
  let(:config) { Travis::Config.load(:files, :env, :heroku, :docker) }

  describe 'endpoints' do
    it 'returns an object even without endpoints entry' do
      config.endpoints.foo.should be_nil
    end

    it 'returns endpoints if it is set' do
      ENV['travis_config'] = YAML.dump('endpoints' => { 'ssh_key' => true })
      config.endpoints.ssh_key.should be_true
    end

    it 'allows to set keys on enpoints when it is nil' do
      config.endpoints.foo.should be_nil

      config.endpoints.foo = true

      config.endpoints.foo.should be_true
    end
  end

  describe 'defaults' do
    it 'notifications defaults to []' do
      config.notifications.should == []
    end

    it 'notifications.email defaults to {}' do
      config.email.should == {}
    end

    it 'queues defaults to []' do
      config.queues.should == []
    end

    it 'ampq.host defaults to "localhost"' do
      config.amqp.host.should == 'localhost'
    end

    it 'ampq.prefetch defaults to 1' do
      config.amqp.prefetch.should == 1
    end

    it 'queue.limit.by_owner defaults to {}' do
      config.queue.limit.by_owner.should == {}
    end

    it 'queue.limit.default defaults to 5' do
      config.queue.limit.default.should == 5
    end

    it 'queue.interval defaults to 3' do
      config.queue.interval.should == 3
    end

    it 'queue.interval defaults to 3' do
      config.queue.interval.should == 3
    end

    it 'logs.shards defaults to 1' do
      config.logs.shards.should == 1
    end

    it 'database' do
      config.database.should == {
        :adapter => 'postgresql',
        :database => 'travis_test',
        :encoding => 'unicode',
        :min_messages => 'warning',
        :variables => { :statement_timeout => 10000 }
      }
    end
  end
end
