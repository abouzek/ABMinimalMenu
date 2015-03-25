Pod::Spec.new do |s|
  s.name             = "ABMinimalMenu"
  s.version          = "0.4.0"
  s.summary          = "A simple menu with easily customizable animations and an easy to use interface."
  s.description      = "A simple menu with easily customizable animations and an easy to use interface. ABMinimalMenu provides a simple form of menu navigation which can be tailored to many use cases."
  s.homepage         = "https://github.com/abouzek/ABMinimalMenu"
  s.license          = 'MIT'
  s.author           = { "abouzek" => "alan.bouzek@gmail.com" }
  s.source           = { :git => "https://github.com/abouzek/ABMinimalMenu.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/alanbouzek'

  s.platform     = :ios, '7.1'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resources = ['Pod/Assets/*.png']
  s.resource_bundles = {
    'ABMinimalMenu' => ['Pod/Assets/*.png']
  }
end
