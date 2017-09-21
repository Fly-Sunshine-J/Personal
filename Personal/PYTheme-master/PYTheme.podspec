Pod::Spec.new do |s|
    s.name         = 'PYTheme'
    s.version      = '0.2.1'
    s.summary      = 'An easy way to change theme through NSObject category for iOS.'
    s.homepage     = 'https://github.com/iphone5solo/PYTheme'
    s.license      = 'MIT'
    s.authors      = {'CoderKo1o' => '499491531@qq.com'}
    s.platform     = :ios, '7.0'
    s.source       = {:git => 'https://github.com/iphone5solo/PYTheme.git', :tag => s.version}
    s.source_files = 'PYTheme/**/*.{h,m}'
    s.requires_arc = true
end


