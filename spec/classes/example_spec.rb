require 'spec_helper'

describe 'module_skeleton' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "module_skeleton class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('module_skeleton::params') }
        it { should contain_class('module_skeleton::install').that_comes_before('module_skeleton::config') }
        it { should contain_class('module_skeleton::config') }
        it { should contain_class('module_skeleton::service').that_subscribes_to('module_skeleton::config') }

        it { should contain_service('module_skeleton') }
        it { should contain_package('module_skeleton').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'module_skeleton class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('module_skeleton') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
