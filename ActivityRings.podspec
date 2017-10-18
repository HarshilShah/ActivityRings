Pod::Spec.new do |spec|
  spec.name             = 'ActivityRings'
  spec.version          = '1.0.0'
  spec.summary          = 'An attempt to recreate the ring controls in Apple’s Activity app'
  spec.description      = <<-DESC
                          ActivityRings is an attempt to recreate the ring controls used in Apple’s iOS and watchOS Activity app
                          DESC
  spec.homepage         = 'https://github.com/HarshilShah/ActivityRings'
  spec.license          = { type: 'MIT', file: 'LICENSE.md' }
  spec.author           = { 'Harshil Shah' => 'harshilshah1910@me.com' }
  spec.social_media_url = 'https://twitter.com/HarshilShah1910'

  spec.source           = { git: 'https://github.com/HarshilShah/ActivityRings.git', tag: spec.version.to_s }
  spec.ios.deployment_target = '8.0'
  spec.ios.source_files = 'Sources/**/*.{h,swift}'
  spec.ios.frameworks   = 'SpriteKit'
end
