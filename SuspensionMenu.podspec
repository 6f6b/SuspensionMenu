Pod::Spec.new do |s|

  s.name         = "SuspensionMenu"
  s.version      = "1.0.3"
  s.summary      = "Suspension Menu Sina"
  s.description  = <<-DESC

      最多三行代码即可创建一个类似于新浪微博的发布菜单，高动态化、高性能。
                   DESC
  s.homepage     = "https://github.com/LincLiu/SuspensionMenu"
  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author       = { "Feng" => "dev.liufeng@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/LincLiu/SuspensionMenu.git", :tag => s.version }
  s.source_files  = "Classes/*.swift"
  s.resources    = "Resources/*.{png,xib,nib,bundle}"
  s.frameworks   = "UIKit"
  s.requires_arc = true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }
end
