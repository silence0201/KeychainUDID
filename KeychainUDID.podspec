Pod::Spec.new do |s|
  s.name         = "KeychainUDID"
  s.version      = "0.1.0"
  s.summary      = "A easy way get UDID"
  s.description  = <<-DESC
  					  A easy way get UDID With Keychain
                   DESC

  s.homepage     = "https://github.com/silence0201/KeychainUDID"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Silence" => "374619540@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/silence0201/KeychainUDID", :tag => "#{s.version}" }
  s.source_files  = "KeychainUDID", "KeychainUDID/**/*.{h,m}"
  s.exclude_files = "KeychainUDID/Exclude"
end
