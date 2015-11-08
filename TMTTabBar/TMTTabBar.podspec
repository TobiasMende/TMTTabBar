Pod::Spec.new do |s|
  s.name         = "TMTTabBar"
  s.version      = "0.2"
  s.summary      = "TMTTabBar is a flexible tab bar view for OS X applications."
  s.description  = "This pod provides tab bars and views for OS X applications. Features include creation and deletion of tabs, drag and drop, hotkeys, ..."
  s.license      = "MIT"
  s.author       = { "Tobias Mende" => "i@tobias-men.de" }
  s.homepage     = "https://github.com/TobiasMende/TMTTabBar"
  s.osx.deployment_target = "10.11"
  s.source       = { :git => "https://github.com/TobiasMende/TMTTabBar.git", :tag => "0.2"}
  s.source_files = "TMTTabBar/**/*.{h,m}"
  s.resources    = "**/*.xib"
  s.requires_arc = true
end
