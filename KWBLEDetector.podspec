Pod::Spec.new do |s|

  s.name         = "KWBLEDetector"
  s.version      = "1.3"
  s.summary      = "A quick tool to create in-app KWBLEDetector."

  s.description  = <<-DESC
                    This is a quick tool to create in-app KWBLEDetector.
                   DESC

  s.homepage     = "https://github.com/hayasilin/KWBLEDetector.git"

  s.license      = 'MIT'

  s.author       = { "hayasilin" => "harvey.hayasi@gmail.com" }
  
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/hayasilin/KWBLEDetector.git", :tag => s.version.to_s }

  s.source_files  = "KWBLEDetector", "KWBLEDetector/**/**/*"

  s.requires_arc  = true

end
