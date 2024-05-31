//
//  MapViewController.swift
//  Travel
//
//  Created by 최승범 on 5/30/24.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let data = RestaurantList.restaurantArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMapView()
        configureNavigationBar()
        
    }
    
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
        
        navigationItem.leftBarButtonItem = leftItem
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



