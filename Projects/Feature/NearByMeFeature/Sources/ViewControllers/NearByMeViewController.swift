//
//  NearByMeViewController.swift
//  NearByMeFeature
//
//  Created by yongbeomkwak on 10/11/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import NMapsMap
import CoreLocation
import UtilityModule

class NearByMeViewController: UIViewController {

   var naverMapView:NMFNaverMapView!
    let locationManager = CLLocationManager() /// 앱에서 위치 관련 이벤트 전달을 시작하고 중지할 때 사용하는 객체
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naverMapView = NMFNaverMapView(frame: view.frame)
        view.addSubview(naverMapView)
        
        initMap()
    }
    



}

extension NearByMeViewController {
    func initMap() {
        locationManager.delegate = self
        naverMapView.mapView.mapType = .basic // 맵 타입
        naverMapView.mapView.setLayerGroup("NMF_LAYER_GROUP_BUILDING", isEnabled: true) // 레이어 그룹
        naverMapView.mapView.isIndoorMapEnabled = true
        naverMapView.mapView.buildingHeight = 0.5 // 지도의 건물 높이
        naverMapView.mapView.logoInteractionEnabled = false // 네이버 로코 탭 비 활성화
        naverMapView.showCompass = false // 나침반 제거
        naverMapView.showScaleBar = true // 축적 바 제거
        naverMapView.showZoomControls = true // 줌 버튼
        naverMapView.showIndoorLevelPicker = false // 실내지도 층 피커
        naverMapView.showLocationButton = true // 위치 추적 버튼
        naverMapView.mapView.positionMode = .normal // 위치 추적 모든 normal (위치 추적이 활성화되고, 현위치 오버레이가 사용자의 위치를 따라 움직입니다. 그러나 지도는 움직이지 않습니다.)
        
    }
    
    func checkUserDeviceLocationServiceAuthorization() {
    
        // 3.1
//       guard CLLocationManager.locationServicesEnabled() else { // 활성화 상태 여부
//           // 시스템 설정으로 유도하는 커스텀 얼럿
//           //showRequestLocationServiceAlert()
//           return
//       }
        
        // 3.2
        let authorizationStatus: CLAuthorizationStatus
            
        // 앱의 권한 상태 가져오는 코드 (iOS 버전에 따라 분기처리)
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        }else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
            
        // 권한 상태값에 따라 분기처리를 수행하는 메서드 실행
        checkUserCurrentLocationAuthorization(authorizationStatus)
        
    }
    
    func checkUserCurrentLocationAuthorization(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            // 사용자가 권한에 대한 설정을 선택하지 않은 상태
            
            // 권한 요청을 보내기 전에 desiredAccuracy 설정 필요
            
            /*
             KCLLocationAccuracyBest : 가능한 최고 수준의 정확도
             KCLLocationAccuracyKilometer : 킬로미터 기준의 정확도
             KCLLocationAccuracyThreeKilometers : 3킬로미터 기준의 정확도
             
             */
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            // 권한 요청을 보낸다.
            locationManager.requestWhenInUseAuthorization()
                
        case .denied, .restricted:
            // 사용자가 명시적으로 권한을 거부했거나, 위치 서비스 활성화가 제한된 상태
            // 시스템 설정에서 설정값을 변경하도록 유도한다.
            // 시스템 설정으로 유도하는 커스텀 얼럿
            //showRequestLocationServiceAlert()
            DEBUG_LOG("HELLO")
            
        case .authorizedWhenInUse:
            // 앱을 사용중일 때, 위치 서비스를 이용할 수 있는 상태
            // manager 인스턴스를 사용하여 사용자의 위치를 가져온다.
            locationManager.startUpdatingLocation() // : 현재 위치를 지속적으로 요청 (가져옴) → 위 코드에서 사용
            locationManager.requestLocation() // 한 번만 위치를 요청 (가져옴)
            
        default:
            DEBUG_LOG("Default")
        }
    }
}

extension NearByMeViewController: CLLocationManagerDelegate {
    
      // 사용자의 위치를 성공적으로 가져왔을 때 호출
      func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
          
          // 위치 정보를 배열로 입력받는데, 마지막 index값이 가장 정확하다고 한다.
          if let coordinate = locations.last?.coordinate {
              // ⭐️ 사용자 위치 정보 사용
          }
          
          // startUpdatingLocation()을 사용하여 사용자 위치를 가져왔다면
          // 불필요한 업데이트를 방지하기 위해 stopUpdatingLocation을 호출
          locationManager.stopUpdatingLocation()
      }
      
      
      
      
      // 사용자가 GPS 사용이 불가한 지역에 있는 등 위치 정보를 가져오지 못했을 때 호출
      func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
          DEBUG_LOG("Bad Signal")
      }
      
      
      
      
      // 앱에 대한 권한 설정이 변경되면 호출 (iOS 14 이상)
      func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
          // 사용자 디바이스의 위치 서비스가 활성화 상태인지 확인하는 메서드 호출
          checkUserDeviceLocationServiceAuthorization()
      }
      
      // 앱에 대한 권한 설정이 변경되면 호출 (iOS 14 미만)
      func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
          // 사용자 디바이스의 위치 서비스가 활성화 상태인지 확인하는 메서드 호출
          checkUserDeviceLocationServiceAuthorization()
      }
}

/*
 
 CLAccuracyAuthorization (iOS 14 ~)
 사용자가 앱에 대해 설정한, 위치 정확도 수준을 알려준다.
 iOS 14 이후로 사용자는 위치 서비스에 권한을 승인할 때, "정확한 위치" 설정을 켜거나 끌 수 있는데, 사용자가 어떤 설정으로 위치 서비스를 승인했는지 확인할 수 있다.

  

 CLAccuracyAuthorization은 열거형으로 구성되어 있다.

 case fullAccuracy :
 사용자가 "정확한 위치" 설정을 켠 상태
 앱이 완전한 정확도로 위치 데이터에 접근할 수 있다.
 case reducedAccuracy
 사용자가 "정확한 위치" 설정을 끈 상태
 앱이 낮은 정확도로 위치 데이터에 접근할 수 있다.
 // CLLocationManager의 인스턴스를 통해 접근
 locationManager.accuracyAuthorization
 
 */
