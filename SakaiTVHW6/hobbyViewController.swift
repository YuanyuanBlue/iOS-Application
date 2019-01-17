//
//  hobbyViewController.swift
//  SakaiTVHW6
//
//  Created by yuyuanyuan on 10/24/18.
//  Copyright © 2018 ece564. All rights reserved.
//

import UIKit

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

class hobbyViewController: UIViewController {

    //@IBOutlet weak var viewforhobby: UIImageView! // I don't remember what this line is for
    func createmontains(width: CGFloat, height: CGFloat, position: CGPoint) -> [CGPath] {//create mountains, each mountain has dark side and right side
        let path_lightside = UIBezierPath()
        path_lightside.move(to: CGPoint(x: position.x-width/2, y: position.y))
        path_lightside.addLine(to: CGPoint(x: position.x, y: 500-height))
        path_lightside.addLine(to: CGPoint(x: position.x-width/6, y: position.y))
        path_lightside.close()
        let path_darkside = UIBezierPath()
        path_darkside.move(to: CGPoint(x: position.x-width/6, y: position.y))
        path_darkside.addLine(to: CGPoint(x: position.x, y: 500-height))
        path_darkside.addLine(to: CGPoint(x: position.x+width/2, y: position.y))
        path_darkside.close()
        return [path_lightside.cgPath,path_darkside.cgPath]
    }
    func moveleft(view: UIView) {
        view.center.x -= 300
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up different colors, different mountains have different green colors
        let lightblue = UIColor(red: 0.624, green: 0.749, blue: 0.898, alpha: 1.0)
        let darkblue = UIColor(red: 0.165, green: 0.451, blue: 0.812, alpha: 1.0)
        let green_a = UIColor(red: 0.675, green: 0.914, blue: 0.388, alpha: 1.0)
        let green_b = UIColor(red: 0.294, green: 0.745, blue: 0.427, alpha: 1.0)
        let green_c = UIColor(red: 0.094, green: 0.565, blue: 0.235, alpha: 1.0)
        //left mountain
        let m1_1 = CAShapeLayer()
        m1_1.path = createmontains(width: 300, height: 200, position: CGPoint(x: 45, y: 500))[0]
        let m1_2 = CAShapeLayer()
        m1_2.path = createmontains(width: 300, height: 200, position: CGPoint(x: 45, y: 500))[1]
        m1_1.fillColor = lightblue.cgColor
        m1_2.fillColor = darkblue.cgColor
        view.layer.addSublayer(m1_2)
        view.layer.addSublayer(m1_1)
        //right mountain
        let m2_1 = CAShapeLayer()
        m2_1.path = createmontains(width: 200, height: 250, position: CGPoint(x: 325, y: 500))[0]
        let m2_2 = CAShapeLayer()
        m2_2.path = createmontains(width: 200, height: 250, position: CGPoint(x: 325, y: 500))[1]
        m2_1.fillColor = lightblue.cgColor
        m2_2.fillColor = darkblue.cgColor
        view.layer.addSublayer(m2_1)
        view.layer.addSublayer(m2_2)
        //middle mountain
        let m3_1 = CAShapeLayer()
        m3_1.path = createmontains(width: 350, height: 370, position: CGPoint(x: 375/2, y: 500))[0]
        let m3_2 = CAShapeLayer()
        m3_2.path = createmontains(width: 350, height: 370, position: CGPoint(x: 375/2, y: 500))[1]
        m3_1.fillColor = lightblue.cgColor
        m3_2.fillColor = darkblue.cgColor
        view.layer.addSublayer(m3_1)
        view.layer.addSublayer(m3_2)
        // Do any additional setup after loading the view.
        //greenland a
        let gl_a = CAShapeLayer()
        gl_a.path = UIBezierPath(arcCenter: CGPoint(x: 300, y: 895), radius: 470, startAngle: CGFloat(180.0).degreesToRadians, endAngle: CGFloat(0.0).degreesToRadians, clockwise: true).cgPath
        gl_a.fillColor = green_a.cgColor
        view.layer.addSublayer(gl_a)
        //greenland b
        let gl_b = CAShapeLayer()
        gl_b.path = UIBezierPath(arcCenter: CGPoint(x: 50, y: 700), radius: 230, startAngle: CGFloat(180.0).degreesToRadians, endAngle: CGFloat(0.0).degreesToRadians, clockwise: true).cgPath
        gl_b.fillColor = green_b.cgColor
        view.layer.addSublayer(gl_b)
        //greenland c
        let gl_c = CAShapeLayer()
        gl_c.path = UIBezierPath(arcCenter: CGPoint(x: 400, y: 867), radius: 370, startAngle: CGFloat(180.0).degreesToRadians, endAngle: CGFloat(0.0).degreesToRadians, clockwise: true).cgPath
        gl_c.fillColor = green_c.cgColor
        view.layer.addSublayer(gl_c)
        //rotate the person figure to make it perpendicular to the mountain
        let theta = atan2(370.0, 175.0)
        let figure : UIImageView = UIImageView(frame: CGRect(x: 3.5, y: 400, width: 50, height: 50))
        figure.image = UIImage(named: "bw-hiking.png")
        figure.transform = figure.transform.rotated(by: -CGFloat(theta))
        UIView.animate(withDuration: 13, delay: 0, options: [.curveEaseInOut], animations: {
            figure.center.x = 165
            figure.center.y = 139
        }, completion: nil)
        view.addSubview(figure)
        
        
        let cloudtoright = clouds_toRight()//create a cloud
        cloudtoright.frame = CGRect(x: -100, y: 50, width: 100, height: 150)
        //        cloud.center
        cloudtoright.backgroundColor = UIColor(white: 1, alpha: 0.0)//make background transparent
        //        UIRectFill(cloud.frame)
        //make cloud move right
        UIView.animate(withDuration: 10.0, delay: 0, options: [ .repeat, .curveEaseIn, .autoreverse], animations: {
            cloudtoright.center.x += 600
        }, completion: nil)
        
        view.addSubview(cloudtoright)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
