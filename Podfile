workspace 'TMTTabBar.xcworkspace'
xcodeproj 'TMTTabBar.xcodeproj'

platform :osx, '10.10'

target :TMTTabBar do

end

target :TMTTabBarDemo do
	pod 'TMTTabBar', :path => './TMTTabBar'
  link_with 'TMTTabBar'
end

target :TMTTabBarTests do
  pod 'TMTTabBar', :path => './TMTTabBar'
  pod 'OCMock'
  link_with 'TMTTabBar'
end
