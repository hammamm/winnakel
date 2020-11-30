//
//  MapView.swift
//  WainNakel
//
//  Created by hammam abdulaziz on 12/04/1442 AH.
//  Copyright © 2020 Hammam Abdulaziz - devhammam@gmail.com All rights reserved.

import UIKit
import MapKit

final class MapView: BaseView {
    //MARK:- OUTLETS
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    //MARK:- VARIBLES
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
        controller.modalPresentationStyle = .fullScreen
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
    
    //MARK:- LIFECYCLE
    override func loadView() {
        let controller = SuggestingView()
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overFullScreen
        present(controller, animated: false, completion: nil)
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        configuration()
    }
    
    //MARK:- METHODES
    func setData() -> Void {
        headerTitle = "وين ناكل ؟"
    }
    
    func configuration() -> Void {
        map.showsUserLocation = true
    }
}
