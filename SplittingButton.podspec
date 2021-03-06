#
# Be sure to run `pod lib lint SplittingButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SplittingButton'
  s.version          = '0.1.0'
  s.summary          = 'The SplittingButton is a subclass of UIButton that will display multiple options when clicked. It provides many display options.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = 'SplittingButton is a subclass of subclass of UIButton. It generates multiple sub-buttons and a cancel button when the SplittingButton is clicked. It may be used for features such as a share button. When clicked it will display multiple options. The user may select one of the options or may choose to cancel, in which case everything returns to normal.'

  s.homepage         = 'https://github.com/TonyCioara/SplittingButton'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'TonyCioara' => 'tonyangelo9707@gmail.com' }
  s.source           = { :git => 'https://github.com/TonyCioara/SplittingButton.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.swift_version = '4.1'

  s.source_files = 'SplittingButton/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SplittingButton' => ['SplittingButton/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
