
Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.name = "BeagleUI"
  spec.version = "0.1.0"
  spec.summary = "This is the Beagle framework for iOS"
  spec.description = <<-DESC
    We encourage you to use Beagle from Carthage, since it is the preferred
    way of using it. But if you are willing to just test Beagle, you can use this 
    pod instead.
  DESC
  spec.homepage = "https://zup-products.gitbook.io/beagle/"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.license = "MIT"

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.author = "Zup IT"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.platform = :ios, "10.0"
  
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
  # pod 'YogaKit', :git => 'git@github.com:lucasaraujo/yoga.git'
  # We need this because we fixed an issue in the original repository and our PR was not merged yet.
  spec.dependency 'YogaKit'

end
