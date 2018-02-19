def common_frameworks
  pod 'RxSwift',    '~> 4.0'
  pod 'Action'
  pod 'RealmSwift'
  pod 'LicensePlist'
  pod 'TwitterKit'
  pod 'SwiftLint'
end

abstract_target 'FavotterTarget' do
  platform :ios, '11.0'
  use_frameworks!

  common_frameworks

  target 'Favotter' do
  end

  target 'FavotterModules' do
    pod 'SnapKit', '~> 4.0.0'
    pod 'Nuke', '~> 5.0'
    pod 'SwiftGen'
    pod 'Reusable'
  end

  target 'FavotterModel' do
  end

  target 'FavotterUtill' do
  end

  target 'FavotterModulesTests' do
  end
end
