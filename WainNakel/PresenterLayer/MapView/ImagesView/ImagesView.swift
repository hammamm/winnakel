//
//  ImagesView.swift
//  WainNakel
//
//  Created by hammam abdulaziz on 14/04/1442 AH.
//  Copyright © 2020 Hammam Abdulaziz - devhammam@gmail.com All rights reserved.

import UIKit

protocol ImagesViewProtocol: BaseViewProtocol {
    func view() -> UIView
    func dismissView(animated: Bool, compltion: (() -> Void)?)
}

final class ImagesView: BaseView {
    
    //MARK:- OUTLETS
    @IBOutlet weak var closeView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK:- VARIBLES
    let viewModel = ImagesViewModel()
    
    //MARK:- ACTIONS
    @IBAction func handleGesture(_ sender: UIPanGestureRecognizer) {
        viewModel.handleGesture(sender)
    }

    @IBAction func didTapOnClose() -> Void {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        configuration()
    }
    
    //MARK:- METHODES
    func configuration() {
        viewModel.view = self
        closeView.setRounded()
        collectionView.register(UINib(nibName: ZoomingImageCell.identifier, bundle: nil), forCellWithReuseIdentifier: ZoomingImageCell.identifier)
        pageControl.numberOfPages = viewModel.images?.count ?? 0
    }
}

extension ImagesView: UICollectionViewDelegate{}

extension ImagesView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.item
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        viewModel.cell(collectionView, cellForItemAt: indexPath)
    }
}

extension ImagesView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

extension ImagesView: ImagesViewProtocol{
    func dismissView(animated: Bool, compltion: (() -> Void)?) {
        dismiss(animated: animated, completion: compltion)
    }
    
    func view() -> UIView {
        view
    }
}
