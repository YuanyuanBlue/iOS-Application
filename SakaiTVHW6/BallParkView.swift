//
//  BallParkView.swift
//  ECE564_HOMEWORK
//
//  Created by yuyuanyuan on 9/27/18.
//  Copyright © 2018 ece564. All rights reserved.
//

import UIKit

let GRA_BLUE1 = UIColor(displayP3Red: 215/255, green: 43/255, blue: 56/255, alpha: 1)
let GRA_BLUE2 = UIColor(displayP3Red: 211/255, green: 8/255, blue: 80/255, alpha: 1)
let GRA_BLUE3 = UIColor(displayP3Red: 216/255, green: 103/255, blue: 72/255, alpha: 1)
let GRA_BLUE12 = UIColor(displayP3Red: 223/255, green: 161/255, blue: 109/255, alpha: 1)
let GRA_BLUE13 = UIColor(displayP3Red: 227/255, green: 204/255, blue: 145/255, alpha: 1)
let GRA_BLUE14 = UIColor(displayP3Red: 232/255, green: 231/255, blue: 181/255, alpha: 1)

let GRA_BLUE4 = UIColor(displayP3Red: 94/255, green: 39/255, blue: 247/255, alpha: 1)
let GRA_BLUE5 = UIColor(displayP3Red: 30/255, green: 57/255, blue: 197/255, alpha: 1)
let GRA_BLUE6 = UIColor(displayP3Red: 73/255, green: 53/255, blue: 205/255, alpha: 1)
let GRA_BLUE7 = UIColor(displayP3Red: 134/255, green: 79/255, blue: 212/255, alpha: 1)
let GRA_BLUE8 = UIColor(displayP3Red: 186/255, green: 106/255, blue: 219/255, alpha: 1)
let GRA_BLUE9 = UIColor(displayP3Red: 255/255, green: 135/255, blue: 226/255, alpha: 1)
let GRA_BLUE10 = UIColor(displayP3Red: 233/255, green: 165/255, blue: 214/255, alpha: 0.6)
let GRA_BLUE11 = UIColor(displayP3Red: 240/255, green: 197/255, blue: 216/255, alpha: 0.2)
let GRASS = UIColor(displayP3Red: 139/255, green: 192/255, blue: 59/255, alpha: 1)
let RICE_YELLOW = UIColor(displayP3Red: 255/255, green: 254/255, blue: 211/255, alpha: 1)
let BROWN = UIColor(displayP3Red: 119/255, green: 165/255, blue: 51/255, alpha: 1)
let FONT = UIColor(displayP3Red: 59/255, green: 84/255, blue: 27/255, alpha: 1)

let NIGHT1 = UIColor(displayP3Red: 64/255, green: 21/255, blue: 101/255, alpha: 1)
let NIGHT2 = UIColor(displayP3Red: 64/255, green: 42/255, blue: 126/255, alpha: 1)
let NIGHT3 = UIColor(displayP3Red: 60/255, green: 40/255, blue: 174/255, alpha: 1)
let NIGHT4 = UIColor(displayP3Red: 61/255, green: 56/255, blue: 163/255, alpha: 1)
let NIGHT5 = UIColor(displayP3Red: 74/255, green: 85/255, blue: 180/255, alpha: 1)
let NIGHT6 = UIColor(displayP3Red: 95/255, green: 120/255, blue: 196/255, alpha: 1)

//This is a view class used in yuanyuan's animationView
class BallParkView: UIView {
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override class var layerClass : AnyClass {
        
        return BallParkLayer.self
    }
}

//this function draws the ballpark
class BallParkLayer : CALayer, CALayerDelegate {
    
    var hand : CALayer?
    var circlePath: CGPath?
    let circle = CAShapeLayer()
    override func layoutSublayers() {
        if dayTime == .DAY {
            self.buildSky()
        } else {
            self.buildNight()
        }
        self.buildGrass()
        self.buildLine()
        self.buildAudi()
    }
    
    //this function builds the sky and gives daytime sky colors
    func buildSky() {
        let g = CAGradientLayer()
        g.contentsScale = UIScreen.main.scale
        g.frame = self.bounds
       // print(self.bounds)
        g.colors = [
            GRA_BLUE1.cgColor,
            GRA_BLUE2.cgColor,
            GRA_BLUE3.cgColor,
            GRA_BLUE12.cgColor,
            GRA_BLUE13.cgColor,
            GRA_BLUE14.cgColor,
        ]
        g.locations = [0.08, 0.16,0.29,0.35,0.42,0.48]
        /*g.colors = [
            GRA_BLUE5.cgColor,
            GRA_BLUE6.cgColor,
            GRA_BLUE7.cgColor,
            GRA_BLUE8.cgColor,
            GRA_BLUE9.cgColor,
            GRA_BLUE10.cgColor,
            GRA_BLUE11.cgColor,
        ]
        g.locations = [0.08, 0.16,0.24,0.32,0.40,0.48,0.56]*/
        self.addSublayer(g)
    }
    
