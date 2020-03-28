Pod::Spec.new do |spec|

  spec.name             = 'ActivityRings'
  spec.version          = '2.0.1'
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

  spec.source_files     = 'Sources/**/*.swift'

  spec.ios.deployment_target     = '8.0'
  spec.osx.deployment_target     = '10.10'
  spec.tvos.deployment_target    = '9.0'
  spec.watchos.deployment_target = '4.0'

  spec.ios.pod_target_xcconfig = { 'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => 'SKVIEW_AVAILABLE $(inherited)' }
  spec.osx.pod_target_xcconfig = { 'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => 'SKVIEW_AVAILABLE $(inherited)' }
  spec.tvos.pod_target_xcconfig = { 'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => 'SKVIEW_AVAILABLE $(inherited)' }

end
