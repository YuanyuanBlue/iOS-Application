//
//  BallScene.swift
//  ECE564_HOMEWORK
//
//  Created by yuyuanyuan on 9/28/18.
//  Copyright © 2018 ece564. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

var dayTime: SKY = .NIGHT

let CLEAR = UIColor(displayP3Red: 95/255, green: 120/255, blue: 196/255, alpha: 0.6)
//This class is used for Yuanyuan's animation view
class BallScene: SKScene {
    var ballFrames:[SKTexture]?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        if(dayTime == .DAY) {
         self.backgroundColor = GRA_BLUE3
        } else {
         self.backgroundColor = CLEAR
        }
        var frames:[SKTexture] = []
        
        let ballAtlas = dayTime == .DAY ? SKTextureAtlas(named: "Bee") : SKTextureAtlas(named: "Mystars")
        
        for index in 1 ... 6 {
            let textureName = dayTime == .DAY ? "base_\(index)" : "star\(index)"
            let texture = ballAtlas.textureNamed(textureName)
            
            frames.append(texture)
        }
        
        self.ballFrames = frames
        
    }
    
    //this function controls the fly path of the baseball
    func flyBall() {
        
        if(dayTime == .DAY) {
            self.backgroundColor = GRA_BLUE14
        } else {
            self.backgroundColor = CLEAR
        }
        
        let texture = self.ballFrames![0]
        
        let ball = SKSpriteNode(texture: texture)
        
        ball.size = CGSize(width: 40, height: 40)
        
        let randomBallYPositionGenerator = GKRandomDistribution(lowestValue: 0, highestValue: Int(self.frame.size.height))
        let yPosition = CGFloat(randomBallYPositionGenerator.nextInt())
        
        let rightToLeft = arc4random() % 2 == 0
        
        let xPosition = rightToLeft ? self.frame.size.width + ball.size.width / 2 : -ball.size.width / 2
        
        ball.position = CGPoint(x: xPosition, y: yPosition)
        
        if rightToLeft {
            ball.xScale = -1
        }
        
        self.addChild(ball)
        
        ball.run(SKAction.repeatForever(SKAction.animate(with: self.ballFrames!, timePerFrame: 0.1, resize: false, restore: true)))
        
        var distanceToCover = (self.frame.size.width + ball.size.width)/2
        
        if rightToLeft {
            distanceToCover *= -1
        }
        
        let time = TimeInterval(abs(distanceToCover / 200))
        
        let moveAction = SKAction.moveBy(x: distanceToCover, y: 100, duration: time)
        let moveAction2 = SKAction.moveBy(x: distanceToCover, y: -100, duration: time)
        
        let removeAction = SKAction.run {
            ball.removeAllActions()
            ball.removeFromParent()
        }
        
        let allActions = SKAction.sequence([moveAction,moveAction2, removeAction])
        
        ball.run(allActions)
        
        
    }

}
