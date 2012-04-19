require 'spec_helper'
require 'support/active_record'
require 'support/formats'

describe Travis::Notifications::Json::Pusher::Build::Finished do
  include Support::ActiveRecord, Support::Formats

  let(:build) { Factory(:build) }
  let(:data)  { Travis::Notifications::Json::Pusher::Build::Finished.new(build).data }

  it 'build' do
    data['build'].should == {
      'id' => build.id,
      'result' => 0,
      'finished_at' => json_format_time(Time.now.utc)
    }
  end

  it 'repository' do
    data['repository'].should == {
      'id' => build.repository_id,
      'slug' => 'svenfuchs/minimal',
      'last_build_id' => 2,
      'last_build_number' => '2',
      'last_build_started_at' => json_format_time(Time.now.utc),
      'last_build_finished_at' => json_format_time(Time.now.utc),
      'last_build_result' => 0,
      'last_build_duration' => nil
    }
  end
end
