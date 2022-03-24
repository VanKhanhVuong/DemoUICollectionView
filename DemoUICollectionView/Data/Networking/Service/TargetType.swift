//
//  TargetType.swift
//  DemoUICollectionView
//
//  Created by admin on 24/03/2022.
//

import Foundation

protocol TargetType {
    var baseURL: String { get }
    var param: String { get }
    var url: URL? { get }
}
