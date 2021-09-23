#
# Be sure to run `pod lib lint TSWebImageView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|

  s.name                  = "TSWebImageView"
  s.version               = "0.1.4"
  s.summary               = "This library provider as simple async image downloader with cache support."
  
  s.description           = <<-DESC
  This library provider as simple async image downloader with cache support for remote images coming from the web
                            DESC

  s.homepage              = "https://github.com/tsabian/TSWebImageView"
  # s.screenshots         = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.author                = { "Tiago Oliveira" => "tsabian@hotmail.com" }
  s.source                = { :git => "https://github.com/tsabian/TSWebImageView.git", :tag => "#{s.version}" }
  # s.social_media_url    = "https://twitter.com/tsabian"
  s.source_files          = "TSWebImageView/Core/**/*"
  s.ios.deployment_target = "12.0"

  s.swift_versions        = "5.0"

end
