Pod::Spec.new do |spec|

  spec.name             = 'ActivityRings'
  spec.version          = '1.1.0'
  spec.summary          = 'An attempt to recreate the ring controls in Apple’s Activity app'
  spec.description      = <<-DESC
                          ActivityRings is an attempt to recreate the ring controls used in Apple’s iOS and watchOS Activity app
                          DESC
  spec.homepage         = 'https://github.com/HarshilShah/ActivityRings'
  spec.license          = { type: 'MIT', file: 'LICENSE.md' }
  spec.author           = { 'Harshil Shah' => 'harshilshah1910@me.com' }
  spec.social_media_url = 'https://twitter.com/HarshilShah1910'

  spec.source           = { git: 'https://github.com/HarshilShah/ActivityRings.git', tag: spec.version.to_s }
  spec.frameworks       = 'SpriteKit'

  spec.source_files     = 'Sources/Shared/**/*.swift', 'Sources/Supporting\ Files/ActivityRings.h'
  spec.ios.source_files = 'Sources/iOS/**/*.swift'
  spec.osx.source_files = 'Sources/macOS/**/*.swift'
  spec.tvos.source_files = 'Sources/iOS/**/*.swift'

  spec.ios.deployment_target  = '8.0'
  spec.osx.deployment_target  = '10.10'
  spec.tvos.deployment_target = '9.0'

end
