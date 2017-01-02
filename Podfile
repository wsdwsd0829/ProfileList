source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

def shared_pods
    pod 'SVProgressHUD', '~> 2.0' # Progress HUD
    pod 'SDWebImage', '~>3.8' 
    pod 'AFNetworking', '~> 3.0' 
    pod 'Masonry'
#    pod "SnapKit", '3.0.2'
#    pod 'CocoaLumberjack', '~> 2.3'
#    pod "MagicalRecord"
    pod 'YBTopAlignedCollectionViewFlowLayout', :git => 'https://github.com/benski/TopAlignedCollectionViewLayout'  # UICollectionView cells with dynamic heights will be aligned at the top
end

target 'ProfileList' do
    shared_pods
end

target 'ProfileListTests' do
    shared_pods
end
