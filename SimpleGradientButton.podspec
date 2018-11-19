Pod::Spec.new do |s|
  s.name             = 'SimpleGradientButton'
  s.version          = '1.0.0'
  s.summary          = 'Simple gradient button'
  s.description      = <<-DESC
SimpleGradientButton allows you easily create buttons with gradient and rounded corners.
                       DESC
  s.homepage         = 'https://github.com/ildar-gilfanov/SimpleGradientButton'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ildar Gilfanov' => 'gilfanov.ildar@gmail.com' }
  s.source           = { :git => 'https://github.com/ildar-gilfanov/SimpleGradientButton.git', :tag => s.version.to_s }
  s.swift_version = '4.2'
  s.ios.deployment_target = '8.0'
  s.source_files = 'Sources/**/*'
end
