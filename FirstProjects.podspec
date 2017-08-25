Pod::Spec.new do |s|

  s.name         = "FirstProjects"
  s.version      = "0.1.2"   
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

  s.source_files  = 'FirstProjects/FirstProjects/FirstProjects/*.{h,m}', 'FirstProjects/FirstProjects/FirstProjects/*.{h,m}'

  s.frameworks = 'Foundation'    
end

