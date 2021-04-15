#
# Be sure to run `pod lib lint TSWebImageView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TSWebImageView'
  s.version          = '0.1.2'
  s.summary          = 'This library provider as simple async image downloader with cache support.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      =  'This library provider as simple async image downloader with cache support '   \
                      'for remote images coming from the web'

  s.homepage         = 'https://github.com/tsabian/TSWebImageView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tiago Oliveira' => 'tsabian@hotmail.com' }
  s.source           = { :git => 'https://github.com/tsabian/TSWebImageView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/tsabian'

  s.ios.deployment_target = '12.0'

  s.source_files = 'TSWebImageView/Core/**/*'
  
  # s.resource_bundles = {
  #   'TSWebImageView' => ['TSWebImageView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.swift_versions = "5.0"
  
end
