//
//  clouds_toRight.swift
//  SakaiTVHW6
//
//  Created by tong on 10/20/18.
//  Copyright © 2018 ece564. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/100, green: g/100, blue: b/100, alpha: 1)
    }
}
let drawCloud = createClouds()

class clouds_toRight: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func draw(_ rect: CGRect) {
        let path = drawCloud.createclouds(a: 27, b: 10, div: 6, radius_upanddown: 21, radius_leftandright: 23)
        UIColor(r: 67.1, g: 91.4, b: 98.8).setFill()
        path.fill()
    }

}
