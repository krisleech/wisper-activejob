RSpec.describe 'configuration' do
  let(:configuration) { Wisper.configuration }

  it 'configures active_job as a broadcaster' do
    expect(configuration.broadcasters).to include :active_job
  end

  it 'configures sidekiq as default callable async broadcaster' do
    expect(configuration.broadcasters[:async]).to be_an_instance_of(Proc)
    expect(configuration.broadcasters[:async].call).to be_an_instance_of(Wisper::ActiveJobBroadcaster)
  end
end
