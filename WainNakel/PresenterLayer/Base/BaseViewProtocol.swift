//
//  BaseViewProtocol.swift
//  WainNakel
//
//  Created by hammam abdulaziz on 15/04/1442 AH.
//  Copyright © 2020 Hammam Abdulaziz - devhammam@gmail.com All rights reserved.

import Foundation

protocol BaseViewProtocol: AnyObject {
    func didFailWithError(_ error: String)
    func didFailWithNetworkError(_ error: NSError, completion: (() -> Void)?)
    func didFailWithError(_ error: NSError)
    func loading(_ start: Bool)
    func refreshUi()
    func alert(title: String, buttonTitle: String, body: String, completion: (() -> Void)?) -> Void
}
