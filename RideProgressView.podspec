Pod::Spec.new do |s|

  s.name         = "RideProgressView"
  s.version      = "0.0.1"
  s.summary      = "The image runs along the Linear progress bar."
  s.description  = <<-DESC
The image runs along the Linear progress bar. With Swift
                   DESC

  s.homepage     = "https://github.com/bugkingK/RideProgressView"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "bugkingK" => "myway0710@naver.com" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/bugkingK/RideProgressView.git", :tag => "#{s.version}" }
  s.source_files = "Classes", "Sources/**/*.{swift}"

  s.swift_version = '5.0'	

end