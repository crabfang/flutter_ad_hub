#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint widget_ad_hub.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'widget_ad_hub'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin.'
  s.description      = <<-DESC
A new Flutter plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/*.{h,m}', 'Classes/AdHubSDK/**/*.{h}', 'Classes/SDWebImage/*.{h,m}'
  s.public_header_files = 'Classes/*.h'
  s.resources = 'Assets/*'
  s.vendored_libraries = 'Classes/AdHubSDK/libGDTMobSDK.a'
  s.vendored_frameworks = 'Classes/AdHubSDK/*.framework'
  s.frameworks = 'AddressBook',  'CoreGraphics', 'JavaScriptCore', 'MediaPlayer', 'MessageUI', 'StoreKit', 'SafariServices', 'Security', 'UIKit', 'Accelerate', 'SystemConfiguration', 'AssetsLibrary', 'CoreTelephony', 'QuartzCore', 'CoreFoundation', 'CoreLocation', 'ImageIO', 'CoreMedia', 'CoreMotion', 'AVFoundation', 'WebKit', 'AudioToolbox', 'CFNetwork', 'MobileCoreServices', 'AdSupport', 'AVKit', 'QuickLook'
  s.libraries = 'c++', 'sqlite3', 'z', 'c', 'xml2', 'resolv.9', 'bz2.1.0', 'c++abi'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
