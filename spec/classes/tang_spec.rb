require 'spec_helper'

describe 'tang' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context 'tang class without any parameters changed from defaults' do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('tang::install') }
          it { is_expected.to contain_class('tang::config') }
          it { is_expected.to contain_class('tang::service') }
          it { is_expected.to contain_class('tang::install').that_comes_before('Class[tang::config]') }
          it { is_expected.to contain_class('tang::service').that_subscribes_to('Class[tang::config]') }

          it { is_expected.to contain_package('tang').with_ensure('present') }

          it {
            is_expected.to contain_service('tangd.socket').with(
            'ensure'     => 'running',
            'enable'     => 'true',
            'hasstatus'  => 'true',
            'hasrestart' => 'true',
          )
          }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'tang class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          osfamily: 'Solaris',
          operatingsystem: 'Nexenta',
          os: { 'name' => 'Nexenta' },
        }
      end

      it { expect { is_expected.to contain_package('tang') }.to raise_error(Puppet::Error, %r{Nexenta not supported}) }
    end
  end
end
