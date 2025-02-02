# frozen_string_literal: true

require 'rails_helper'

describe InnerPerformance::SaveEventJob do
  subject { described_class.perform_now(**args) }

  let(:args) do
    {
      type: InnerPerformance::Events::PerformActiveJob.name,
      created_at: Time.current,
      event: 'perform.active_job',
      name: 'DummyJob',
      duration: 100,
      db_runtime: 79,
      properties: {
        foo: 'bar'
      }
    }
  end

  it 'saves event' do
    expect { subject }.to change(InnerPerformance::Event.all, :count).by(1)

    event = InnerPerformance::Event.last
    expect(event.type).to eq 'InnerPerformance::Events::PerformActiveJob'
    expect(event.event).to eq 'perform.active_job'
    expect(event.duration).to eq 100
    expect(event.db_runtime).to eq 79
    expect(event.properties).to eq('foo' => 'bar')
  end
end
