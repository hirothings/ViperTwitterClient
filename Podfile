def common_frameworks
  pod 'RxSwift',    '~> 4.0'
  pod 'RxCocoa'
  pod 'LicensePlist'
  pod 'TwitterKit'
  pod 'SwiftLint'
end

abstract_target 'PodsTarget' do
  platform :ios, '11.0'
  use_frameworks!

  common_frameworks

  target 'ViperTwitterClient' do
  end

  target 'ViperTwitterClientModules' do
    pod 'SnapKit', '~> 4.0.0'
    pod 'Nuke', '~> 5.0'
    pod 'SwiftGen'
    pod 'Reusable'
  end

  target 'ViperTwitterClientModel' do
  end

  target 'ViperTwitterClientUtill' do
  end

  target 'ViperTwitterClientModulesTests' do
  end
end
