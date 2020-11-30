//
//  ZoomingImageCell.swift
//  WainNakel
//
//  Created by hammam abdulaziz on 14/04/1442 AH.
//  Copyright © 2020 Hammam Abdulaziz - devhammam@gmail.com All rights reserved.

import UIKit

final class ZoomingImageCell: UICollectionViewCell {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var zoomingImage: UIImageView!
    
    static let identifier = "ZoomingImageCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareZooming()
    }
    
    func prepareZooming() -> Void {
        scrollView.isUserInteractionEnabled = true
        scrollView.bounces = true
        scrollView.bouncesZoom = true
        scrollView.contentSize = CGSize(width: zoomingImage.frame.size.width , height: zoomingImage.frame.height)
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 8.0
        scrollView.delegate = self
    }
}

extension ZoomingImageCell: UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return zoomingImage
    }
}
