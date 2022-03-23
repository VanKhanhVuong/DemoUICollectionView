//
//  Utils.swift
//  DemoUICollectionView
//
//  Created by admin on 22/03/2022.
//

import UIKit

class Utils {
    // Show star of the Product
    func changeColorText(number: Int, color: UIColor) -> NSMutableAttributedString {
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: "★★★★★" as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: CGFloat(18.0)) as Any])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location:0, length: number))
        return myMutableString
    }
}
