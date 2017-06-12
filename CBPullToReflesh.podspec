Pod::Spec.new do |s|
  s.name             = 'CBPullToReflesh'
  s.version          = '1.0.0'
  s.summary          = 'Mobile page refresh concept inspired by Google and for something like a news app.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage         = 'https://github.com/cbangchen/CBPullToReflesh'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'cbangchen' => 'cbangchen007@gmail.com' }
  s.source           = { :git => 'https://github.com/cbangchen/CBPullToReflesh.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'CBPullToReflesh/Classes/**/*'
  s.frameworks = 'UIKit', 'Foundation'

end
