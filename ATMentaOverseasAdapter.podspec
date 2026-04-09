Pod::Spec.new do |s|
    s.name             = 'ATMentaOverseasAdapter'
    s.version          = '7.01.03'
    s.summary          = 'ATMentaOverseasAdapter.'
    s.description      = 'This is the ATMentaOverseasAdapter. Please proceed to https://www.mentamob.com for more information.'
    s.homepage         = 'https://www.mentamob.com/'
    s.license          = "Custom"
    s.author           = { 'mentasdk' => 'mentasdk.vip@gmail.com' }
    s.source           = { :git => "https://github.com/mentasdk/Taku_iOS_Demo.git", :tag => "#{s.version}" }
  
    s.ios.deployment_target = '12.0'
    s.static_framework = true
  
    s.source_files = 'ATMentaOverseasAdapter/**/*'
    s.swift_versions = ['5.0']

    s.dependency 'MentaBaseGlobal', '~> 1.0.27'
    s.dependency 'MentaMediationGlobal', '~> 1.0.27'
    s.dependency 'MentaVlionGlobal', '~> 1.0.27'
    s.dependency 'MentaVlionGlobalAdapter', '~> 1.0.27'
    s.dependency 'AnyThinkiOS'
    s.dependency 'AnyThinkMediationAdxSmartdigimktCNAdapter'
  
  end
