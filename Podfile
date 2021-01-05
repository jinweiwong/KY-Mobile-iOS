# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'KY Mobile' do
  use_frameworks!
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'FirebaseFirestore'
  pod 'Firebase/Storage'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
