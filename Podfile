platform :ios, '13.0'
inhibit_all_warnings!

target 'Kakebo' do
  use_frameworks!

  pod 'Realm'
  pod 'RealmSwift'
  pod 'SnapKit'
  pod 'SwiftLint'

  target 'KakeboTests' do
    inherit! :search_paths

    pod 'Quick'
    pod 'Nimble'
    pod 'SwiftyMocky'
  end
end

# https://www.jessesquires.com/blog/2020/07/20/xcode-12-drops-support-for-ios-8-fix-for-cocoapods/
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end