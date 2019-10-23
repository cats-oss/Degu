#
# Be sure to run `pod lib lint Degu.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name     = "Degu"
  s.version  = "0.2.0"
  s.summary  = "Degu makes more easier to debug application."
  s.homepage = "https://github.com/cats-oss/Degu"
  s.license  = { :type => "MIT", :file => "LICENSE" }
  s.author   = { "marty-suzuki" => "suzuki_taiki@abema.tv" }
  s.source   = { :git => "https://github.com/cats-oss/Degu.git", :tag => s.version.to_s }

  s.swift_version = '5.1'
  s.source_files  = 'Sources/**/*.{swift,h,m}'

  s.ios.frameworks   = 'UIKit'
  s.tvos.frameworks  = 'UIKit'
  s.macos.frameworks = 'AppKit'

  s.ios.deployment_target   = '9.0'
  s.tvos.deployment_target  = '10.0'
  s.macos.deployment_target = '10.10'
end
