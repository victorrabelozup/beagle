
Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.name = "BeagleUI"
  spec.version = "0.1.0"
  spec.summary = "This is the Beagle framework for iOS"
  spec.description = <<-DESC
    Use Beagle framework to help your project to achieve Backend Driven UI
  DESC
  spec.homepage = "https://www.zup.com.br"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.license = "MIT"

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.author = "Zup IT"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.platform = :ios, "10.0"
  spec.swift_version = "4.1"
  
  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.source = { :git => "git@github.com:ZupIT/darwin-beagle-ios.git", :branch => "master" }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.source_files = "Sources/BeagleUI/Sources/**/*.swift"

  spec.exclude_files = 
    "Sources/BeagleUI/Sources/**/Test/**/*.swift",
    "Sources/BeagleUI/Sources/**/Tests/**/*.swift",
    "Sources/BeagleUI/Sources/**/*Tests*.swift",
    "Sources/BeagleUI/Sources/**/*Test*.swift",
    "Sources/BeagleUI/Sources/**/*Tests.swift",
    "Sources/BeagleUI/Sources/**/*Test.swift"

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  # make sure to declare YogaKit on your Podfile as:
  # pod 'YogaKit', :git => 'git@github.com:facebook/yoga.git', :tag => '1.17.0'
  # this will make it use the proper version of the dependency
  spec.dependency 'YogaKit', '1.17.0'

end
