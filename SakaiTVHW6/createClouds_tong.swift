//
//  createClouds.swift
//  SakaiTVHW6
//
//  Created by tong on 10/20/18.
//  Copyright © 2018 ece564. All rights reserved.
//

import UIKit

class createClouds: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func createclouds(a: Double, b: Double, div: Double, radius_upanddown: CGFloat, radius_leftandright: CGFloat) -> UIBezierPath {
        let points = stride(from: 0.0, to: 1.0, by: 1/div).map { CGPoint(x: a * cos(2 * Double.pi * $0)+50, y: b * sin(2 * Double.pi * $0)+100) }
        let path = UIBezierPath()
        path.move(to: points[0])
        for point in points {//[1..<points.count] {
            path.addLine(to: point)
        }
        path.close()
        for i in 0..<points.count {
            if i == 0 || i == Int(div/2) {
                let circ = UIBezierPath(arcCenter: points[i], radius: radius_leftandright, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi*2), clockwise: true)
                path.append(circ)
            } else {
                let circ = UIBezierPath(arcCenter: points[i], radius: radius_upanddown, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi*2), clockwise: true)
                path.append(circ)
            }
        }
        return path
    }

}
