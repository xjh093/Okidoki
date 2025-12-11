Pod::Spec.new do |spec|
  spec.name         = "Okidoki"
  spec.version      = "0.0.2"
  spec.summary      = "Object-C UI Chaining Syntax."

  spec.description  = <<-DESC
  Object-C UI Chaining Syntax. 666
                   DESC

  spec.homepage     = "https://github.com/xjh093/Okidoki"
  spec.license      = "MIT"
  spec.author       = { "Haomissyou" => "xjh093@126.com" }
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/xjh093/Okidoki.git", :tag => spec.version.to_s }

  spec.source_files = "Okidoki/**/*.{h,m}"
  spec.public_header_files = "Okidoki/*.h"
  
end
