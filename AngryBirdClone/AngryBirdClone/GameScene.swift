//
//  GameScene.swift
//  AngryBirdClone
//
//  Created by Pelin ASLAN on 14.05.2021.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //var bird2 = SKSpriteNode()
    
    var bird = SKSpriteNode()

    
    
    var monster1 =  SKSpriteNode()
    var monster2 =  SKSpriteNode()

    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    var box6 = SKSpriteNode()
    var box7 = SKSpriteNode()
    var box8 = SKSpriteNode()
    var box9 = SKSpriteNode()
    
    
    var layer = SKSpriteNode()

   
    
    var gameStarted = false
    
    var originalPosition : CGPoint?

    var score = 0
    var scoreLabel = SKLabelNode()
    
    enum ColliderType: UInt32{
        case Bird = 1
        case Box = 2
        case Monster = 4
    }
    
    override func didMove(to view: SKView)
    {
        
        playSound()
        
        //Physics Body
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.scene?.scaleMode = .aspectFit
        self.physicsWorld.contactDelegate = self
        
        
        //Bird
        bird = childNode(withName: "bird") as! SKSpriteNode //I get the "bird" object I created with gameScene
        
        let birdTexture = SKTexture(imageNamed: "bird")
        
        //physical characteristics
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 12)
        bird.physicsBody?.affectedByGravity = false //gravity
        bird.physicsBody?.isDynamic = true //physical animation effects
        bird.physicsBody?.mass = 0.15 //weight
        originalPosition = bird.position
        
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Monster.rawValue //collisions with box only
        
        //monster
        let monsterTexture = SKTexture(imageNamed: "monster")
        let monstersize = CGSize(width: monsterTexture.size().width/12, height: monsterTexture.size().height/12)
      
        monster1 = childNode(withName: "monster1") as! SKSpriteNode
        monster1.physicsBody = SKPhysicsBody(rectangleOf: monstersize)
        monster1.physicsBody?.isDynamic = true
        monster1.physicsBody?.affectedByGravity = true
        monster1.physicsBody?.allowsRotation = true
        monster1.physicsBody?.mass = 0.2
        
        monster1.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
       // monster1originalPosition = monster1.position
        
        monster2 = childNode(withName: "monster2") as! SKSpriteNode
        monster2.physicsBody = SKPhysicsBody(rectangleOf: monstersize)
        monster2.physicsBody?.isDynamic = true
        monster2.physicsBody?.affectedByGravity = true
        monster2.physicsBody?.allowsRotation = true
        monster2.physicsBody?.mass = 0.2
        
        monster2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        //monster2originalPosition = monster2.position
        


        //Box
        
        let boxTexture = SKTexture(imageNamed: "brick")
        let size = CGSize(width: boxTexture.size().width/7, height: boxTexture.size().height/7)
        
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody = SKPhysicsBody(rectangleOf: size)
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.affectedByGravity = true
        box1.physicsBody?.allowsRotation = true
        box1.physicsBody?.mass = 0.15
        
        //box1.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        //box1originalPosition = box1.position
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: size)
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.allowsRotation = true
        box2.physicsBody?.mass = 0.15
        
       // box2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        //box2originalPosition = box2.position
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: size)
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.allowsRotation = true
        box3.physicsBody?.mass = 0.15
        
       // box3.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        //box3originalPosition = box3.position
        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: size)
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.allowsRotation = true
        box4.physicsBody?.mass = 0.15
        
        box4.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
       // box4originalPosition = box4.position
        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf: size)
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.allowsRotation = true
        box5.physicsBody?.mass = 0.15
        
        //box5.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        //box5originalPosition = box5.position
        
        box6 = childNode(withName: "box6") as! SKSpriteNode
        box6.physicsBody = SKPhysicsBody(rectangleOf: size)
        box6.physicsBody?.isDynamic = true
        box6.physicsBody?.affectedByGravity = true
        box6.physicsBody?.allowsRotation = true
        box6.physicsBody?.mass = 0.15
        
       // box6.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
       // box6originalPosition = box6.position
        
        
        //Label
        
        scoreLabel.fontName = "Star Wars"
        scoreLabel.fontColor = UIColor.black
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 3)
        scoreLabel.zPosition = 2
        self.addChild(scoreLabel)
    
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue{
            
            score += 100
            scoreLabel.text = String(score)
           
        }
        
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        /*
        //fly
        bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 150))
        bird.physicsBody?.affectedByGravity = true //gravity
         */
        
        if gameStarted == false{
            
            if let touch = touches.first{
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false{
                    for node in touchNodes{
                        
                        if let sprite = node as? SKSpriteNode{
                            
                            if sprite == bird{
                                bird.position = touchLocation
                            }
                            
                        }
                    }
                }
            }
        }
        
        
       
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false{
            
            if let touch = touches.first{
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false{
                    for node in touchNodes{
                        
                        if let sprite = node as? SKSpriteNode{
                            
                            if sprite == bird{
                                bird.position = touchLocation
                            }
                            
                        }
                    }
                }
            }
        }
       
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false{
            
            if let touch = touches.first{
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false{
                    for node in touchNodes{
                        
                        if let sprite = node as? SKSpriteNode{
                            
                            if sprite == bird{
                               
                                let dx = -(touchLocation.x - originalPosition!.x)
                                let dy = -(touchLocation.y - originalPosition!.y)
                                
                                let impulse = CGVector(dx: dx, dy: dy)
                                
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                
                                gameStarted = true
                                
                            }
                            
                        }
                    }
                }
            }
        }
       
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if let birdPhysicsBody = bird.physicsBody{
            
            if birdPhysicsBody.velocity.dx <= 0.1 && birdPhysicsBody.velocity.dy <= 0.1 && birdPhysicsBody.angularVelocity <= 0.1 && gameStarted == true{
                
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx:0,dy:0)
                bird.position = originalPosition!
                
              
             
                
                score = 0
                scoreLabel.text = String(score)
                
                gameStarted = false
            }
        }
       
    }
    


    var player: AVAudioPlayer?

    func playSound() {
        guard let url = Bundle.main.url(forResource: "music", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
