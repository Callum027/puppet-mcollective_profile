require 'spec_helper'
describe 'mcollective_profile' do

  context 'with defaults for all parameters' do
    it { should contain_class('mcollective_profile') }
  end
end
