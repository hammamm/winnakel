//
//  ImagesViewModel.swift
//  WainNakel
//
//  Created by hammam abdulaziz on 15/04/1442 AH.
//  Copyright © 2020 Hammam Abdulaziz - devhammam@gmail.com All rights reserved.

import UIKit

final class ImagesViewModel: BaseViewModel {
    
    weak var view: ImagesViewProtocol?
    var images: [String]?
    var _interactor:Interactor? = nil

    func handleGesture(_ sender: UIPanGestureRecognizer) -> Void {
        guard let view = view else { return }
        let percentThreshold:CGFloat = 0.3
        // convert y-position to downward pull progress (percentage)
        let translation = sender.translation(in: view.view())
        let verticalMovement = translation.y / view.view().bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        guard let interactor = _interactor else { return }
        
        switch sender.state {
        case .began:
            interactor.hasStarted = true
            view.dismissView(animated: true, compltion: nil)
        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(progress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish
                ? interactor.finish()
                : interactor.cancel()
        default:
            break
        }
    }
    
    func cell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZoomingImageCell.identifier, for: indexPath) as? ZoomingImageCell else { return UICollectionViewCell() }
        if let image = images?[indexPath.item]{
            cell.zoomingImage.loadImage(urlString: image)
        }
        return cell
    }
    
}
