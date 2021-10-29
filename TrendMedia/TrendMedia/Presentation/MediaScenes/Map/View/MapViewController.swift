//
//  MapViewController.swift
//  TrendMedia
//
//  Created by meng on 2021/10/21.
//

import UIKit
import MapKit
import CoreLocation
import CoreLocationUI
import YMLogoAlert

// 1. 설정 유도
// 2. 위경도 -> 주소 변환
// 3.
class MapViewController: UIViewController {
    
    private let mapView = MKMapView()
    private var currentLocation = CLLocationCoordinate2D()
    let viewModel = TheaterLocationViewModel()
    
    lazy var locationManager: CLLocationManager = {
            let manager = CLLocationManager()
            // desiredAccuracy는 위치의 정확도를 설정함.
            // 높으면 배터리 많이 닳음.
            manager.delegate = self
            return manager
     }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        mapView.showsUserLocation = true
        setNavigationBar()
        addView()
        setConstraints()
        updateFilterAnnotations(type: "전체보기")
        checkUserLocationServicesAuthorization()
    }
    
    @objc private func didTapFilterButton(){
        showActionSheet()
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .label
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(didTapFilterButton))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    private func addView() {
        view.addSubview(mapView)
    }
    
    private func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaInsets.left)
            make.right.equalTo(view.safeAreaInsets.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: - Filter Bar Button Item
extension MapViewController {
    
    private func showActionSheet() {
        let actionSheet = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        
        Theater.allCases.forEach { theater in
            let action = UIAlertAction(title: theater.description, style: .default) { [weak self] _ in
                guard let strongself = self else { return }
                strongself.updateFilterAnnotations(type: theater.description)
            }
            actionSheet.addAction(action)
        }
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        self.present(actionSheet, animated: true)
    }
    
    private func updateFilterAnnotations(type: String) {
        mapView.removeAnnotations(mapView.annotations)
        var theaters = [TheaterLocation]()
        type == "전체보기" ? (theaters = viewModel.allTheaterList) : (theaters = viewModel.getBrandTheaters(brand: type))
        theaters.forEach { theater in
            addAnnotation(title: theater.location, latitude: theater.latitude, longitude: theater.longitude)
        }
    }
    
    private func addAnnotation(title: String, latitude: Double, longitude: Double) {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
    }
}

extension MapViewController {
    
    //iOS 버전에 따른 분기 처리와 iOS 위치 서비스 여부 확인
    func checkUserLocationServicesAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        //iOS 위치 서비스 확인
        if CLLocationManager.locationServicesEnabled() {
            //권한 상태 확인 및 권한 요청 가능
            checkCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("iOS 위치 서비스를 켜주세요")
        }
    }
    
    //사용자 권한 상태 확인 ( 프로토콜 메서드 아니고 사용자 정의 함수임)
    //사용자가 위치를 허용했는지 안했는지 거부한건지 이런 권한을 확인( 단, iOS 위치 서비스가 가능한 지 확인 )
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("notDetermined")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization() // 앱을 사용하는 동안에 대한 위치 권한 요청
            locationManager.startUpdatingLocation() // 위치 접근 시작!! didUpdateLocations실행
        case .restricted, .denied:
            print("거부됨")
        case .authorizedAlways:
            print("authorizedAlways")
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation() // 위치 접근 시작!! didUpdateLocations실행
        @unknown default:
            print("default")
        }
        
        if #available(iOS 14.0, *) {
            //정확도 체크: 정확도가 감소가 되어 있을 경우, 1시간 4번 , 미리 알림, 베터리 오래 쓸 수 있음 워치 8
            let accuracyState = locationManager.accuracyAuthorization
            switch accuracyState {
            case .fullAccuracy:
                print("fullAccuracy")
            case .reducedAccuracy:
                print("reducedAccuracy")
            @unknown default:
                print("default:")
            }
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {

    //iOS4 미만: 앱이 위치 관리자를 생성하고, 승인 상태가 변경이 될 때 대리자에게 승인 상태를 알려줌
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
    
    //iOS 14 이상: 앱이 위치 관리자를 생성하고, 승인 상태가 변경이 될 때 대리자에게 승인 상태를 알려줌.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
    
    //사용자가 위치를 허용한 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        guard let coordinate = locations.last?.coordinate else {
            print("Location Cannot Find")
            return
        }
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }
    
    //위치 접근이 실패한 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let coordinate = CLLocationCoordinate2D(latitude: 37.4847275, longitude: 126.9553)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}

