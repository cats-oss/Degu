#
# Be sure to run `pod lib lint ApplicationDebugKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name     = "ApplicationDebugKit"
  s.version  = "0.1.0"
  s.summary  = "ApplicationDebugKit makes more easier to use AutoLayout in Swift & Objective-C code."
  s.homepage = "https://github.com/cats-oss/ApplicationDebugKit"
  s.license  = { :type => "MIT", :file => "LICENSE" }
  s.author   = { "marty-suzuki" => "suzuki_taiki@abema.tv" }
  s.source   = { :git => "https://github.com/cats-oss/ApplicationDebugKit.git", :tag => s.version.to_s }

  s.swift_version = '4.0'
  s.source_files  = 'Sources/**/*.{swift,h,m}'

  s.ios.frameworks   = 'UIKit'
  s.tvos.frameworks  = 'UIKit'
  s.macos.frameworks = 'AppKit'

  s.ios.deployment_target   = '9.0'
  s.tvos.deployment_target  = '10.0'
  s.macos.deployment_target = '10.10'
end
