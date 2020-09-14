#
#  Be sure to run `pod spec lint ZZCAPPTestsModulesDemo.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "ZZCNavigationBar"
  s.version      = "1.5.0"
  s.summary      = "导航栏动态配置控件"
  s.description  = <<-DESC
                            能动态配置左右按钮数量、位置；title和自定义titleview；完美切换系统导航栏和自定义导航栏
                   DESC

  s.homepage     = "http://m.zuzuche.com"
  s.license      = "MIT"
  s.author             = { "cyk" => "chenyuekai@zuzuche.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "ssh://git@git-repositories.zuzuche.com:10023/zzc_mobile/zuzuche_ios_library/zzcnavigationbar.git", :tag => "v#{s.version}" }
  s.source_files  = "ZZCNavigationBar/ZZCNavigationBar/*.{h,m}"
  s.resources = "ZZCNavigationBar/ZZCNavigationBar/ZZCNavigationBar.bundle"
  s.framework  = "UIKit"
  s.requires_arc = true
  s.dependency "Masonry"
  s.dependency "Aspects"
  
  s.subspec 'FixSpace' do |fixSpace|
    fixSpace.source_files = 'ZZCNavigationBar/ZZCNavigationBar/NavigationFixSpace/*{h,m}'
  end

end
