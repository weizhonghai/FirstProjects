Pod::Spec.new do |s|

  s.name         = "FirstProjects"
  s.version      = "0.3.2"   
  s.summary      = "Just Testing."

  s.description  = <<-DESC
                       Testing Private Podspec.

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC

  s.homepage     = "https://github.com/weizhonghai/FirstProjects"
  s.license      = "MIT"

  s.author             = { "weizhonghai" => "179590100@qq.com" }

  s.source       = { :git => "https://github.com/weizhonghai/FirstProjects.git", :tag => s.version }

  s.platform     = :ios, '8.0'  

  s.requires_arc = true
#  s.public_header_files = 'FirstProjects/FirstProjects/FirstProjects/FirstProjectsPublicHead.h'
  s.source_files  = 'FirstProjects/FirstProjects/FirstProjects/PublicHead.h'
  s.frameworks = 'UIKit','Foundation','Security'
#  s.libraries = 'CommonCrypto'
#  s.ios.library = 'CommonCrypto'
  s.dependency 'YYKit', '~> 1.0.9' 
  s.dependency 'MBProgressHUD', '~> 1.0.0'
  s.dependency 'Masonry', '~> 1.0.2'
  s.dependency 'AFNetworking', '~> 3.1.0'

  s.subspec 'CALScanQRCode' do |ss|
  	ss.resource = 'FirstProjects/FirstProjects/FirstProjects/CALScanQRCode/CALScanQRCode.bundle'
  	# ss.source_files = 'FirstProjects/FirstProjects/FirstProjects/CALScanQRCode/**/*'
  	# ss.public_header_files = 'FirstProjects/FirstProjects/FirstProjects/CALScanQRCode/**/*.h'
  	ss.subspec 'Controller' do |sss|
  		sss.source_files = 'FirstProjects/FirstProjects/FirstProjects/CALScanQRCode/Controller/CALScanQRCodeViewController.{h,m}'
  		sss.public_header_files = 'FirstProjects/FirstProjects/FirstProjects/CALScanQRCode/Controller/CALScanQRCodeViewController.h'
  	end
  	ss.subspec 'Views' do |sss|
  		sss.subspec 'CALScanQRCodeCameraView' do |ssss|
  			ssss.source_files = 'FirstProjects/FirstProjects/FirstProjects/CALScanQRCode/Views/CALScanQRCodeCameraView/CALScanQRCodeCameraView.{h,m}'
  			ssss.public_header_files = 'FirstProjects/FirstProjects/FirstProjects/CALScanQRCode/Views/CALScanQRCodeCameraView/CALScanQRCodeCameraView.h'
  		end
  		sss.subspec 'CALScanQRCodeTitleView' do |ssss|
  			ssss.source_files = 'FirstProjects/FirstProjects/FirstProjects/CALScanQRCode/Views/CALScanQRCodeTitleView/CALScanQRCodeTitleView.{h,m}'
  			ssss.public_header_files = 'FirstProjects/FirstProjects/FirstProjects/CALScanQRCode/Views/CALScanQRCodeTitleView/CALScanQRCodeTitleView.h'
  		end
  	end
  end

  s.subspec 'Color+Hex' do |ss|
  	ss.source_files = 'FirstProjects/FirstProjects/FirstProjects/Color+Hex/Color+Hex.{h,m}'
  	ss.public_header_files = 'FirstProjects/FirstProjects/FirstProjects/Color+Hex/Color+Hex.h'
  end

  s.subspec 'des' do |ss|
  	ss.source_files = 'FirstProjects/FirstProjects/FirstProjects/des/*'
  	ss.public_header_files = 'FirstProjects/FirstProjects/FirstProjects/des/GTMDefines.h'
  end

  s.subspec 'HJTNetTool' do |ss|
  	ss.source_files = 'FirstProjects/FirstProjects/FirstProjects/HJTNetTool/HJTNetTool.{h,m}'
  	ss.public_header_files = 'FirstProjects/FirstProjects/FirstProjects/HJTNetTool/HJTNetTool.h'
  end

  s.subspec 'HKExtension' do |ss|
  	ss.source_files = 'FirstProjects/FirstProjects/FirstProjects/HKExtension/NSObject+HKExtension.{h,m}'
  	ss.public_header_files = 'FirstProjects/FirstProjects/FirstProjects/HKExtension/NSObject+HKExtension.h'
  end

  s.subspec 'md5' do |ss|
  	ss.source_files = 'FirstProjects/FirstProjects/FirstProjects/md5/MD5Encrypted.{h,m}'
  	ss.public_header_files = 'FirstProjects/FirstProjects/FirstProjects/md5/MD5Encrypted.h'
  end

  s.subspec 'NavgationController' do |ss|
  	ss.source_files = 'FirstProjects/FirstProjects/FirstProjects/NavgationController/WZHNavigationViewController.{h,m}'
  	ss.public_header_files = 'FirstProjects/FirstProjects/FirstProjects/NavgationController/WZHNavigationViewController.h'
  end

  s.subspec 'YBUnlimitedSlideViewController' do |ss|
  	ss.source_files = 'FirstProjects/FirstProjects/FirstProjects/YBUnlimitedSlideViewController/YBUnlimitedSlideViewController.{h,m}'
  	ss.public_header_files = 'FirstProjects/FirstProjects/FirstProjects/YBUnlimitedSlideViewController/YBUnlimitedSlideViewController.h'
  end

  s.subspec 'ZHBaseTabBar' do |ss|
  	ss.source_files = 'FirstProjects/FirstProjects/FirstProjects/ZHBaseTabBar/ZHBaseViewController.{h,m}'
  	ss.public_header_files = 'FirstProjects/FirstProjects/FirstProjects/ZHBaseTabBar/ZHBaseViewController.h'
  end

  s.subspec 'ZHkeyChain' do |ss|
  	ss.source_files = 'FirstProjects/FirstProjects/FirstProjects/ZHkeyChain/ZHkeyChain.{h,m}'
  	ss.public_header_files = 'FirstProjects/FirstProjects/FirstProjects/ZHkeyChain/ZHkeyChain.h'
  end

end

