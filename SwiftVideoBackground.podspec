Pod::Spec.new do |s|
  s.name         = "SwiftVideoBackground"
  s.version      = "3.2.0"
  s.summary      = "An easy to use Swift framework to play a video in the background of any UIView."
  s.description  = "SwiftVideoBackground is an easy to use Swift framework that provides the ability to play a video on any UIView. This provides a beautiful UI for login screens, or splash pages, as implemented by Spotify and many others"
  s.screenshots  = "https://i.imgur.com/PzRw2Ku.gif"
  s.homepage     = "https://github.com/dingwilson/SwiftVideoBackground"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Wilson Ding" => "hello@wilsonding.com",
                     "Quan Vo" => "qvo1987@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/dingwilson/SwiftVideoBackground.git", :tag => s.version }
  s.source_files  = "SwiftVideoBackground/Sources/", "SwiftVideoBackground/Sources/**/*.{h,m,swift}"
  s.documentation_url = "http://wilsonding.com/SwiftVideoBackground/"
end
