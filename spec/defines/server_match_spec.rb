
require 'spec_helper'

describe 'ssh::server::match' do
  let(:title) { 'Group nerds' }
  it { should contain_class('ssh::server') }
end
