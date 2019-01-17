//
//  SwimmingViewController.swift
//  SakaiTVHW6
//
//  Created by 荣欣 on 10/29/18.
//  Copyright © 2018 ece564. All rights reserved.
//

import UIKit

class SwimmingViewController: UIViewController {
        var images = [UIImage]()
        var imageViews = [UIImageView]()
        var riverColor = UIColor(red: (0/255.0), green: (213/255.0), blue: (255/255.0), alpha: 1)
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.backgroundColor = self.riverColor
            
            let landWidth = self.view.bounds.size.width
            let landHeight = self.view.bounds.size.height / 3 - 10
            let landView = LandView(frame:CGRect(x:0, y:0, width: landWidth, height: landHeight))
            self.view.addSubview(landView)
            
            drawCircle(forView:self.view)
            
            for i in 2 ... 4 {
                drawBallLines(centerY: i * 100, forView: self.view)
            }
            
            
        }
        
        //draw lifebuoy circle
        func drawCircle(forView:UIView){
            let circleLayer = CALayer()
            circleLayer.frame = CGRect(x: self.view.bounds.size.width - CGFloat(100), y: self.view.bounds.size.height - CGFloat(100), width: CGFloat(100), height: CGFloat(100))
            
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 100, height: 100), false, 0)
            let p = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 100, height: 100))
            UIColor.red.setFill()
            p.fill()
            let image =  UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            circleLayer.contents = image?.cgImage
            forView.layer.addSublayer(circleLayer)
            
            for i in 0 ... 11 {
                let t = CAShapeLayer()
                t.contentsScale = UIScreen.main.scale
                t.bounds = CGRect(x: 0, y: 0, width: 4, height: 50)
                t.anchorPoint = CGPoint(0.5, 1.0)
                t.position = circleLayer.bounds.center
                t.backgroundColor = UIColor.yellow.cgColor
                t.setAffineTransform(CGAffineTransform(rotationAngle:CGFloat(i) * .pi/6.0))
                circleLayer.addSublayer(t)
            }
            
            let path1 = UIBezierPath(ovalIn: circleLayer.bounds.insetBy(dx: 15, dy: 15))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = circleLayer.bounds
            maskLayer.path = path1.cgPath
            maskLayer.fillColor = self.riverColor.cgColor
            circleLayer.addSublayer(maskLayer)
        }
        
        //draw Ball Lines between swimming lanes
        func drawBallLines(centerY:Int, forView:UIView) {
            let ballRadius:CGFloat = CGFloat(10)
            var ballX:CGFloat = 0
            let ballXEnd:CGFloat = forView.bounds.size.width
            let ballY: CGFloat = CGFloat(centerY)
            
            let ballLayer = CAShapeLayer()
            ballLayer.contentsScale = UIScreen.main.scale
            ballLayer.frame = CGRect(x: 0, y: ballY - ballRadius, width: ballXEnd, height: 2 * ballRadius)
            forView.layer.addSublayer(ballLayer)
            
            while ballX < ballXEnd {
                let oneBallPath = UIBezierPath(arcCenter: CGPoint(x:ballRadius, y: ballRadius), radius: ballRadius, startAngle: CGFloat(0.0).toRadians(), endAngle: CGFloat(360.0).toRadians(), clockwise: true)
                let oneBallLayer = CAShapeLayer()
                oneBallLayer.frame = CGRect(x: ballX, y: 0, width: 2 * ballRadius, height: 2 * ballRadius)
                oneBallLayer.path = oneBallPath.cgPath
                oneBallLayer.fillColor = UIColor.orange.cgColor
                
                ballLayer.addSublayer(oneBallLayer)
                ballX += 2 * ballRadius
            }
        }
        
        //animating swimming players
        func animatePlayers(forView: UIView){
            self.images = [UIImage]()
            let i1 = UIImage(named: "swimming-1.png")!
            let i2 = UIImage(named: "swimming-2.png")!
            self.images += [i1, i2]
            
            self.imageViews = [UIImageView]()
            let iv1 = UIImageView()
            let iv2 = UIImageView()
            let iv3 = UIImageView()
            self.imageViews += [iv1, iv2, iv3]
            
            for i in 0 ..< self.imageViews.count {
                self.imageViews[i].frame = CGRect(x: -150, y: 200 + i*100, width: 80, height: 80)
                self.imageViews[i].animationImages = self.images
                self.imageViews[i].animationDuration = 2
                self.imageViews[i].animationRepeatCount = 0
                self.imageViews[i].startAnimating()
                forView.addSubview(self.imageViews[i])
            }
            
            
            for i in 0 ..< self.imageViews.count {
                UIView.animate(withDuration: 10, delay: TimeInterval(2*i + 1),
                               options: [.repeat, .curveEaseIn],
                               animations: {
                                self.imageViews[i].center.x = self.view.frame.width + self.imageViews[i].bounds.width / 2 + 150
                },
                               completion: nil
                )
                
            }
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            animatePlayers(forView: self.view)
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */

}
