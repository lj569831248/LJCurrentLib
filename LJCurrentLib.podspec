Pod::Spec.new do |s|
s.name = 'LJCurrentLib'
s.version = '1.0.0'
s.license = 'MIT'
s.summary = '自用轮子.'
s.homepage = 'https://github.com/lj569831248/LJCurrentLib'
s.authors = { 'Jon' => 'lj569821248@163.com' }
s.source = { :git => 'https://github.com/lj569831248/LJCurrentLib.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '9.0'
s.source_files = 'Categorys/*.{h,m}','Headers/*.{h,m}','Tools/*.{h,m}'
s.dependency "MBProgressHUD"
s.dependency "Masonry"
s.dependency "FMDB"

end