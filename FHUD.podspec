Pod::Spec.new do |s|

  s.name         = "FHUD"
  s.version      = "0.5"
  s.summary      = "FHUD"
  s.homepage     = "https://github.com/hezhipeng"
  s.license      = "MIT"

  s.author             = { "Frank" => "hezhipeng1990@gmail.com" }
  s.social_media_url   = "https://www.weibo.com/2192654453"

  s.platform     = :ios, "9.0"
  s.source       = { :git =>  "https://github.com/hezhipeng/FHUD.git", :tag => s.version }
  s.swift_version = "4.2"
  s.source_files = "FHUD/**/*.{swift,h,m}"

end
