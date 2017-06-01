Pod::Spec.new do |spec|
    spec.name = 'TinyEvents'
    spec.version = '1.0.0'
    spec.author = 'Jon Colverson'
    spec.license = 'MIT'
    spec.homepage = 'https://github.com/JJC1138/tiny-events'
    spec.source = { :git => 'https://github.com/JJC1138/tiny-events.git', :tag => spec.version }
    spec.summary = 'A tiny event system for Swift (1 source file, 59 lines of code)'

    spec.ios.deployment_target = '10.0'
    spec.osx.deployment_target = '10.12'
    spec.tvos.deployment_target = '10.0'
    spec.watchos.deployment_target = '3.0'

    spec.source_files = 'Sources/*.swift'
end
