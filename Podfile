platform :ios, '10.3'
use_frameworks!
inhibit_all_warnings!

target 'Mercadolibre' do    
    pod 'Alamofire', '~> 4.5'        
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'Swinject'
    pod 'RxDataSources'
    pod 'SwiftyJSON', '~> 4.0'
    pod 'PKHUD', '~> 5.0'
    post_install do |installer|
        installer.pods_project.build_configurations.each do |config|
            config.build_settings.delete('CODE_SIGNING_ALLOWED')
            config.build_settings.delete('CODE_SIGNING_REQUIRED')
        end
    end

    target 'MercadolibreTests' do
        inherit! :search_paths
        
    end
end


