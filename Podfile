platform :ios, '9.0'

target 'Corpy Ecommerce' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Corpy Ecommerce
pod 'IQKeyboardManagerSwift'
pod 'SkyFloatingLabelTextField'
pod 'Alamofire'
pod "SWSegmentedControl"
pod 'AACarousel'
pod 'UICheckbox.Swift'
pod 'NVActivityIndicatorView'
pod 'Toast-Swift', '~> 3.0.1'
pod 'FBSDKLoginKit'

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end

end
