Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name         = "ValueTransformerKit"
  s.version      = "1.2.1"
  s.summary      = "A Swift library to play with ValueTransformer"
  s.description  = <<-DESC
                   ValueTransformerKit define some useful protocols for `ValueTransformer`.
                   Create `ValueTransformer` using closure or protocol implementations.
                   Or use one of the already implemented.
                   Use operators between `ValueTransformer`.
                   DESC
  s.homepage     = "https://github.com/phimage/ValueTransformerKit"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = "MIT"

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.author             = { "phimage" => "eric.marchand.n7@gmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source       = { :git => "https://github.com/phimage/ValueTransformerKit.git", :tag => s.version }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source_files = "Sources/*.swift"


end
