require 'spec_helper'

describe "Create certificates" do 
  it 'AppStore, Development and Ad Hoc' do
    system("rm -rf /tmp/fastlane_core/")
    # Regular
    ENV["DELIVER_USER"] = "felix@sunapps.net"
    
    Sigh::DeveloperCenter.new.run('net.sunapps.7', Sigh::DeveloperCenter::APPSTORE)
    Sigh::DeveloperCenter.new.run('net.sunapps.7', Sigh::DeveloperCenter::DEVELOPMENT)
    Sigh::DeveloperCenter.new.run('net.sunapps.7', Sigh::DeveloperCenter::ADHOC)

    path = "/tmp/fastlane_core"
    expect(File.exists?(File.join(path, "AdHoc_net.sunapps.7.mobileprovision"))).to equal(true)
    expect(File.exists?(File.join(path, "Distribution_net.sunapps.7.mobileprovision"))).to equal(true)
    expect(File.exists?(File.join(path, "Development_net.sunapps.7.mobileprovision"))).to equal(true)


    # Enterprise
    ENV["DELIVER_USER"] = "felix.krause@sunapps.net"
    Sigh::DeveloperCenter.new.run('net.sunapps.*', Sigh::DeveloperCenter::APPSTORE)
    expect(File.exists?(File.join(path, "Distribution_net.sunapps.*.mobileprovision"))).to equal(true)
  end
end