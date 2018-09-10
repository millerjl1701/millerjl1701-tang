require 'spec_helper_acceptance'

describe 'tang class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'tang': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe package('tang') do
      it { should be_installed }
    end

    describe service('tangd.socket') do
      it { should be_enabled }
      it { should be_running }
    end

    describe port(80) do
      it { should be_listening }
    end

    describe command('curl -f http://localhost/adv') do
      its(:stdout) { should contain('payload') }
      its(:stdout) { should contain('signature') }
    end
  end
end
