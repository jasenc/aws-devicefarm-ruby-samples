require 'spec_helper'

desired_caps = {
  caps: {
    platformName:  ENV["DEVICEFARM_DEVICE_PLATFORM_NAME"] || 'Android',
    # platformVersion: ENV['SAUCE_LABS'] ? (ENV["ANDROID_PLATFORM_VERSION"] || '7.1') : ENV["ANDROID_PLATFORM_VERSION"],
    deviceName:    ENV["ANDROID_DEVICE_VERSION"] || 'Android',
    automationName: 'UIAutomator2',
    browserName: 'Chrome'
  },
  appium_lib: {
    sauce_username:   ENV['SAUCE_LABS'] ? ENV['SAUCE_USERNAME'] : nil,
    sauce_access_key: ENV['SAUCE_LABS'] ? ENV['SAUCE_ACCESS_KEY'] : nil,
    wait: 60
  }
}

describe 'Create Chrome web session' do
  it 'should create and destroy Android browser session' do
    @driver = Appium::Driver.new(desired_caps, true).start_driver

    @driver.get('https://www.google.com')

    @page_title = @driver.title
    expect(@page_title).to eql 'Google'

    @driver.quit
    expect { @driver.title }.to raise_error(Selenium::WebDriver::Error::InvalidSessionIdError, 'A session is either terminated or not started')
  end
end
