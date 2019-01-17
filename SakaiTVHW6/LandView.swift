//
//  LandView.swift
//  SakaiTVHW6
//
//  Created by 荣欣 on 10/29/18.
//  Copyright © 2018 ece564. All rights reserved.
//

import UIKit

//Extention of CGFloat to calculate radian values
//Credit to "https://www.appcoda.com/bezier-paths-introduction"

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}

class LandView: UIView {

    var path:UIBezierPath = UIBezierPath()
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.drawLandLayer()
        drawTextLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = .white
    }
    
    func drawLandLayer(){
        let landLayer = CALayer()
        landLayer.contentsScale = UIScreen.main.scale
        landLayer.frame = self.bounds
        landLayer.backgroundColor = UIColor.green.cgColor
        self.layer.addSublayer(landLayer)
        
        let imageWidth:CGFloat = self.bounds.width/4
        let imageHeight:CGFloat = self.bounds.height
        for i in 0...3 {
            let imageLayer = CALayer()
            imageLayer.frame = CGRect(x:CGFloat(i) * imageWidth, y:0, width:imageWidth, height:imageHeight)
            imageLayer.contents = UIImage(named:"tree")?.cgImage
            imageLayer.contentsGravity = kCAGravityResizeAspect
            landLayer.addSublayer(imageLayer)
        }
    }
    
    func drawTextLayer() {
        let textLayer = CATextLayer()
        textLayer.string = "Pratt Swimming Tournament"
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.font = UIFont(name: "Arial", size: 20.0)
        textLayer.fontSize = 24.0
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.backgroundColor = UIColor.magenta.cgColor
        textLayer.frame = CGRect(x: 0.0, y: self.frame.size.height - 50, width: self.frame.size.width, height: 40.0)
        textLayer.contentsScale = UIScreen.main.scale
        self.layer.addSublayer(textLayer)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
