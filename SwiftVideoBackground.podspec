Pod::Spec.new do |s|
  s.name         = "SwiftVideoBackground"
  s.version      = "2.0.2"
  s.summary      = "An easy to use Swift framework that creates a video background for any ViewController."
  s.description  = "SwiftVideoBackground is an easy to use Swift framework that provides the ability to play a video on any UIView. This provides a beautiful UI for login screens, or splash pages, as implemented by Spotify and many others"
  s.homepage     = "https://github.com/dingwilson/SwiftVideoBackground"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Wilson Ding" => "hello@wilsonding.com",
                     "Quan Vo" => "qvo1987@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/dingwilson/SwiftVideoBackground.git", :tag => s.version }
  s.source_files  = "SwiftVideoBackground", "SwiftVideoBackground/**/*.{h,m,swift}"
  s.exclude_files = "Classes/Exclude"
  s.documentation_url = "http://wilsonding.com/SwiftVideoBackground/"
end
