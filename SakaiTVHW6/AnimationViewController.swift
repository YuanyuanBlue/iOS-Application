//
//  AnimationViewController.swift
//  ECE564_HOMEWORK
//
//  Created by yuyuanyuan on 9/27/18.
//  Copyright © 2018 ece564. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

//This controller is used to show animation for Yuanyuan
class AnimationViewController: UIViewController {


    @IBOutlet weak var sceneView: SKView!
    @IBOutlet weak var ballPark: BallParkView!
    @IBOutlet weak var bat: UIImageView!
    
    @IBOutlet weak var rainl: UIImageView!
    @IBOutlet weak var rainr: UIImageView!
    @IBOutlet weak var baseBtn: UIButton!
    var scene:BallScene?
    var count: Int = -15
    var cloudlx: CGFloat = 0.0
    var cloudrx: CGFloat = 0.0
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "ballGame", ofType: "mp3")!))
        } catch {
            print(error)
        }
        restart()
        // Do any additional setup after loading the view.
    }

    //this function set the overall animation
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        restart()
        cloudlx = (self.rainl?.center.x)!
        cloudrx = (self.rainr?.center.x)!
        ballPark.setNeedsLayout()
        count = -15
        setAnim()
        adjustBtn()
        self.scene = BallScene(size: CGSize(width: self.sceneView.frame.size.width, height: self.sceneView.frame.size.height))
        self.sceneView.presentScene(scene)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.rainl?.center.x = cloudlx
        self.rainr?.center.x = cloudrx
        self.bat?.transform = CGAffineTransform.identity
        dayTime = .NIGHT
        stop()
    }
    //this function is used to play music
    func play() {
        audioPlayer.play()
        audioPlayer.numberOfLoops = -1
    }
    
    //this function is used to restart music
    func restart(){
        if(audioPlayer.isPlaying) {
            audioPlayer.stop()
            play()
        } else {
            play()
        }
    }
    
    //this function is used to stop music
    func stop() {
        audioPlayer.stop()
    }
    
    //this function set style to buttom button
    func adjustBtn(){
        baseBtn.layer.cornerRadius = 48
        baseBtn.backgroundColor = RICE_YELLOW
    }
    
    //this function set style to the bat image
    func animBat() {
        bat.image = UIImage(named:"bat.png")
        UIView.animate(withDuration: 6, delay: 0,
                       options: [.repeat, .curveEaseInOut, .autoreverse],
                       animations: {
                        self.bat?.transform = CGAffineTransform(rotationAngle: 2*CGFloat.pi/3)
        },
                       completion: nil
        )
    }
    
    //this function set cloud animations
    func setAnim() {
        animBat()
        rainr.image = UIImage(named:"cloudr")
        UIView.animate(withDuration: 4, delay: 0,
                       options: [.curveEaseInOut],
                       animations: {
                        self.rainr?.center.x -= 148
        },
                       completion: nil
        )
        rainl.image = UIImage(named:"cloud")
        UIView.animate(withDuration: 4, delay: 0,
                       options: [.curveEaseInOut],
                       animations: {
                        self.rainl?.center.x += 174
        },
                       completion: nil
        )
    }
    
    //this function controls to throw baseballs and stars
    @IBAction func FlyBall(_ sender: UIButton) {
        if(count == 0) {
            dayTime = .DAY
            ballPark.setNeedsLayout()
            
            var frames:[SKTexture] = []
            
            let ballAtlas = dayTime == .DAY ? SKTextureAtlas(named: "Bee") : SKTextureAtlas(named: "Mystars")
            
            for index in 1 ... 6 {
                let textureName = dayTime == .DAY ? "base_\(index)" : "star\(index)"
                let texture = ballAtlas.textureNamed(textureName)
                frames.append(texture)
            }
            
            scene?.ballFrames = frames
        }
        if(count == 15) {
            dayTime = .NIGHT
            count = -15
            ballPark.setNeedsLayout()
            
            var frames:[SKTexture] = []
            
            let ballAtlas = dayTime == .DAY ? SKTextureAtlas(named: "Bee") : SKTextureAtlas(named: "Mystars")
            
            for index in 1 ... 6 {
                let textureName = dayTime == .DAY ? "base_\(index)" : "star\(index)"
                let texture = ballAtlas.textureNamed(textureName)
                frames.append(texture)
            }
            
            scene?.ballFrames = frames
            
        }
        if let scene = self.scene {
            scene.flyBall()
        }
        count += 1
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
