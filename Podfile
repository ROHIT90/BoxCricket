source 'https://github.com/CocoaPods/Specs.git'

# Uncomment this line to define a global platform for your project
platform :ios, '9.0'


target 'BoxCricket' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for BoxCricket
pod ’Firebase’
pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'Firebase/Storage'
pod 'Firebase/RemoteConfig'
pod 'Firebase/Crash'
pod ‘Firebase/Messaging’
pod 'Alamofire', '~> 4.0'
pod 'SwiftyJSON'
pod 'MarqueeLabel/Swift'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
