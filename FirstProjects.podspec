Pod::Spec.new do |s|

  s.name         = "FirstProjects"
  s.version      = "0.2.0"   
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
  s.public_header_files = 'FirstProjects/FirstProjects/FirstProjects/*.h'
  s.source_files  = 'FirstProjects/FirstProjects/FirstProjects/PublicHead.h'
  s.frameworks = 'UIKit','Foundation' 
  s.dependency 'YYKit', '~> 1.0.9' 
  s.dependency 'MBProgressHUD', '~> 1.0.0'
  s.dependency 'Masonry', '~> 1.0.2'
  s.dependency 'AFNetworking', '~> 3.1.0'
end

