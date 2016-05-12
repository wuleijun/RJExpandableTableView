
Pod::Spec.new do |s|

  s.name         = "RJExpandableTableView"
  s.version      = "0.0.1"
  s.summary      = "A TableView can expand immediately or after downloading data."
  #s.description  = "A TableView can expand immediately or after downloading data."

  s.homepage     = "https://github.com/wuleijun/RJExpandableTableView"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = "MIT"

  s.author             = { "rayjuneWu" => "wuleijun8@gmail.com" }
  s.social_media_url   = "http://weibo.com/rayjuneWu"

  
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/wuleijun/RJExpandableTableView.git", :tag => "v0.0.1" }

  s.source_files  = "RJExpandableTableView.swift"
  s.framework  = "UIKit"
  s.requires_arc = true


end
