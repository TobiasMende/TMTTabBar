Pod::Spec.new do |s|
  s.name         = "TMTTabBar"
  s.version      = "0.0.1"
  s.summary      = "TMTTabBar is a flexible tab bar view for OS X applications."
  s.description  = "Note: This pod is currently in a very early stage and not functional"
  s.license      = "MIT"
  s.author       = { "Tobias Mende" => "tobias.mende@tobsolution.de" }
  s.osx.deployment_target = "10.9"
  s.source       = { :git => "http://github.com/TobiasMende/TMTTabBar.git" :tag => "0.0.1"}
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
end
