Pod::Spec.new do |s|
  s.name             = 'TVGTabBarController'
  s.version          = '1.0'
  s.summary          = "A TabBarController with a beautiful styles for selection"
  s.description      = <<-DESC
                      The standard TabBarController is very limited in terms of styles and animations when you create a Tab.
                      This cocoapod allows you to create Tabs with beautiful style and customizable properties!
                       DESC
  s.homepage         = "https://github.com/TalebRafiepour/TVGTabBarController"
  s.screenshots      = "https://raw.githubusercontent.com/antiguab/BATabBarController/master/readmeAssets/screenshot1.png",
                       "https://raw.githubusercontent.com/antiguab/BATabBarController/master/readmeAssets/screenshot2.png",
                       "https://raw.githubusercontent.com/antiguab/BATabBarController/master/readmeAssets/screenshot3.png",
                       "https://raw.githubusercontent.com/antiguab/BATabBarController/master/readmeAssets/screenshot4.png",
                       "https://raw.githubusercontent.com/antiguab/BATabBarController/master/readmeAssets/screenshot5.png",
                       "https://raw.githubusercontent.com/antiguab/BATabBarController/master/readmeAssets/screenshot6.png",
                       "https://raw.githubusercontent.com/antiguab/BATabBarController/master/readmeAssets/screenshot7.png"
  s.license          = 'MIT'
  s.author           = { "Taleb Rafiepour" => "taleb.r75@gmail.com" }
  s.source           = { :git => "https://github.com/TalebRafiepour/TVGTabBarController.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/brantigua'
  s.platform         = :ios, '13.0'
  s.swift_version    = '5.0'
  s.source_files = 'TVGTabBarController/**'
  s.frameworks = 'UIKit'
  end