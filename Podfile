# Uncomment the next line to define a global platform for your project
deployment_target = '14.0'
platform :ios, deployment_target

target 'SpaceX' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'R.swift'
  pod 'PromiseKit'
  pod 'Kingfisher'

  # Pods for SpaceX

  target 'SpaceXTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SpaceXUITests' do
    # Pods for testing
  end

end

post_install do |pi|
    pi.pods_project.targets.each do |t|
        t.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
            config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
        end
    end
end
