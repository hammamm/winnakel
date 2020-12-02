//
//  SuggestingView.swift
//  WainNakel
//
//  Created by hammam abdulaziz on 16/04/1442 AH.
//  Copyright © 2020 Hammam Abdulaziz - devhammam@gmail.com All rights reserved.

import UIKit

final class SuggestingView: BaseView {

    @IBOutlet weak var suggestingButton: UIButton!
    
    let viewModel = SuggestingViewModel()
    var didGetRestaurant: ((RestaurantModel?) -> Void)?
    
    @IBAction func didTap(OnSuggest sender: UIButton) -> Void {
        viewModel.configureLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
    }
}

extension SuggestingView: MapViewProtocol{
    func refreshData() {
        defer{
            didGetRestaurant?(viewModel.restuarnat)
        }
        dismiss(animated: true, completion: nil)
    }    
}