    //this function builds the sky and gives nighttime sky colors
    func buildNight() {
        let g = CAGradientLayer()
        g.contentsScale = UIScreen.main.scale
        g.frame = self.bounds
        //print(self.bounds)
        g.colors = [
            NIGHT1.cgColor,
            NIGHT2.cgColor,
            NIGHT3.cgColor,
            NIGHT4.cgColor,
            NIGHT5.cgColor,
            NIGHT6.cgColor
        ]
        g.locations = [0.08, 0.16,0.24,0.32,0.40,0.48]
        self.addSublayer(g)
    }
    
    //this function builds grass in the ballpark
    func buildGrass() {
        
        //circle.contentsScale = CGFloat(0.5)
        circle.contentsScale = UIScreen.main.scale
        circle.lineWidth = 80
        circle.fillColor = GRASS.cgColor
        circle.strokeColor = BROWN.cgColor
        let p = CGMutablePath()
        p.addEllipse(in: CGRect(x: 0, y: 0, width: 900, height: 900))
        circle.path = p
        circlePath = p
        self.addSublayer(circle)
        circle.bounds = CGRect(x: 0, y: 0, width: 900, height: 900)
        circle.position = CGPoint(x:self.bounds.maxX / 2, y:self.bounds.maxY + 130)
        
    }
    
    //this function build the auditorium and write "STRIKE" on it
    func buildAudi(){
        
        let pts = "STRIKE!"
        var ix = -3
        for c in pts {
            let t = CATextLayer()
            t.foregroundColor = FONT.cgColor
            t.contentsScale = UIScreen.main.scale
            t.string = String(c)
            t.font = UIFont(name: "Chalkduster", size: 60.0)
            t.bounds = CGRect(0,0,60,60)
            t.position = circle.bounds.center
            let vert = circle.bounds.midY / t.bounds.height
            t.anchorPoint = CGPoint(0.5, vert + 0.35)
            t.alignmentMode = kCAAlignmentCenter
            t.setAffineTransform(CGAffineTransform(rotationAngle:CGFloat(ix) * .pi/30.0))
            circle.addSublayer(t)
            ix += 1
        }
    }
    
    //this is a helper class to draw lines on the grass
    func buildLine(){
        let hand = CALayer()
        hand.contentsScale = UIScreen.main.scale
        hand.bounds = CGRect(0, 0, self.bounds.maxX, 200)
        hand.position = CGPoint(self.bounds.center.x, self.bounds.maxY)
       // print(self.bounds.center.y)
        hand.anchorPoint = CGPoint(0.5, 1)
        hand.delegate = self
        //hand.setAffineTransform(CGAffineTransform(rotationAngle:.pi))
        self.addSublayer(hand)
        hand.setNeedsDisplay()
        self.hand = hand
    }
    
    //draw lines on the grass
    func draw(_ layer: CALayer, in con: CGContext) {
        let midx = self.bounds.maxX / 2
        
        con.move(to: CGPoint(x:self.bounds.maxX / 2, y:200))
        con.addLine(to: CGPoint(x:self.bounds.maxX + 30, y:30))
        con.setLineWidth(20)
        con.setStrokeColor(RICE_YELLOW.cgColor)
        con.strokePath()
        
        con.move(to: CGPoint(x:self.bounds.maxX / 2, y:200))
        con.addLine(to: CGPoint(x:-30, y:30))
        con.setLineWidth(20)
        con.setStrokeColor(RICE_YELLOW.cgColor)
        con.strokePath()
        
        con.move(to: CGPoint(x:self.bounds.maxX / 2 + 5, y:20))
        con.addLine(to: CGPoint(x:(midx / 3), y:100))
        con.setLineWidth(20)
        con.setStrokeColor(RICE_YELLOW.cgColor)
        con.strokePath()
        
        con.move(to: CGPoint(x:self.bounds.maxX / 2 - 5, y:20))
        con.addLine(to: CGPoint(x:midx + 2 * midx / 3, y:100))
        con.setLineWidth(20)
        con.setStrokeColor(RICE_YELLOW.cgColor)
        con.strokePath()
        
    }
    
}















