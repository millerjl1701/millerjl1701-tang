require 'spec_helper_acceptance'

describe 'tang class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'works idempotently with no errors' do
      pp = <<-EOS
      class { 'tang': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe package('tang') do
      it { is_expected.to be_installed }
    end

    describe package('jose') do
      it { is_expected.to be_installed }
    end

    describe package('libjose') do
      it { is_expected.to be_installed }
    end

    describe service('tangd.socket') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(80) do
      it { is_expected.to be_listening }
    end

    describe command('curl -f http://localhost/adv') do
      its(:stdout) { is_expected.to contain('payload') }
      its(:stdout) { is_expected.to contain('signature') }
    end
  end
end
