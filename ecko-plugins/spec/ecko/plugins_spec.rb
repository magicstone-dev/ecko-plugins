RSpec.describe Ecko::Plugins do
  it 'has a version number' do
    expect(Ecko::Plugins::VERSION).not_to be nil
  end

  it 'has a way to register plugins' do
    demo_schema = {
      required_data: true
    }

    Ecko::Plugins.register(name: 'demo', schema: demo_schema, engine: DemoPlugin::Engine)

    expect(Ecko::Plugins.demo).to eq Ecko::Plugins::Registry::Demo
    expect(Ecko::Plugins.demo.configured_data).to eq 'Configured'
    expect(Ecko::Plugins.registry['demo']).to be_present
  end
end
