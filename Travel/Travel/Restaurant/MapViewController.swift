//
//  MapViewController.swift
//  Travel
//
//  Created by 최승범 on 5/30/24.
//

import UIKit
import MapKit
import CoreLocation

final class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let data = RestaurantList.restaurantArray
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMapView()
        configureNavigationBar()
        configureLocationManager()
        
    }
    
    @objc private func showCategory() {
        
        let category = UIAlertController(title: "종류",
                                             message: nil,
                                             preferredStyle: .actionSheet)
        let all = clearAnnotationAction()
        let koreanFood = addAlertAction(category: "한식")
        let cafe = addAlertAction(category: "카페")
        let japaneseFood = addAlertAction(category: "일식")
        let chineseFood = addAlertAction(category: "중식")
        
        
        
        let cancelAction = UIAlertAction(title: "취소",
                                         style: .cancel) { _ in
            
        }
        
        category.addAction(all)
        category.addAction(koreanFood)
        category.addAction(japaneseFood)
        category.addAction(cafe)
        category.addAction(chineseFood)
        category.addAction(cancelAction)
        
        self.present(category,
                     animated: false)
    }
    
    private func addAlertAction(category: String) -> UIAlertAction {
        
        let food = UIAlertAction(title: category,
                                 style: .default) { [weak self] _ in
            guard let self = self else { return }
            mapView.removeAnnotations(mapView.annotations)
            
            for restaurant in data {
                
                if restaurant.category == category {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: restaurant.latitude,
                                                                   longitude: restaurant.longitude)
                    annotation.title = restaurant.name
                    mapView.addAnnotation(annotation)
                }
            }
        }
        
        return food
    }
    
    private func showSettingsAlert() {
        
        let alert = UIAlertController(title: "위치 권한이 거부되었습니다",
                                      message: "앱의 모든 기능을 사용하려면 설정에서 위치 권한을 허용해주세요.",
                                      preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        let settingsAction = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(settingsAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func clearAnnotationAction() -> UIAlertAction {
        let food = UIAlertAction(title: "모두",
                                 style: .default) { [weak self] _ in
            guard let self = self else { return }
            mapView.removeAnnotations(mapView.annotations)
            
            for restaurant in data {
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: restaurant.latitude,
                                                               longitude: restaurant.longitude)
                annotation.title = restaurant.name
                mapView.addAnnotation(annotation)
            }
        }
        
        return food
    }
}

extension MapViewController {
    
    @objc private func showMyLocation() {
        
        checkDeviceLocationAuthorization()
        
        guard let location = locationManager.location else { return }
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                            longitude: location.coordinate.longitude)
        setRegionAndAnnotation(center: center)
        
        
    }
    
    private func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        
    }
    
    private func checkDeviceLocationAuthorization() {
        
        DispatchQueue.global().async { [weak self] in
            if CLLocationManager.locationServicesEnabled() {
                self?.checkCurrentLocationAuthorization()
            } else {
                print("위치 서비스가 꺼져 있습니다, 위치 권한 허용이 필요합니다.")
            }
        }
        
        
    }
    
    private func checkCurrentLocationAuthorization() {
        
        var status  = locationManager.authorizationStatus
        
        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            
            locationManager.requestWhenInUseAuthorization()
        
        case .denied:
            DispatchQueue.main.async { [weak self] in
                self?.showSettingsAlert()
            }
            
        case .authorizedWhenInUse:
            
            locationManager.startUpdatingLocation()
            
        default:
            print(status)
        }
        
    }
}

//MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
    // 사용자의 권한 상태가 변경이 된 경우
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceLocationAuthorization()
        print("변경")
    }
}


//MARK: - Configuration

extension MapViewController {
    
    private func configureMapView() {
        
        let center = CLLocationCoordinate2D(latitude: 37.515690, longitude: 126.891630)
        mapView.region = MKCoordinateRegion(center: center,
                                            latitudinalMeters: 1000,
                                            longitudinalMeters: 1000)
        for i in data {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: i.latitude,
                                                           longitude: i.longitude)
            annotation.title = i.name
            mapView.addAnnotation(annotation)
        }
    }
    
    private func configureNavigationBar() {
        
        let leftItem = UIBarButtonItem(image: UIImage(systemName: "star"),
                                       style: .plain,
                                       target: self,
                                       action: #selector(showCategory))
        
        
        
        let getMyLocationItem = UIBarButtonItem(title: "위치 가져오기",
                                                style: .plain,
                                                target: self,
                                                action: #selector(showMyLocation))
        
        navigationItem.leftBarButtonItem = leftItem
        navigationItem.rightBarButtonItem = getMyLocationItem
    }
    
    private func configureLocationManager() {
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
}

