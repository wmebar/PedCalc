# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'PedCalc' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # Pods for PedCalc
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Auth'
  pod 'Firebase/DynamicLinks'
  pod 'Firebase/Auth'
  pod 'GoogleSignIn'
  pod 'Charts'
  pod 'RealmSwift'
    post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.1'
      end
    end
  end	
end

