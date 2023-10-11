#  NaverMap 가이드 라인


### 1. NMFMapView , NMFNaverMapView
- 지도 객체

- NMFNaverMapView: 지도에 필요한 기본적인 UI가 구현돼 있으므로 보다 쉽게 지도 앱을 구현할 수 있습니다.
    - mpaView 변수가 있으며 mapView는 NMFMapView 타입이다.

- mapType: 속성을 지정하면 지도의 유형을 변경할 수 있습니다. 
종류는 다음과 같습니다.


<br>

        Basic: 일반 지도입니다. 하천, 녹지, 도로, 심벌 등 다양한 정보를 노출합니다.

        Navi: 차량용 내비게이션에 특화된 지도입니다.

        Satellite: 위성 지도입니다. 심벌, 도로 등 위성 사진을 제외한 요소는 노출되지 않습니다.

        Hybrid: 위성 사진과 도로, 심벌을 함께 노출하는 지도입니다.
        
        Terrain: 지형도입니다. 산악 지형을 실제 지형과 유사하게 입체적으로 표현합니다.

<br>

### 2. 지도 옵션

```swift

        naverMapView.mapView.mapType = .basic // 맵 타입
        naverMapView.mapView.setLayerGroup("NMF_LAYER_GROUP_BUILDING", isEnabled: true) // 레이어 그룹
        naverMapView.mapView.isIndoorMapEnabled = true
        naverMapView.mapView.buildingHeight = 0.5 // 지도의 건물 높이
        naverMapView.mapView.logoInteractionEnabled = false // 네이버 로코 탭 비 활성화
        naverMapView.showCompass = false // 나침반 제거
        naverMapView.showScaleBar = true // 축적 바 제거
        naverMapView.showZoomControls = true // 줌 버튼
        naverMapView.showIndoorLevelPicker = false // 실내지도 층 피커
        naverMapView.showLocationButton = true // 우치 추적 모드

```

### 3. 위치 추적 모드
- info.plist 
    - Privacy - Location When In Use Usage Description 설정

### 3. NMGLatLng
- NMGLatLng는 하나의 위경도 좌표를 나타내는 클래스입니다. 
- latNMGLatLng(py)lat) 속성이 위도를, lngNMGLatLng(py)lng) 속성이 경도를 나타냅니다. 
- NMGLatLng의 모든 속성은 생성자로만 지정할 수 있고, 한 번 생성된 객체의 속성은 **변경할 수 없습니다**.
- 네이버 지도 SDK는 NMGLatLng 외에도 몇 가지 자주 사용되는 좌표계를 제공합니다. 지원하는 좌표계는 다음과 같습니다.


        WebMercatorCoord: 웹 메르카토르 좌표계 

        Utmk: UTM-K 좌표계의 좌표

        Tm128: TM-128 좌표계의 좌표

- 각 클래스의 -toLatLng 메서드를 사용해 다른 좌표를 위경도 좌표로 변환하거나, NMGLatLng를 파라메터로 받는 생성자를 사용해 위경도 좌표를 해당하는 좌표로 변환할 수 있습니다.

<br>

