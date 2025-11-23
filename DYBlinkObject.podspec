#
# Be sure to run `pod lib lint DYBlinkObject.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DYBlinkObject'
  s.version          = '2.0.0'
  s.summary          = 'Swift library for creating animated shapes with various effects and chainable API.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'DYBlinkObject v2.0 supports 8 shape types (Circle, Triangle, Star, Heart, Polygon, RoundedPolygon, Rectangle, CustomPath) and 6 animation types (Alpha, Scale, Rotation, Glow, ColorTransition, Position) with a powerful chainable API. Fully backward compatible with v1.0.'

  s.homepage         = 'https://github.com/doyeonjeong/DYBlinkObject'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.cogitm/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'doyeonjeong' => 'debby_@kakao.com' }
  s.source           = { :git => 'https://github.com/doyeonjeong/DYBlinkObject.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '18.0'
  s.swift_version = '5.1'

  s.source_files = 'DYBlinkObject/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DYBlinkObject' => ['DYBlinkObject/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
