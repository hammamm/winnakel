//
//  MapView.swift
//  WainNakel
//
//  Created by hammam abdulaziz on 12/04/1442 AH.
//  Copyright © 2020 Hammam Abdulaziz - devhammam@gmail.com All rights reserved.

import UIKit
import MapKit

protocol MapViewProtocol: BaseViewProtocol {}

final class MapView: BaseView {
    //MARK:- OUTLETS
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var detailsview: UIView!
    @IBOutlet weak var suggestButton: UIButton!
    
    //MARK:- VARIBLES
    let viewModel = MapViewModel()
    var restuarant: RestaurantModel?{
        didSet{
            nameLabel.text = restuarant?.name
            rateLabel.text = restuarant?.rateAndCat
        }
    }
    
    //MARK:- ACTIONS
    @IBAction func didTap(OnImages sender: UIButton) -> Void {
        let controller = ImagesView()
        controller.viewModel._interactor = interactor
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .coverVertical
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func didTap(OnLocation sender: UIButton) -> Void {
        if let locaiton = restuarant?.location{
            openGoogleMap(location: locaiton)
        }
    }
    
    @IBAction func didTap(OnShare sender: UIButton) -> Void {
        share("""
            We will eat in \(restuarant?.name ?? "") today

            \(restuarant?.link ?? "")
            """
        )
    }
    
    @IBAction func didTap(OnSuggession sender: UIButton) -> Void {
        viewModel.configureLocation()
    }

    //MARK:- LIFECYCLE    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        configuration()
        showSuggestView()
    }
    
    //MARK:- METHODES
    func setData() -> Void {
        headerTitle = "وين ناكل ؟"
    }
    
    func configuration() -> Void {
        viewModel.view = self
    }
    
    func showSuggestView() -> Void {
        let controller = SuggestingView()
        controller.didGetRestaurant = { [weak self]  restuarant in
            self?.detailsview.alpha = 1
            self?.suggestButton.alpha = 1
            self?.restuarant = restuarant
        }
        controller.modalPresentationStyle = .overFullScreen
        present(controller, animated: false, completion: nil)
    }
    override func refreshUi() {
        if let resturant = viewModel.restuarnat{
            if let annotation = map.markPin(restaurant: resturant){
                map.removeAnnotations(map.annotations)
                map.addAnnotation(annotation)
            }
        }
    }
}

extension MapView: MapViewProtocol{
    
}

extension MapView: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        let annotaionView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
        annotaionView.setWidth(width: 22)
        annotaionView.setHeight(height: 22)
//        annotaionView.layer.borderWidth = 1
//        annotaionView.layer.borderColor = UIColor.white.cgColor
//        annotaionView.layer.cornerRadius = 11
        annotaionView.image = .location
        annotaionView.annotation = annotation
        annotaionView.canShowCallout = true
        return annotaionView
    }
}
