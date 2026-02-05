Pod::Spec.new do |s|
    s.name             = 'ATMentaCNAdapter'
    s.version          = '7.01.01'
    s.summary          = 'ATMentaCNAdapter.'
    s.description      = 'This is the ATMentaCNAdapter. Please proceed to https://www.mentamob.com for more information.'
    s.homepage         = 'https://www.mentamob.com/'
    s.license          = "Custom"
    s.author           = { 'mentasdk' => 'mentasdk.vip@gmail.com' }
    s.source           = { :git => "https://github.com/mentasdk/Taku_iOS_Demo.git", :tag => "#{s.version}" }
  
    s.ios.deployment_target = '12.0'
    s.frameworks = 'UIKit', 'MapKit', 'MediaPlayer', 'CoreLocation', 'AdSupport', 'CoreMedia', 'AVFoundation', 'CoreTelephony', 'StoreKit', 'SystemConfiguration', 'MobileCoreServices', 'CoreMotion', 'Accelerate','AudioToolbox','JavaScriptCore','Security','CoreImage','AudioToolbox','ImageIO','QuartzCore','CoreGraphics','CoreText'
    s.libraries = 'c++', 'resolv', 'z', 'sqlite3', 'bz2', 'xml2', 'iconv', 'c++abi'
    s.weak_frameworks = 'WebKit', 'AdSupport'
    s.static_framework = true
  
    s.source_files = 'ATMentaCNAdapter/**/*'
    s.swift_versions = ['5.0']

    s.dependency 'MentaVlionBaseSDK', '~> 7.00.17'
    s.dependency 'MentaUnifiedSDK',   '~> 7.00.17'
    s.dependency 'MentaVlionSDK',     '~> 7.00.17'
    s.dependency 'MentaVlionAdapter', '~> 7.00.17'
    s.dependency 'AnyThinkiOS'
    s.dependency 'AnyThinkMediationAdxSmartdigimktCNAdapter'
  
  end
