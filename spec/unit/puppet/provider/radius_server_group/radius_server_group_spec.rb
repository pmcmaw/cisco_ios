require 'spec_helper'

module Puppet::Provider::RadiusServerGroup; end
require 'puppet/provider/radius_server_group/ios'

RSpec.describe Puppet::Provider::RadiusServerGroup::RadiusServerGroup do
  def self.load_test_data
    PuppetX::CiscoIOS::Utility.load_yaml(File.expand_path(__dir__) + '/test_data.yaml', false)
  end

  context 'Read tests:' do
    load_test_data['default']['read_tests'].each do |test_name, test|
      it "Read: #{test_name}" do
        expect(described_class.instances_from_cli(test['cli'])).to eq test['expectations']
      end
    end
  end

  context 'Radius update tests:' do
    load_test_data['default']['update_radius_tests'].each do |test_name, test|
      it test_name.to_s do
        expect(described_class.commands_from_instance(test['instance'])).to eq test['cli']
      end
    end
  end

  context 'Server update tests:' do
    load_test_data['default']['update_server_tests'].each do |test_name, test|
      it test_name.to_s do
        expect(described_class.commands_from_is_should(test['is'], test['should'])).to eq test['cli']
      end
    end
  end
end
