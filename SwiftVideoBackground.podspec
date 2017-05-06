Pod::Spec.new do |s|
  s.name         = "SwiftVideoBackground"
  s.version      = "0.06"
  s.summary      = "An easy to use Swift framework that creates a video background for any ViewController."
  s.description  = "SwiftVideoBackground is an easy to use Swift framework that provides the ability to add a UIView of a video playing in the background to any ViewController. This provides a beautiful user interface for use in login screens, as well as other data input screens, as modeled by Spotify's iOS App Login Screen and others"
  s.homepage     = "https://github.com/dingwilson/SwiftVideoBackground"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Wilson Ding" => "hello@wilsonding.com" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/dingwilson/SwiftVideoBackground.git", :tag => "0.06" }
  s.source_files  = "SwiftVideoBackground", "SwiftVideoBackground/**/*.{h,m,swift}"
  s.exclude_files = "Classes/Exclude"
end
