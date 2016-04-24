import UIKit; import QuartzCore; import SceneKit; import MultipeerConnectivity; import AVFoundation

let screenSize: CGRect = UIScreen.mainScreen().bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height

struct BoardLoc { var x: Int; var y: Int }
struct MoveList { var total: Int; var moveArray: Array<Move> }
enum PieceType { case Empty, BluePiece, RedPiece, BlueBean, RedBean, Bean }

class GameViewController: UIViewController, MCBrowserViewControllerDelegate {

    var appDelegate:AppDelegate!
    var timer1 = NSTimer()
    var timer2 = NSTimer()
    var timer3 = NSTimer()
    var pauseCount = 0
    var boardNumber = 0
    var currentPlayer:String!
    var boardArray: Array<Array<PieceType>> = []
    var selBall = 0
    var selLoc: BoardLoc?
    var rows = 16
    var cols = 9
    var cellWidth = 0
    var cellHeight = 0
    var pSizeW = 0.1
    var pSizeH = 0.1
    var blueBeanActive = false
    var redBeanActive = false
    var blueCaptured = 7
    var redCaptured = 7
    var aiDirection = 0
    var aiStall = 0
    var helpersOn = true
    var multiPlayerRulesOn = false
    var aiOpen = false
    var peopleOpen = false
    var navyOpen = false
    var garbanzoOpen = false
    var soyOpen = false
    var kidneyOpen = false
    var adzukiOpen = false
    var blackOpen = false
    var pintoOpen = false
    var mungOpen = false
    var fabaOpen = false
    var coffeeOpen = false
    var winnerOpen = false
    var sfxVol = 3
    var musicVol = 3
    var staticAI = false
    var staticPlayer = false
    var teachingPart = 1
    var multiNumber = 0
    var multiWinnerLoser = 0
    var colorPickBlue = 0
    var colorPickRed = 0
    var winLoseMarker = "gameOn"
    var boardChecker = 0
    
    var bgMusic = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("gamesoundtrack", ofType: "mp3")!))
    var fingerTap = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("tapButton", ofType: "wav")!))
    var iaccordian = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("iaccordian", ofType: "mp3")!))
    var ibalalaika = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ibalalaika", ofType: "mp3")!))
    var icowbell = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("icowbell", ofType: "mp3")!))
    var ididgeridoo = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ididgeridoo", ofType: "mp3")!))
    var iglassharmonica = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("iglassharmonica", ofType: "mp3")!))
    var imoog = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("imoog", ofType: "mp3")!))
    var iorgan = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("iorgan", ofType: "mp3")!))
    var itrumpet = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("itrumpet", ofType: "mp3")!))
    var ixylophone = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ixylophone", ofType: "mp3")!))
    var izuesophone = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("izeusophone", ofType: "mp3")!))
    var tvTap1 = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("tvclick1", ofType: "mp3")!))
    var tvTap2 = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("tvclick2", ofType: "mp3")!))
    var tvTap3 = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("tvclick3", ofType: "mp3")!))
    var tvTap4 = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("tvclick4", ofType: "mp3")!))
    var tvTap5 = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("tvclick5", ofType: "mp3")!))
    var pickup1 = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("click1", ofType: "mp3")!))
    var putdown1 = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("clack1", ofType: "mp3")!))
    var pickup2 = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("click2", ofType: "mp3")!))
    var putdown2 = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("clack2", ofType: "mp3")!))
    var pickup3 = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("click3", ofType: "mp3")!))
    var putdown3 = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("clack3", ofType: "mp3")!))
    var pickup4 = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("click4", ofType: "mp3")!))
    var putdown4 = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("clack4", ofType: "mp3")!))
    var pickup5 = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("click5", ofType: "mp3")!))
    var putdown5 = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("clack5", ofType: "mp3")!))
    var pickup6 = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("click6", ofType: "mp3")!))
    var putdown6 = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("clack6", ofType: "mp3")!))
    var soundWin = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("guitarRiffHappy", ofType: "mp3")!))
    var fireworkSound = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("firework", ofType: "mp3")!))
    var soundLoseThud = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("loseNoise", ofType: "mp3")!))
    var swordClang = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("swords", ofType: "mp3")!))
    
    override func viewDidLoad() { super.viewDidLoad(); addAppDelegateMultipeerConnectivityHandeler(); addBoardArray(); addBackgroundMusic(); menuScene() }
    
    
    func addAppDelegateMultipeerConnectivityHandeler() {
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.mpcHandler.setupPeerWithDisplayName(UIDevice.currentDevice().name)
        appDelegate.mpcHandler.setupSession()
        appDelegate.mpcHandler.advertiseSelf(true)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.handleReceivedDataWithNotification(_:)), name: "MPC_DidReceiveDataNotification", object: nil)
    }
    
    func waitThenWin() {
        timer1 = NSTimer.scheduledTimerWithTimeInterval(0.7, target: self, selector: #selector(GameViewController.waitTwoSecondsThenWin), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer1, forMode: NSRunLoopCommonModes)
    }
    
    func waitThenLose() {
        timer2 = NSTimer.scheduledTimerWithTimeInterval(0.7, target: self, selector: #selector(GameViewController.waitTwoSecondsThenLose), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer2, forMode: NSRunLoopCommonModes)
    }
    
    func waitThenMove() {
        timer3 = NSTimer.scheduledTimerWithTimeInterval(0.7, target: self, selector: #selector(GameViewController.waitOneSecondThenMovePiece), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer3, forMode: NSRunLoopCommonModes)
    }
    
    func waitThenMoveShorter() {
        timer3 = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: #selector(GameViewController.waitOneSecondShorterThenMovePiece), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer3, forMode: NSRunLoopCommonModes)
    }
    
    func waitThenMoveLonger() {
        timer3 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(GameViewController.waitOneSecondLongerThenMovePiece), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer3, forMode: NSRunLoopCommonModes)
    }
    
    func waitTwoSecondsThenWin() {
        pauseCount += 1
        if (pauseCount == 2) {
            gameOverYouWin()
        }
    }
    
    func waitTwoSecondsThenLose() {
        pauseCount += 1
        if (pauseCount == 2) {
            gameOverYouLose()
        }
    }
    
    func waitOneSecondThenMovePiece() {
        pauseCount += 1
        if (pauseCount == 2) {
            moveAI()
        }
    }
    
    func waitOneSecondShorterThenMovePiece() {
        pauseCount += 1
        if (pauseCount == 2) {
            moveAI()
        }
    }
    
    func waitOneSecondLongerThenMovePiece() {
        pauseCount += 1
        if (pauseCount == 2) {
            moveAI()
        }
    }
    
    func addBoardArray() {
        for x in 0..<cols {
            boardArray.append(Array(count:rows, repeatedValue: .Empty))
            for y in 0..<rows {
                boardArray[x][y] = .Empty
            }
        }
    }
    
    func addBackgroundMusic() {
        bgMusic!.numberOfLoops = 100
        bgMusic!.play()
    }
    
//////////////////
//  MENU SCENE  //
//////////////////
    
    func menuScene() {
        timer1.invalidate()
        timer2.invalidate()
        pauseCount = 0
        
        selBall = 0
        currentPlayer = "x"
        teachingPart = 1
        staticAI = true
        cols = 9
        rows = 16
        pSizeW = 7
        pSizeH = 7
        cellWidth = Int(screenWidth/7)
        cellHeight = Int(screenHeight/13)
        
        if musicVol == 4 { bgMusic!.volume = 0.6 }
        if musicVol == 3 { bgMusic!.volume = 0.08 }
        if musicVol == 2 { bgMusic!.volume = 0.01 }
        if musicVol == 1 { bgMusic!.volume = 0.00001 }
        soundLoseThud!.stop()
        soundWin!.stop()
        fireworkSound!.stop()
        iaccordian!.stop()
        ibalalaika!.stop()
        icowbell!.stop()
        imoog!.stop()
        iorgan!.stop()
        itrumpet!.stop()
        ixylophone!.stop()
        izuesophone!.stop()
        iglassharmonica!.stop()
        ididgeridoo!.stop()
        
        let scene = SCNScene(named: "art.scnassets/MenuScene.dae")!
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 12, y: -25.5, z: 54.5)
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 17, y: -34, z: 50)
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = true
        scnView.showsStatistics = false
        scnView.backgroundColor = UIColor.whiteColor()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GameViewController.handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
        
        for x in 0..<cols {
            boardArray.append(Array(count:rows, repeatedValue: .Empty))
            for y in 0..<rows {
                boardArray[x][y] = .Empty
            }
        }
        
        let title1 = scnView.scene!.rootNode.childNodeWithName("title1", recursively: true)
        let title2 = scnView.scene!.rootNode.childNodeWithName("title2", recursively: true)
        let title3 = scnView.scene!.rootNode.childNodeWithName("title3", recursively: true)
        let title4 = scnView.scene!.rootNode.childNodeWithName("title4", recursively: true)
        let title5 = scnView.scene!.rootNode.childNodeWithName("title5", recursively: true)
        let title1color = scnView.scene!.rootNode.childNodeWithName("title1color", recursively: true); title1color!.opacity = 0
        let title2color = scnView.scene!.rootNode.childNodeWithName("title2color", recursively: true); title2color!.opacity = 0
        let title3color = scnView.scene!.rootNode.childNodeWithName("title3color", recursively: true); title3color!.opacity = 0
        let title4color = scnView.scene!.rootNode.childNodeWithName("title4color", recursively: true); title4color!.opacity = 0
        let title5color = scnView.scene!.rootNode.childNodeWithName("title5color", recursively: true); title5color!.opacity = 0
        
        let backgroundnormal = scnView.scene!.rootNode.childNodeWithName("backgroundnormal", recursively: true); backgroundnormal!.opacity = 0
        let learnbutton = scnView.scene!.rootNode.childNodeWithName("learnbutton", recursively: true); learnbutton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        let vsaibutton = scnView.scene!.rootNode.childNodeWithName("vsaibutton", recursively: true); vsaibutton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        let peepsbutton = scnView.scene!.rootNode.childNodeWithName("peepsbutton", recursively: true); peepsbutton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        let soundbutton = scnView.scene!.rootNode.childNodeWithName("soundbutton", recursively: true); soundbutton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        let guidebutton = scnView.scene!.rootNode.childNodeWithName("guidebutton", recursively: true); guidebutton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        let backgroundcolor = scnView.scene!.rootNode.childNodeWithName("backgroundcolor", recursively: true); backgroundcolor!.opacity = 0
        let learncolor = scnView.scene!.rootNode.childNodeWithName("learncolor", recursively: true); learncolor!.opacity = 0
        let vsaicolor = scnView.scene!.rootNode.childNodeWithName("vsaicolor", recursively: true); vsaicolor!.opacity = 0
        let peepscolor = scnView.scene!.rootNode.childNodeWithName("peepscolor", recursively: true); peepscolor!.opacity = 0
        let soundcolor = scnView.scene!.rootNode.childNodeWithName("soundcolor", recursively: true); soundcolor!.opacity = 0
        let guidecolor = scnView.scene!.rootNode.childNodeWithName("guidecolor", recursively: true); guidecolor!.opacity = 0
        
        let sfxOff = scnView.scene!.rootNode.childNodeWithName("effectsvoloff", recursively: true); sfxOff!.opacity = 0
        let sfxLo = scnView.scene!.rootNode.childNodeWithName("effectsvollow", recursively: true); sfxLo!.opacity = 0
        let sfxMid = scnView.scene!.rootNode.childNodeWithName("effectsvolmid", recursively: true); sfxMid!.opacity = 0
        let sfxHi = scnView.scene!.rootNode.childNodeWithName("effectsvolhigh", recursively: true); sfxHi!.opacity = 0
        let musicOff = scnView.scene!.rootNode.childNodeWithName("musicoff", recursively: true); musicOff!.opacity = 0
        let musicLo = scnView.scene!.rootNode.childNodeWithName("musiclow", recursively: true); musicLo!.opacity = 0
        let musicMid = scnView.scene!.rootNode.childNodeWithName("musicmid", recursively: true); musicMid!.opacity = 0
        let musicHi = scnView.scene!.rootNode.childNodeWithName("musichigh", recursively: true); musicHi!.opacity = 0
        let guideson = scnView.scene!.rootNode.childNodeWithName("guideson", recursively: true); guideson!.opacity = 0
        let guidesoff = scnView.scene!.rootNode.childNodeWithName("guidesoff", recursively: true); guidesoff!.opacity = 0
        
        let bean01 = scnView.scene!.rootNode.childNodeWithName("bean01", recursively: true); bean01!.opacity = 0
        let bean02 = scnView.scene!.rootNode.childNodeWithName("bean02", recursively: true); bean02!.opacity = 0
        let bean03 = scnView.scene!.rootNode.childNodeWithName("bean03", recursively: true); bean03!.opacity = 0
        let bean04 = scnView.scene!.rootNode.childNodeWithName("bean04", recursively: true); bean04!.opacity = 0
        let bean05 = scnView.scene!.rootNode.childNodeWithName("bean05", recursively: true); bean05!.opacity = 0
        let bean06 = scnView.scene!.rootNode.childNodeWithName("bean06", recursively: true); bean06!.opacity = 0
        let bean07 = scnView.scene!.rootNode.childNodeWithName("bean07", recursively: true); bean07!.opacity = 0
        let bean08 = scnView.scene!.rootNode.childNodeWithName("bean08", recursively: true); bean08!.opacity = 0
        let bean09 = scnView.scene!.rootNode.childNodeWithName("bean09", recursively: true); bean09!.opacity = 0
        let bean10 = scnView.scene!.rootNode.childNodeWithName("bean10", recursively: true); bean10!.opacity = 0
        let piece1 = scnView.scene!.rootNode.childNodeWithName("piece1", recursively: true); piece1!.opacity = 0
        let piece2 = scnView.scene!.rootNode.childNodeWithName("piece2", recursively: true); piece2!.opacity = 0
        let piece3 = scnView.scene!.rootNode.childNodeWithName("piece3", recursively: true); piece3!.opacity = 0
        let piece4 = scnView.scene!.rootNode.childNodeWithName("piece4", recursively: true); piece4!.opacity = 0
        let piece5 = scnView.scene!.rootNode.childNodeWithName("piece5", recursively: true); piece5!.opacity = 0
        
        let popIn = SCNAction.fadeInWithDuration(0.001)
        let popOut = SCNAction.fadeOutWithDuration(0.001)
        let scaleUp = SCNAction.scaleBy(2, duration: 0.2)
        let scaleDown = SCNAction.scaleBy(0.5, duration: 0.1)
        let bumpUp = SCNAction.scaleBy(1.5, duration: 2)
        let waitASec = SCNAction.waitForDuration(0.3)
        let waveWait1 = SCNAction.waitForDuration(1.6)
        let waveWait2 = SCNAction.waitForDuration(1.8)
        let waveWait3 = SCNAction.waitForDuration(2.0)
        let waveWait4 = SCNAction.waitForDuration(2.2)
        let waveWait5 = SCNAction.waitForDuration(2.4)
        let waveWait6 = SCNAction.waitForDuration(2.6)
        let waveWait7 = SCNAction.waitForDuration(2.8)
        let waveWait8 = SCNAction.waitForDuration(3.0)
        let waveWait9 = SCNAction.waitForDuration(3.2)
        let waveWait10 = SCNAction.waitForDuration(3.4)
        let wait11 = SCNAction.waitForDuration(11)
        let wait30 = SCNAction.waitForDuration(30)
        let wait60 = SCNAction.waitForDuration(60)
        let wait90 = SCNAction.waitForDuration(90)
        backgroundnormal!.runAction(SCNAction.fadeInWithDuration(2.0))
        backgroundnormal!.runAction(SCNAction.sequence([ wait11, popOut, waitASec, popIn, waitASec, popOut, waitASec, popIn, popOut, waitASec, popIn]))
        backgroundcolor!.runAction(SCNAction.sequence([ wait11, popIn, waitASec, popOut, waitASec, popIn, waitASec, popOut,waitASec, popIn]))
        
        let moveTitle1 = SCNAction.moveTo(SCNVector3(x: 0.4, y: 0, z: 0.2), duration: 0.5)
        let moveTitle2 = SCNAction.moveTo(SCNVector3(x: 7, y: 0, z: 0.2), duration: 0.2)
        let moveTitle3 = SCNAction.moveTo(SCNVector3(x: 14.9, y: 0, z: 0.2), duration: 0.3)
        let moveTitle4 = SCNAction.moveTo(SCNVector3(x: 21.8, y: 0, z: 0.2), duration: 0.5)
        let moveTitle5 = SCNAction.moveTo(SCNVector3(x: 29.2, y: 0, z: 0.2), duration: 0.55)
        let moveTitle1b = SCNAction.moveTo(SCNVector3(x: 0.4, y: -7.0, z: 0.2), duration: 0.2)
        let moveTitle2b = SCNAction.moveTo(SCNVector3(x: 7, y: -7.0, z: 0.2), duration: 0.2)
        let moveTitle3b = SCNAction.moveTo(SCNVector3(x: 14.7, y: -7.0, z: 0.2), duration: 0.1)
        let moveTitle4b = SCNAction.moveTo(SCNVector3(x: 21.8, y: -7.0, z: 0.2), duration: 0.3)
        let moveTitle5b = SCNAction.moveTo(SCNVector3(x: 29.0, y: -7.0, z: 0.2), duration: 0.3)
        title1!.runAction(SCNAction.sequence([moveTitle1, moveTitle1b]))
        title2!.runAction(SCNAction.sequence([moveTitle2, moveTitle2b]))
        title3!.runAction(SCNAction.sequence([moveTitle3, moveTitle3b]))
        title4!.runAction(SCNAction.sequence([moveTitle4, moveTitle4b]))
        title5!.runAction(SCNAction.sequence([moveTitle5, moveTitle5b]))
        
        backgroundnormal!.opacity = 1.0
        learnbutton!.runAction(SCNAction.sequence([SCNAction.waitForDuration(0.3), SCNAction.scaleBy(1250, duration: 0.3), SCNAction.scaleBy(0.8, duration: 0.2)]))
        vsaibutton!.runAction(SCNAction.sequence([SCNAction.waitForDuration(0.8), SCNAction.scaleBy(1250, duration: 0.3), SCNAction.scaleBy(0.8, duration: 0.2)]))
        peepsbutton!.runAction(SCNAction.sequence([SCNAction.waitForDuration(1.3), SCNAction.scaleBy(1250, duration: 0.3), SCNAction.scaleBy(0.8, duration: 0.2)]))
        soundbutton!.runAction(SCNAction.sequence([SCNAction.waitForDuration(1.8), SCNAction.scaleBy(1250, duration: 0.3), SCNAction.scaleBy(0.8, duration: 0.2)]))
        guidebutton!.runAction(SCNAction.sequence([SCNAction.waitForDuration(2.3), SCNAction.scaleBy(1250, duration: 0.3), SCNAction.scaleBy(0.8, duration: 0.2)]))
        
        if navyOpen == true { bean01!.runAction(SCNAction.sequence([waveWait1, popIn, scaleUp, scaleDown, scaleUp, scaleDown, bumpUp])) }
        if garbanzoOpen == true { bean02!.runAction(SCNAction.sequence([waveWait2, popIn, scaleUp, scaleDown, scaleUp, scaleDown, bumpUp])) }
        if soyOpen == true { bean03!.runAction(SCNAction.sequence([waveWait3, popIn, scaleUp, scaleDown, scaleUp, scaleDown,bumpUp])) }
        if adzukiOpen == true { bean04!.runAction(SCNAction.sequence([waveWait4, popIn, scaleUp, scaleDown, scaleUp, scaleDown,bumpUp])) }
        if pintoOpen == true { bean05!.runAction(SCNAction.sequence([waveWait5, popIn, scaleUp, scaleDown, scaleUp, scaleDown, bumpUp])) }
        if blackOpen == true { bean06!.runAction(SCNAction.sequence([waveWait6, popIn, scaleUp, scaleDown, scaleUp, scaleDown, bumpUp])) }
        if kidneyOpen == true { bean07!.runAction(SCNAction.sequence([waveWait7, popIn, scaleUp, scaleDown, scaleUp, scaleDown, bumpUp])) }
        if mungOpen == true { bean08!.runAction(SCNAction.sequence([waveWait8, popIn, scaleUp, scaleDown, scaleUp, scaleDown, bumpUp])) }
        if fabaOpen == true { bean09!.runAction(SCNAction.sequence([waveWait9, popIn, scaleUp, scaleDown, scaleUp, scaleDown, bumpUp])) }
        if coffeeOpen == true { bean10!.runAction(SCNAction.sequence([waveWait10, popIn, scaleUp, scaleDown, scaleUp, scaleDown, bumpUp])) }
        
        piece1!.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: 0, z: -2.8, duration: 1.5)))
        piece2!.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: 0, z: 2.8, duration: 1.5)))
        piece3!.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: 0, z: -2.8, duration: 1.5)))
        piece4!.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: 0, z: 2.8, duration: 1.5)))
        piece5!.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: 0, z: -2, duration: 1.5)))
        let moveRight = SCNAction.moveTo(SCNVector3(x: 45.0, y: -56, z: 0.25), duration: 4)
        let moveLeft = SCNAction.moveTo(SCNVector3(x: -8, y: -56, z: 0.25), duration: 4)
        piece1!.runAction(SCNAction.repeatActionForever(SCNAction.sequence([wait11, popIn, moveRight, popOut, moveLeft, wait11])))
        piece2!.runAction(SCNAction.repeatActionForever(SCNAction.sequence([wait30, popIn, moveLeft, popOut, moveRight])))
        piece3!.runAction(SCNAction.repeatActionForever(SCNAction.sequence([wait30, waveWait2, wait11, popIn, moveRight, popOut, moveLeft, wait11])))
        piece4!.runAction(SCNAction.repeatActionForever(SCNAction.sequence([wait60, popIn, moveLeft, popOut, moveRight])))
        piece5!.runAction(SCNAction.repeatActionForever(SCNAction.sequence([wait90, wait11, popIn, moveRight, popOut, moveLeft, wait11])))
    }
    
    func teachScene() {
        multiPlayerRulesOn = false
        staticPlayer = false
        let scene = SCNScene(named: "art.scnassets/TeachScene.dae")!
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 12, y: -25.5, z: 54.5)
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 17, y: -34, z: 50)
        scene.rootNode.addChildNode(lightNode)
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = false
        scnView.showsStatistics = false
        scnView.backgroundColor = UIColor.blackColor()
        
        currentPlayer = "x"
        boardNumber = 0
        cols = 5
        rows = 9
        pSizeW = 7
        pSizeH = 7
        blueBeanActive = false
        redBeanActive = false
        blueCaptured = 3
        redCaptured = 2
        cellWidth = Int(screenWidth/5)
        cellHeight = Int(screenHeight/9)
        
        let newGameButton = scnView.scene!.rootNode.childNodeWithName("newgame", recursively: true); newGameButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        let mainmenubutton = scnView.scene!.rootNode.childNodeWithName("mainmenubutton", recursively: true); mainmenubutton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        let blue1 = scnView.scene!.rootNode.childNodeWithName("Blue01", recursively: true); blue1!.position.x = 14; blue1!.position.y = -42; blue1!.position.z = -1.5
        let blue2 = scnView.scene!.rootNode.childNodeWithName("Blue02", recursively: true); blue2!.position.x = 7; blue2!.position.y = -49; blue2!.position.z = -1.5
        let blue3 = scnView.scene!.rootNode.childNodeWithName("Blue03", recursively: true); blue3!.position.x = 21; blue3!.position.y = -49; blue3!.position.z = -1.5
        let red2 = scnView.scene!.rootNode.childNodeWithName("Red02", recursively: true)
        let red3 = scnView.scene!.rootNode.childNodeWithName("Red03", recursively: true)
        let newBean = scnView.scene!.rootNode.childNodeWithName("NewBean", recursively: true)
        let dir01b = scnView.scene!.rootNode.childNodeWithName("dir01b", recursively: true)
        let dir02b = scnView.scene!.rootNode.childNodeWithName("dir02b", recursively: true)
        let dir03b = scnView.scene!.rootNode.childNodeWithName("dir03b", recursively: true)
        let dir04b = scnView.scene!.rootNode.childNodeWithName("dir04b", recursively: true)
        let dir05b = scnView.scene!.rootNode.childNodeWithName("dir05b", recursively: true)
        let dir06b = scnView.scene!.rootNode.childNodeWithName("dir06b", recursively: true)
        let dir07b = scnView.scene!.rootNode.childNodeWithName("dir07b", recursively: true)
        let dir08b = scnView.scene!.rootNode.childNodeWithName("dir08b", recursively: true)
        let dir09b = scnView.scene!.rootNode.childNodeWithName("dir09b", recursively: true)
        
        if  teachingPart == 1 {
            staticAI = true
            red2!.opacity = 0; red3!.opacity = 0; newBean!.opacity = 0
            dir02b!.opacity = 0; dir03b!.opacity = 0; dir04b!.opacity = 0; dir05b!.opacity = 0
            dir06b!.opacity = 0; dir07b!.opacity = 0; dir09b!.opacity = 0; dir08b!.opacity = 0
            for x in 0..<cols {
                boardArray.append(Array(count:cols, repeatedValue: .Empty))
                for y in 0..<rows {
                    if x == 2 && y == 6 || x == 1 && y == 7 || x == 3 && y == 7 { boardArray[x][y] = .BluePiece }
                    else { boardArray[x][y] = .Empty }
                }
            }
        }
        
        if  teachingPart == 2 {
            staticAI = false
            red2!.position.x = 7; red2!.position.y = -21; red2!.position.z = -1.5; red2!.opacity = 1
            red3!.position.x = 21; red3!.position.y = -21; red3!.position.z = -1.5; red3!.opacity = 1
            newBean!.opacity = 0
            dir01b!.opacity = 0; dir02b!.opacity = 0; dir04b!.opacity = 0; dir05b!.opacity = 0
            dir06b!.opacity = 0; dir07b!.opacity = 0; dir08b!.opacity = 0; dir09b!.opacity = 0
            
            for x in 0..<cols {
                boardArray.append(Array(count:cols, repeatedValue: .Empty))
                for y in 0..<rows {
                    if x == 2 && y == 6 || x == 1 && y == 7 || x == 3 && y == 7 { boardArray[x][y] = .BluePiece }
                    else if x == 1 && y == 3 || x == 3 && y == 3 { boardArray[x][y] = .RedPiece }
                    else { boardArray[x][y] = .Empty }
                }
            }
        }
        
        if  teachingPart == 3 {
            staticAI = true
            red2!.opacity = 0; red3!.opacity = 0
            newBean!.opacity = 1
            dir01b!.opacity = 0; dir02b!.opacity = 0; dir03b!.opacity = 0; dir04b!.opacity = 0
            dir05b!.opacity = 0; dir06b!.opacity = 0; dir07b!.opacity = 0; dir09b!.opacity = 0
            for x in 0..<cols {
                boardArray.append(Array(count:cols, repeatedValue: .Empty))
                for y in 0..<rows {
                    if x == 2 && y == 6 || x == 1 && y == 7 || x == 3 && y == 7 { boardArray[x][y] = .BluePiece }
                    else if x == 2 && y == 4 { boardArray[x][y] = .Bean }
                    else { boardArray[x][y] = .Empty }
                }
            }
        }
    }
    
    
/////////////////////////////
//   SINGLE PLAYER SCENES  //
/////////////////////////////

    func board1Scene() {
        multiPlayerRulesOn = false
        staticAI = false
        staticPlayer = false
        let scene = SCNScene(named: "art.scnassets/Board1Scene.dae")!
        let subScene = SCNScene(named: "art.scnassets/SubMenuScene.dae")!

        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 12, y: -25.5, z: 54.5)
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 17, y: -34, z: 50)
        scene.rootNode.addChildNode(lightNode)
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = true
        scnView.showsStatistics = false
        scnView.backgroundColor = UIColor.blackColor()

        currentPlayer = "x"
        boardNumber = 1
        cols = 5
        rows = 9
        pSizeW = 7
        pSizeH = 7
        blueBeanActive = false
        redBeanActive = false
        aiStall = 0
        aiDirection = 0
        blueCaptured = 3
        redCaptured = 3
        cellWidth = Int(screenWidth/5)
        cellHeight = Int(screenHeight/9)
        for x in 0..<cols {
            boardArray.append(Array(count:rows, repeatedValue: .Empty))
            for y in 0..<rows {
                if x == 2 && y == 6 || x == 1 && y == 7 || x == 3 && y == 7 {
                    boardArray[x][y] = .BluePiece
                }
                else if x == 1 && y == 1 || x == 2 && y == 2 || x == 3 && y == 1 {
                    boardArray[x][y] = .RedPiece
                }
                else if x == 2 && y == 4 {
                    boardArray[x][y] = .Bean
                }
                else { boardArray[x][y] = .Empty
                }
            }
        }
        
        let blue1 = scnView.scene!.rootNode.childNodeWithName("Blue01", recursively: true)
        let blue2 = scnView.scene!.rootNode.childNodeWithName("Blue02", recursively: true)
        let blue3 = scnView.scene!.rootNode.childNodeWithName("Blue03", recursively: true)
        let red1 = scnView.scene!.rootNode.childNodeWithName("Red01", recursively: true)
        let red2 = scnView.scene!.rootNode.childNodeWithName("Red02", recursively: true)
        let red3 = scnView.scene!.rootNode.childNodeWithName("Red03", recursively: true)
        blue1!.position.x = 14; blue1!.position.y = -42; blue1!.position.z = -1.5
        blue2!.position.x = 7; blue2!.position.y = -49; blue2!.position.z = -1.5
        blue3!.position.x = 21; blue3!.position.y = -49; blue3!.position.z = -1.5
        red1!.position.x = 14; red1!.position.y = -14; red1!.position.z = -1.5
        red2!.position.x = 7; red2!.position.y = -7; red2!.position.z = -1.5
        red3!.position.x = 21; red3!.position.y = -7; red3!.position.z = -1.5
        
        let blueHome = scnView.scene!.rootNode.childNodeWithName("BlueHome", recursively: true)
        let blueHomeEffect = scnView.scene!.rootNode.childNodeWithName("BlueHomeEffect", recursively: true)
        let redHome = scnView.scene!.rootNode.childNodeWithName("RedHome", recursively: true)
        let redHomeEffect = scnView.scene!.rootNode.childNodeWithName("RedHomeEffect", recursively: true)
        blueHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        redHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        blueHome!.opacity = 0.5
        redHome!.opacity = 0.5
        
        let yellow = scnView.scene!.rootNode.childNodeWithName("YellowFlare", recursively: true)
        let posN = scnView.scene!.rootNode.childNodeWithName("PossibleN", recursively: true)
        let posS = scnView.scene!.rootNode.childNodeWithName("PossibleS", recursively: true)
        let posE = scnView.scene!.rootNode.childNodeWithName("PossibleE", recursively: true)
        let posW = scnView.scene!.rootNode.childNodeWithName("PossibleW", recursively: true)
        let posNE = scnView.scene!.rootNode.childNodeWithName("PossibleNE", recursively: true)
        let posNW = scnView.scene!.rootNode.childNodeWithName("PossibleNW", recursively: true)
        let posSE = scnView.scene!.rootNode.childNodeWithName("PossibleSE", recursively: true)
        let posSW = scnView.scene!.rootNode.childNodeWithName("PossibleSW", recursively: true)
        yellow!.opacity = 0
        posN!.opacity = 0
        posS!.opacity = 0
        posE!.opacity = 0
        posW!.opacity = 0
        posNE!.opacity = 0
        posNW!.opacity = 0
        posSE!.opacity = 0
        posSW!.opacity = 0
        
        let menubutton = subScene.rootNode.childNodeWithName("Menu", recursively: true)
        let menuinverse = subScene.rootNode.childNodeWithName("menuinverse", recursively: true)
        let newGameButton = subScene.rootNode.childNodeWithName("newgame", recursively: true)
        let mainmenubutton = subScene.rootNode.childNodeWithName("mainmenubutton", recursively: true)
        menubutton!.position.x = -5.8; menubutton!.position.y = -56.5; menubutton!.position.z = 1
        menuinverse!.position.x = -5.6; menuinverse!.position.y = -56.3; menuinverse!.position.z = 0.8
        newGameButton!.position.x = -5.8; newGameButton!.position.y = -57.5; newGameButton!.position.z = 1
        mainmenubutton!.position.x = -5.8; mainmenubutton!.position.y = -57.5; mainmenubutton!.position.z = 1
        newGameButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        mainmenubutton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        scene.rootNode.addChildNode(menubutton!)
        scene.rootNode.addChildNode(menuinverse!)
        scene.rootNode.addChildNode(newGameButton!)
        scene.rootNode.addChildNode(mainmenubutton!)
    }
    
    func board2Scene() {
        multiPlayerRulesOn = false
        staticAI = false
        staticPlayer = false
        let scene = SCNScene(named: "art.scnassets/Board2Scene.dae")!
        let subScene = SCNScene(named: "art.scnassets/SubMenuScene.dae")!
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 12, y: -25.5, z: 54.5)
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 17, y: -34, z: 50)
        scene.rootNode.addChildNode(lightNode)
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = true
        scnView.showsStatistics = false
        scnView.backgroundColor = UIColor.blackColor()
        
        currentPlayer = "x"
        boardNumber = 2
        cols = 5
        rows = 9
        pSizeW = 7
        pSizeH = 7
        blueBeanActive = false
        redBeanActive = false
        aiStall = 0
        aiDirection = 0
        blueCaptured = 5
        redCaptured = 5
        cellWidth = Int(screenWidth/5)
        cellHeight = Int(screenHeight/9)
        for x in 0..<cols {
            boardArray.append(Array(count:rows, repeatedValue: .Empty))
            for y in 0..<rows {
                if x == 2 && y == 6 || x == 1 && y == 7 || x == 3 && y == 7 || x == 0 && y == 0 || x == 4 && y == 0 {
                    boardArray[x][y] = .BluePiece
                }
                else if x == 2 && y == 2 || x == 1 && y == 1 || x == 3 && y == 1 || x == 0 && y == 8 || x == 4 && y == 8 {
                    boardArray[x][y] = .RedPiece
                }
                else if x == 2 && y == 4 {
                    boardArray[x][y] = .Bean
                }
                else {
                    boardArray[x][y] = .Empty
                }
            }
        }
        
        let blue1 = scnView.scene!.rootNode.childNodeWithName("Blue01", recursively: true)
        let blue2 = scnView.scene!.rootNode.childNodeWithName("Blue02", recursively: true)
        let blue3 = scnView.scene!.rootNode.childNodeWithName("Blue03", recursively: true)
        let blue4 = scnView.scene!.rootNode.childNodeWithName("Blue04", recursively: true)
        let blue5 = scnView.scene!.rootNode.childNodeWithName("Blue05", recursively: true)
        let red1 = scnView.scene!.rootNode.childNodeWithName("Red01", recursively: true)
        let red2 = scnView.scene!.rootNode.childNodeWithName("Red02", recursively: true)
        let red3 = scnView.scene!.rootNode.childNodeWithName("Red03", recursively: true)
        let red4 = scnView.scene!.rootNode.childNodeWithName("Red04", recursively: true)
        let red5 = scnView.scene!.rootNode.childNodeWithName("Red05", recursively: true)
        blue1!.position.x = 14; blue1!.position.y = -42; blue1!.position.z = -1.5
        blue2!.position.x = 7; blue2!.position.y = -49; blue2!.position.z = -1.5
        blue3!.position.x = 21; blue3!.position.y = -49; blue3!.position.z = -1.5
        blue4!.position.x = 0; blue4!.position.y = 0; blue4!.position.z = -1.5
        blue5!.position.x = 28; blue5!.position.y = 0; blue5!.position.z = -1.5
        red1!.position.x = 14; red1!.position.y = -14; red1!.position.z = -1.5
        red2!.position.x = 7; red2!.position.y = -7; red2!.position.z = -1.5
        red3!.position.x = 21; red3!.position.y = -7; red3!.position.z = -1.5
        red4!.position.x = 0; red4!.position.y = -56; red4!.position.z = -1.5
        red5!.position.x = 28; red5!.position.y = -56; red5!.position.z = -1.5
        
        let blueHome = scnView.scene!.rootNode.childNodeWithName("BlueHome", recursively: true)
        let blueHomeEffect = scnView.scene!.rootNode.childNodeWithName("BlueHomeEffect", recursively: true)
        let redHome = scnView.scene!.rootNode.childNodeWithName("RedHome", recursively: true)
        let redHomeEffect = scnView.scene!.rootNode.childNodeWithName("RedHomeEffect", recursively: true)
        blueHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        redHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        blueHome!.opacity = 0.5
        redHome!.opacity = 0.5
        
        let yellow = scnView.scene!.rootNode.childNodeWithName("YellowFlare", recursively: true)
        let posN = scnView.scene!.rootNode.childNodeWithName("PossibleN", recursively: true)
        let posS = scnView.scene!.rootNode.childNodeWithName("PossibleS", recursively: true)
        let posE = scnView.scene!.rootNode.childNodeWithName("PossibleE", recursively: true)
        let posW = scnView.scene!.rootNode.childNodeWithName("PossibleW", recursively: true)
        let posNE = scnView.scene!.rootNode.childNodeWithName("PossibleNE", recursively: true)
        let posNW = scnView.scene!.rootNode.childNodeWithName("PossibleNW", recursively: true)
        let posSE = scnView.scene!.rootNode.childNodeWithName("PossibleSE", recursively: true)
        let posSW = scnView.scene!.rootNode.childNodeWithName("PossibleSW", recursively: true)
        yellow!.opacity = 0
        posN!.opacity = 0
        posS!.opacity = 0
        posE!.opacity = 0
        posW!.opacity = 0
        posNE!.opacity = 0
        posNW!.opacity = 0
        posSE!.opacity = 0
        posSW!.opacity = 0
        
        let menubutton = subScene.rootNode.childNodeWithName("Menu", recursively: true)
        let menuinverse = subScene.rootNode.childNodeWithName("menuinverse", recursively: true)
        let newGameButton = subScene.rootNode.childNodeWithName("newgame", recursively: true)
        let mainmenubutton = subScene.rootNode.childNodeWithName("mainmenubutton", recursively: true)
        menubutton!.position.x = -5.8; menubutton!.position.y = -56.5; menubutton!.position.z = 1
        menuinverse!.position.x = -5.6; menuinverse!.position.y = -56.3; menuinverse!.position.z = 0.8
        newGameButton!.position.x = -5.8; newGameButton!.position.y = -57.5; newGameButton!.position.z = 1
        mainmenubutton!.position.x = -5.8; mainmenubutton!.position.y = -57.5; mainmenubutton!.position.z = 1
        newGameButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        mainmenubutton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        scene.rootNode.addChildNode(menubutton!)
        scene.rootNode.addChildNode(menuinverse!)
        scene.rootNode.addChildNode(newGameButton!)
        scene.rootNode.addChildNode(mainmenubutton!)
    }
    
    func board3Scene() {
        multiPlayerRulesOn = false
        staticAI = false
        staticPlayer = false
        let scene = SCNScene(named: "art.scnassets/Board3Scene.dae")!
        let subScene = SCNScene(named: "art.scnassets/SubMenuScene.dae")!
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 12, y: -25.5, z: 54.5)
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 17, y: -34, z: 50)
        scene.rootNode.addChildNode(lightNode)
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = true
        scnView.showsStatistics = false
        scnView.backgroundColor = UIColor.blackColor()
        
        currentPlayer = "x"
        boardNumber = 3
        cols = 5
        rows = 9
        pSizeW = 7
        pSizeH = 7
        blueBeanActive = false
        redBeanActive = false
        aiStall = 0
        aiDirection = 0
        blueCaptured = 5
        redCaptured = 5
        cellWidth = Int(screenWidth/5)
        cellHeight = Int(screenHeight/9)
        for x in 0..<cols {
            boardArray.append(Array(count:rows, repeatedValue: .Empty))
            for y in 0..<rows {
                if x == 2 && y == 6 || x == 1 && y == 7 || x == 3 && y == 7 || x == 0 && y == 0 || x == 4 && y == 0 {
                    boardArray[x][y] = .BluePiece
                }
                else if x == 2 && y == 2 || x == 1 && y == 1 || x == 3 && y == 1 || x == 0 && y == 8 || x == 4 && y == 8 {
                    boardArray[x][y] = .RedPiece
                }
                else if x == 2 && y == 4 {
                    boardArray[x][y] = .Bean
                }
                else {
                    boardArray[x][y] = .Empty
                }
            }
        }
        
        let blue1 = scnView.scene!.rootNode.childNodeWithName("Blue01", recursively: true)
        let blue2 = scnView.scene!.rootNode.childNodeWithName("Blue02", recursively: true)
        let blue3 = scnView.scene!.rootNode.childNodeWithName("Blue03", recursively: true)
        let blue4 = scnView.scene!.rootNode.childNodeWithName("Blue04", recursively: true)
        let blue5 = scnView.scene!.rootNode.childNodeWithName("Blue05", recursively: true)
        let red1 = scnView.scene!.rootNode.childNodeWithName("Red01", recursively: true)
        let red2 = scnView.scene!.rootNode.childNodeWithName("Red02", recursively: true)
        let red3 = scnView.scene!.rootNode.childNodeWithName("Red03", recursively: true)
        let red4 = scnView.scene!.rootNode.childNodeWithName("Red04", recursively: true)
        let red5 = scnView.scene!.rootNode.childNodeWithName("Red05", recursively: true)
        blue1!.position.x = 14; blue1!.position.y = -42; blue1!.position.z = -1.5
        blue2!.position.x = 7; blue2!.position.y = -49; blue2!.position.z = -1.5
        blue3!.position.x = 21; blue3!.position.y = -49; blue3!.position.z = -1.5
        blue4!.position.x = 0; blue4!.position.y = 0; blue4!.position.z = -1.5
        blue5!.position.x = 28; blue5!.position.y = 0; blue5!.position.z = -1.5
        red1!.position.x = 14; red1!.position.y = -14; red1!.position.z = -1.5
        red2!.position.x = 7; red2!.position.y = -7; red2!.position.z = -1.5
        red3!.position.x = 21; red3!.position.y = -7; red3!.position.z = -1.5
        red4!.position.x = 0; red4!.position.y = -56; red4!.position.z = -1.5
        red5!.position.x = 28; red5!.position.y = -56; red5!.position.z = -1.5
        
        let blueHome = scnView.scene!.rootNode.childNodeWithName("BlueHome", recursively: true)
        let blueHomeEffect = scnView.scene!.rootNode.childNodeWithName("BlueHomeEffect", recursively: true)
        let redHome = scnView.scene!.rootNode.childNodeWithName("RedHome", recursively: true)
        let redHomeEffect = scnView.scene!.rootNode.childNodeWithName("RedHomeEffect", recursively: true)
        blueHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        redHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        blueHome!.opacity = 0.5
        redHome!.opacity = 0.5
        
        let yellow = scnView.scene!.rootNode.childNodeWithName("YellowFlare", recursively: true)
        let posN = scnView.scene!.rootNode.childNodeWithName("PossibleN", recursively: true)
        let posS = scnView.scene!.rootNode.childNodeWithName("PossibleS", recursively: true)
        let posE = scnView.scene!.rootNode.childNodeWithName("PossibleE", recursively: true)
        let posW = scnView.scene!.rootNode.childNodeWithName("PossibleW", recursively: true)
        let posNE = scnView.scene!.rootNode.childNodeWithName("PossibleNE", recursively: true)
        let posNW = scnView.scene!.rootNode.childNodeWithName("PossibleNW", recursively: true)
        let posSE = scnView.scene!.rootNode.childNodeWithName("PossibleSE", recursively: true)
        let posSW = scnView.scene!.rootNode.childNodeWithName("PossibleSW", recursively: true)
        yellow!.opacity = 0
        posN!.opacity = 0
        posS!.opacity = 0
        posE!.opacity = 0
        posW!.opacity = 0
        posNE!.opacity = 0
        posNW!.opacity = 0
        posSE!.opacity = 0
        posSW!.opacity = 0
        
        let menubutton = subScene.rootNode.childNodeWithName("Menu", recursively: true)
        let menuinverse = subScene.rootNode.childNodeWithName("menuinverse", recursively: true)
        let newGameButton = subScene.rootNode.childNodeWithName("newgame", recursively: true)
        let mainmenubutton = subScene.rootNode.childNodeWithName("mainmenubutton", recursively: true)
        menubutton!.position.x = -5.8; menubutton!.position.y = -56.5; menubutton!.position.z = 1
        menuinverse!.position.x = -5.6; menuinverse!.position.y = -56.3; menuinverse!.position.z = 0.8
        newGameButton!.position.x = -5.8; newGameButton!.position.y = -57.5; newGameButton!.position.z = 1
        mainmenubutton!.position.x = -5.8; mainmenubutton!.position.y = -57.5; mainmenubutton!.position.z = 1
        newGameButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        mainmenubutton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        scene.rootNode.addChildNode(menubutton!)
        scene.rootNode.addChildNode(menuinverse!)
        scene.rootNode.addChildNode(newGameButton!)
        scene.rootNode.addChildNode(mainmenubutton!)
    }
    
    func board4Scene() {
        multiPlayerRulesOn = false
        staticAI = false
        staticPlayer = false
        let scene = SCNScene(named: "art.scnassets/Board4Scene.dae")!
        let subScene = SCNScene(named: "art.scnassets/SubMenuScene.dae")!
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 12, y: -26.6, z: 56)
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 17, y: -34, z: 50)
        scene.rootNode.addChildNode(lightNode)
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = false
        scnView.showsStatistics = false
        scnView.backgroundColor = UIColor.blackColor()
        
        currentPlayer = "x"
        boardNumber = 4
        cols = 7
        rows = 13
        pSizeW = 5
        pSizeH = 5
        blueBeanActive = false
        redBeanActive = false
        aiStall = 0
        aiDirection = 0
        blueCaptured = 5
        redCaptured = 5
        cellWidth = Int(screenWidth/7)
        cellHeight = Int(screenHeight/13)
        boardChecker = 0
        
        for x in 0..<cols {
            boardArray.append(Array(count:rows, repeatedValue: .Empty))
            for y in 0..<rows {
                boardChecker += 1
                print("board4 boardArray count: \(boardChecker)")
                if x == 3 && y == 9 || x == 2 && y == 10 || x == 4 && y == 10 || x == 2 && y == 12 || x == 4 && y == 12 {
                    boardArray[x][y] = .BluePiece
                }
                else if x == 3 && y == 3 || x == 2 && y == 2 || x == 4 && y == 2 || x == 2 && y == 0 || x == 4 && y == 0 {
                    boardArray[x][y] = .RedPiece
                }
                else if x == 3 && y == 6 {
                    boardArray[x][y] = .Bean
                }
                else {
                    boardArray[x][y] = .Empty
                }
            }
        }
        
        let blue1 = scnView.scene!.rootNode.childNodeWithName("Blue01", recursively: true)
        let blue2 = scnView.scene!.rootNode.childNodeWithName("Blue02", recursively: true)
        let blue3 = scnView.scene!.rootNode.childNodeWithName("Blue03", recursively: true)
        let blue4 = scnView.scene!.rootNode.childNodeWithName("Blue04", recursively: true)
        let blue5 = scnView.scene!.rootNode.childNodeWithName("Blue05", recursively: true)
        let red1 = scnView.scene!.rootNode.childNodeWithName("Red01", recursively: true)
        let red2 = scnView.scene!.rootNode.childNodeWithName("Red02", recursively: true)
        let red3 = scnView.scene!.rootNode.childNodeWithName("Red03", recursively: true)
        let red4 = scnView.scene!.rootNode.childNodeWithName("Red04", recursively: true)
        let red5 = scnView.scene!.rootNode.childNodeWithName("Red05", recursively: true)
        blue1!.position.x = 15; blue1!.position.y = -45; blue1!.position.z = -1.5
        blue2!.position.x = 10; blue2!.position.y = -50; blue2!.position.z = -1.5
        blue3!.position.x = 20; blue3!.position.y = -50; blue3!.position.z = -1.5
        blue4!.position.x = 10; blue4!.position.y = -60; blue4!.position.z = -1.5
        blue5!.position.x = 20; blue5!.position.y = -60; blue5!.position.z = -1.5
        red1!.position.x = 15; red1!.position.y = -15; red1!.position.z = -1.5
        red2!.position.x = 10; red2!.position.y = -10; red2!.position.z = -1.5
        red3!.position.x = 20; red3!.position.y = -10; red3!.position.z = -1.5
        red4!.position.x = 10; red4!.position.y = 0; red4!.position.z = -1.5
        red5!.position.x = 20; red5!.position.y = 0; red5!.position.z = -1.5
        
        let blueHome = scnView.scene!.rootNode.childNodeWithName("BlueHome", recursively: true)
        let blueHomeEffect = scnView.scene!.rootNode.childNodeWithName("BlueHomeEffect", recursively: true)
        let redHome = scnView.scene!.rootNode.childNodeWithName("RedHome", recursively: true)
        let redHomeEffect = scnView.scene!.rootNode.childNodeWithName("RedHomeEffect", recursively: true)
        let yellow = scnView.scene!.rootNode.childNodeWithName("YellowFlare", recursively: true)
        let posN = scnView.scene!.rootNode.childNodeWithName("PossibleN", recursively: true)
        let posS = scnView.scene!.rootNode.childNodeWithName("PossibleS", recursively: true)
        let posE = scnView.scene!.rootNode.childNodeWithName("PossibleE", recursively: true)
        let posW = scnView.scene!.rootNode.childNodeWithName("PossibleW", recursively: true)
        let posNE = scnView.scene!.rootNode.childNodeWithName("PossibleNE", recursively: true)
        let posNW = scnView.scene!.rootNode.childNodeWithName("PossibleNW", recursively: true)
        let posSE = scnView.scene!.rootNode.childNodeWithName("PossibleSE", recursively: true)
        let posSW = scnView.scene!.rootNode.childNodeWithName("PossibleSW", recursively: true)
        blueHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        redHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        blueHome!.opacity = 0.4
        redHome!.opacity = 0.4
        yellow!.opacity = 0
        posN!.opacity = 0
        posS!.opacity = 0
        posE!.opacity = 0
        posW!.opacity = 0
        posNE!.opacity = 0
        posNW!.opacity = 0
        posSE!.opacity = 0
        posSW!.opacity = 0
        
        let menubutton = subScene.rootNode.childNodeWithName("Menu", recursively: true)
        let menuinverse = subScene.rootNode.childNodeWithName("menuinverse", recursively: true)
        let newGameButton = subScene.rootNode.childNodeWithName("newgame", recursively: true)
        let mainmenubutton = subScene.rootNode.childNodeWithName("mainmenubutton", recursively: true);
        menubutton!.position.x = -6; menubutton!.position.y = -58.5; menubutton!.position.z = 1
        menuinverse!.position.x = -6; menuinverse!.position.y = -58.5; menuinverse!.position.z = 0.8
        newGameButton!.position.x = -8; newGameButton!.position.y = -60; newGameButton!.position.z = 1
        mainmenubutton!.position.x = -8; mainmenubutton!.position.y = -60; mainmenubutton!.position.z = 1
        newGameButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        mainmenubutton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        scene.rootNode.addChildNode(menubutton!)
        scene.rootNode.addChildNode(menuinverse!)
        scene.rootNode.addChildNode(newGameButton!)
        scene.rootNode.addChildNode(mainmenubutton!)
    }
    
    func board5Scene() {
        multiPlayerRulesOn = false
        staticAI = false
        staticPlayer = false
        let scene = SCNScene(named: "art.scnassets/Board5Scene.dae")!
        let subScene = SCNScene(named: "art.scnassets/SubMenuScene.dae")!
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 12, y: -26.6, z: 56)
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 17, y: -34, z: 50)
        scene.rootNode.addChildNode(lightNode)
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = false
        scnView.showsStatistics = false
        scnView.backgroundColor = UIColor.blackColor()
        
        currentPlayer = "x"
        boardNumber = 5
        cols = 7
        rows = 13
        pSizeW = 5
        pSizeH = 5
        blueBeanActive = false
        redBeanActive = false
        aiStall = 0
        aiDirection = 0
        blueCaptured = 5
        redCaptured = 5
        cellWidth = Int(screenWidth/7)
        cellHeight = Int(screenHeight/13)
        boardChecker = 0
        
        for x in 0..<cols {
            boardArray.append(Array(count:rows, repeatedValue: .Empty))
            for y in 0..<rows {
                boardChecker += 1
                print("board4 boardArray count: \(boardChecker)")
                if x == 3 && y == 9 || x == 2 && y == 10 || x == 4 && y == 10 || x == 1 && y == 1 || x == 5 && y == 1 {
                    boardArray[x][y] = .BluePiece
                }
                else if x == 3 && y == 3 || x == 2 && y == 2 || x == 4 && y == 2 || x == 1 && y == 11 || x == 5 && y == 11 {
                    boardArray[x][y] = .RedPiece
                }
                else if x == 3 && y == 6 {
                    boardArray[x][y] = .Bean
                }
                else {
                    boardArray[x][y] = .Empty
                }
            }
        }
        
        let blue1 = scnView.scene!.rootNode.childNodeWithName("Blue01", recursively: true)
        let blue2 = scnView.scene!.rootNode.childNodeWithName("Blue02", recursively: true)
        let blue3 = scnView.scene!.rootNode.childNodeWithName("Blue03", recursively: true)
        let blue4 = scnView.scene!.rootNode.childNodeWithName("Blue04", recursively: true)
        let blue5 = scnView.scene!.rootNode.childNodeWithName("Blue05", recursively: true)
        let red1 = scnView.scene!.rootNode.childNodeWithName("Red01", recursively: true)
        let red2 = scnView.scene!.rootNode.childNodeWithName("Red02", recursively: true)
        let red3 = scnView.scene!.rootNode.childNodeWithName("Red03", recursively: true)
        let red4 = scnView.scene!.rootNode.childNodeWithName("Red04", recursively: true)
        let red5 = scnView.scene!.rootNode.childNodeWithName("Red05", recursively: true)
        blue1!.position.x = 15; blue1!.position.y = -45; blue1!.position.z = -1.5
        blue2!.position.x = 10; blue2!.position.y = -50; blue2!.position.z = -1.5
        blue3!.position.x = 20; blue3!.position.y = -50; blue3!.position.z = -1.5
        blue4!.position.x = 5; blue4!.position.y = -5; blue4!.position.z = -1.5
        blue5!.position.x = 25; blue5!.position.y = -5; blue5!.position.z = -1.5
        red1!.position.x = 15; red1!.position.y = -15; red1!.position.z = -1.5
        red2!.position.x = 10; red2!.position.y = -10; red2!.position.z = -1.5
        red3!.position.x = 20; red3!.position.y = -10; red3!.position.z = -1.5
        red4!.position.x = 5; red4!.position.y = -55; red4!.position.z = -1.5
        red5!.position.x = 25; red5!.position.y = -55; red5!.position.z = -1.5
        
        let blueHome = scnView.scene!.rootNode.childNodeWithName("BlueHome", recursively: true)
        let blueHomeEffect = scnView.scene!.rootNode.childNodeWithName("BlueHomeEffect", recursively: true)
        let redHome = scnView.scene!.rootNode.childNodeWithName("RedHome", recursively: true)
        let redHomeEffect = scnView.scene!.rootNode.childNodeWithName("RedHomeEffect", recursively: true)
        let yellow = scnView.scene!.rootNode.childNodeWithName("YellowFlare", recursively: true)
        let posN = scnView.scene!.rootNode.childNodeWithName("PossibleN", recursively: true)
        let posS = scnView.scene!.rootNode.childNodeWithName("PossibleS", recursively: true)
        let posE = scnView.scene!.rootNode.childNodeWithName("PossibleE", recursively: true)
        let posW = scnView.scene!.rootNode.childNodeWithName("PossibleW", recursively: true)
        let posNE = scnView.scene!.rootNode.childNodeWithName("PossibleNE", recursively: true)
        let posNW = scnView.scene!.rootNode.childNodeWithName("PossibleNW", recursively: true)
        let posSE = scnView.scene!.rootNode.childNodeWithName("PossibleSE", recursively: true)
        let posSW = scnView.scene!.rootNode.childNodeWithName("PossibleSW", recursively: true)
        blueHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        redHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        blueHome!.opacity = 0.4
        redHome!.opacity = 0.4
        yellow!.opacity = 0
        posN!.opacity = 0
        posS!.opacity = 0
        posE!.opacity = 0
        posW!.opacity = 0
        posNE!.opacity = 0
        posNW!.opacity = 0
        posSE!.opacity = 0
        posSW!.opacity = 0
        
        let menubutton = subScene.rootNode.childNodeWithName("Menu", recursively: true)
        let menuinverse = subScene.rootNode.childNodeWithName("menuinverse", recursively: true)
        let newGameButton = subScene.rootNode.childNodeWithName("newgame", recursively: true)
        let mainmenubutton = subScene.rootNode.childNodeWithName("mainmenubutton", recursively: true);
        menubutton!.position.x = -6; menubutton!.position.y = -58.5; menubutton!.position.z = 1
        menuinverse!.position.x = -6; menuinverse!.position.y = -58.5; menuinverse!.position.z = 0.8
        newGameButton!.position.x = -8; newGameButton!.position.y = -60; newGameButton!.position.z = 1
        mainmenubutton!.position.x = -8; mainmenubutton!.position.y = -60; mainmenubutton!.position.z = 1
        newGameButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        mainmenubutton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        scene.rootNode.addChildNode(menubutton!)
        scene.rootNode.addChildNode(menuinverse!)
        scene.rootNode.addChildNode(newGameButton!)
        scene.rootNode.addChildNode(mainmenubutton!)
    }
    
    func board6Scene() {
        multiPlayerRulesOn = false
        staticAI = false
        staticPlayer = false
        let scene = SCNScene(named: "art.scnassets/Board6Scene.dae")!
        let subScene = SCNScene(named: "art.scnassets/SubMenuScene.dae")!
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 12, y: -26.6, z: 56)
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 17, y: -34, z: 50)
        scene.rootNode.addChildNode(lightNode)
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = false
        scnView.showsStatistics = false
        scnView.backgroundColor = UIColor.blackColor()
        
        currentPlayer = "x"
        boardNumber = 6
        cols = 7
        rows = 13
        pSizeW = 5
        pSizeH = 5
        blueBeanActive = false
        redBeanActive = false
        aiStall = 0
        aiDirection = 0
        blueCaptured = 5
        redCaptured = 6
        cellWidth = Int(screenWidth/7)
        cellHeight = Int(screenHeight/13)
        boardChecker = 0
        
        for x in 0..<cols {
            boardArray.append(Array(count:rows, repeatedValue: .Empty))
            for y in 0..<rows {
                boardChecker += 1
                print("board4 boardArray count: \(boardChecker)")
                if x == 3 && y == 9 || x == 2 && y == 10 || x == 4 && y == 10 || x == 1 && y == 1 || x == 5 && y == 1 {
                    boardArray[x][y] = .BluePiece
                }
                else if x == 3 && y == 3 || x == 2 && y == 2 || x == 4 && y == 2 || x == 1 && y == 11 || x == 5 && y == 11 || x == 3 && y == 12 {
                    boardArray[x][y] = .RedPiece
                }
                else if x == 3 && y == 6 {
                    boardArray[x][y] = .Bean
                }
                else {
                    boardArray[x][y] = .Empty
                }
            }
        }
        
        let blue1 = scnView.scene!.rootNode.childNodeWithName("Blue01", recursively: true)
        let blue2 = scnView.scene!.rootNode.childNodeWithName("Blue02", recursively: true)
        let blue3 = scnView.scene!.rootNode.childNodeWithName("Blue03", recursively: true)
        let blue4 = scnView.scene!.rootNode.childNodeWithName("Blue04", recursively: true)
        let blue5 = scnView.scene!.rootNode.childNodeWithName("Blue05", recursively: true)
        let red1 = scnView.scene!.rootNode.childNodeWithName("Red01", recursively: true)
        let red2 = scnView.scene!.rootNode.childNodeWithName("Red02", recursively: true)
        let red3 = scnView.scene!.rootNode.childNodeWithName("Red03", recursively: true)
        let red4 = scnView.scene!.rootNode.childNodeWithName("Red04", recursively: true)
        let red5 = scnView.scene!.rootNode.childNodeWithName("Red05", recursively: true)
        let red6 = scnView.scene!.rootNode.childNodeWithName("Red06", recursively: true)
        blue1!.position.x = 15; blue1!.position.y = -45; blue1!.position.z = -1.5
        blue2!.position.x = 10; blue2!.position.y = -50; blue2!.position.z = -1.5
        blue3!.position.x = 20; blue3!.position.y = -50; blue3!.position.z = -1.5
        blue4!.position.x = 5; blue4!.position.y = -5; blue4!.position.z = -1.5
        blue5!.position.x = 25; blue5!.position.y = -5; blue5!.position.z = -1.5
        red1!.position.x = 15; red1!.position.y = -15; red1!.position.z = -1.5
        red2!.position.x = 10; red2!.position.y = -10; red2!.position.z = -1.5
        red3!.position.x = 20; red3!.position.y = -10; red3!.position.z = -1.5
        red4!.position.x = 5; red4!.position.y = -55; red4!.position.z = -1.5
        red5!.position.x = 25; red5!.position.y = -55; red5!.position.z = -1.5
        red6!.position.x = 15; red6!.position.y = -60; red6!.position.z = -1.5
        
        let blueHome = scnView.scene!.rootNode.childNodeWithName("BlueHome", recursively: true)
        let blueHomeEffect = scnView.scene!.rootNode.childNodeWithName("BlueHomeEffect", recursively: true)
        let redHome = scnView.scene!.rootNode.childNodeWithName("RedHome", recursively: true)
        let redHomeEffect = scnView.scene!.rootNode.childNodeWithName("RedHomeEffect", recursively: true)
        let yellow = scnView.scene!.rootNode.childNodeWithName("YellowFlare", recursively: true)
        let posN = scnView.scene!.rootNode.childNodeWithName("PossibleN", recursively: true)
        let posS = scnView.scene!.rootNode.childNodeWithName("PossibleS", recursively: true)
        let posE = scnView.scene!.rootNode.childNodeWithName("PossibleE", recursively: true)
        let posW = scnView.scene!.rootNode.childNodeWithName("PossibleW", recursively: true)
        let posNE = scnView.scene!.rootNode.childNodeWithName("PossibleNE", recursively: true)
        let posNW = scnView.scene!.rootNode.childNodeWithName("PossibleNW", recursively: true)
        let posSE = scnView.scene!.rootNode.childNodeWithName("PossibleSE", recursively: true)
        let posSW = scnView.scene!.rootNode.childNodeWithName("PossibleSW", recursively: true)
        blueHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        redHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        blueHome!.opacity = 0.4
        redHome!.opacity = 0.4
        yellow!.opacity = 0
        posN!.opacity = 0
        posS!.opacity = 0
        posE!.opacity = 0
        posW!.opacity = 0
        posNE!.opacity = 0
        posNW!.opacity = 0
        posSE!.opacity = 0
        posSW!.opacity = 0
        
        let menubutton = subScene.rootNode.childNodeWithName("Menu", recursively: true)
        let menuinverse = subScene.rootNode.childNodeWithName("menuinverse", recursively: true)
        let newGameButton = subScene.rootNode.childNodeWithName("newgame", recursively: true)
        let mainmenubutton = subScene.rootNode.childNodeWithName("mainmenubutton", recursively: true);
        menubutton!.position.x = -6; menubutton!.position.y = -58.5; menubutton!.position.z = 1
        menuinverse!.position.x = -6; menuinverse!.position.y = -58.5; menuinverse!.position.z = 0.8
        newGameButton!.position.x = -8; newGameButton!.position.y = -60; newGameButton!.position.z = 1
        mainmenubutton!.position.x = -8; mainmenubutton!.position.y = -60; mainmenubutton!.position.z = 1
        newGameButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        mainmenubutton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        scene.rootNode.addChildNode(menubutton!)
        scene.rootNode.addChildNode(menuinverse!)
        scene.rootNode.addChildNode(newGameButton!)
        scene.rootNode.addChildNode(mainmenubutton!)
    }
    
    func board7Scene() {
        multiPlayerRulesOn = false
        staticAI = false
        staticPlayer = false
        let scene = SCNScene(named: "art.scnassets/Board7Scene.dae")!
        let subScene = SCNScene(named: "art.scnassets/SubMenuScene.dae")!
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 12, y: -26.6, z: 56)
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 17, y: -34, z: 50)
        scene.rootNode.addChildNode(lightNode)
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = false
        scnView.showsStatistics = false
        scnView.backgroundColor = UIColor.blackColor()
        
        currentPlayer = "x"
        boardNumber = 7
        cols = 7
        rows = 13
        pSizeW = 5
        pSizeH = 5
        blueBeanActive = false
        redBeanActive = false
        aiStall = 0
        aiDirection = 0
        blueCaptured = 5
        redCaptured = 7
        cellWidth = Int(screenWidth/7)
        cellHeight = Int(screenHeight/13)
        boardChecker = 0
        
        for x in 0..<cols {
            boardArray.append(Array(count:rows, repeatedValue: .Empty))
            for y in 0..<rows {
                boardChecker += 1
                print("board4 boardArray count: \(boardChecker)")
                if x == 3 && y == 9 || x == 2 && y == 10 || x == 4 && y == 10 || x == 1 && y == 1 || x == 5 && y == 1 {
                    boardArray[x][y] = .BluePiece
                }
                else if x == 3 && y == 3 || x == 2 && y == 2 || x == 4 && y == 2 || x == 1 && y == 11 || x == 5 && y == 11 || x == 3 && y == 12 || x == 3 && y == 0 {
                    boardArray[x][y] = .RedPiece
                }
                else if x == 3 && y == 6 {
                    boardArray[x][y] = .Bean
                }
                else {
                    boardArray[x][y] = .Empty
                }
            }
        }
        
        let blue1 = scnView.scene!.rootNode.childNodeWithName("Blue01", recursively: true)
        let blue2 = scnView.scene!.rootNode.childNodeWithName("Blue02", recursively: true)
        let blue3 = scnView.scene!.rootNode.childNodeWithName("Blue03", recursively: true)
        let blue4 = scnView.scene!.rootNode.childNodeWithName("Blue04", recursively: true)
        let blue5 = scnView.scene!.rootNode.childNodeWithName("Blue05", recursively: true)
        let red1 = scnView.scene!.rootNode.childNodeWithName("Red01", recursively: true)
        let red2 = scnView.scene!.rootNode.childNodeWithName("Red02", recursively: true)
        let red3 = scnView.scene!.rootNode.childNodeWithName("Red03", recursively: true)
        let red4 = scnView.scene!.rootNode.childNodeWithName("Red04", recursively: true)
        let red5 = scnView.scene!.rootNode.childNodeWithName("Red05", recursively: true)
        let red6 = scnView.scene!.rootNode.childNodeWithName("Red06", recursively: true)
        let red7 = scnView.scene!.rootNode.childNodeWithName("Red06", recursively: true)
        blue1!.position.x = 15; blue1!.position.y = -45; blue1!.position.z = -1.5
        blue2!.position.x = 10; blue2!.position.y = -50; blue2!.position.z = -1.5
        blue3!.position.x = 20; blue3!.position.y = -50; blue3!.position.z = -1.5
        blue4!.position.x = 5; blue4!.position.y = -5; blue4!.position.z = -1.5
        blue5!.position.x = 25; blue5!.position.y = -5; blue5!.position.z = -1.5
        red1!.position.x = 15; red1!.position.y = -15; red1!.position.z = -1.5
        red2!.position.x = 10; red2!.position.y = -10; red2!.position.z = -1.5
        red3!.position.x = 20; red3!.position.y = -10; red3!.position.z = -1.5
        red4!.position.x = 5; red4!.position.y = -55; red4!.position.z = -1.5
        red5!.position.x = 25; red5!.position.y = -55; red5!.position.z = -1.5
        red6!.position.x = 15; red6!.position.y = -60; red6!.position.z = -1.5
        red7!.position.x = 15; red6!.position.y = 0; red6!.position.z = -1.5
        
        let blueHome = scnView.scene!.rootNode.childNodeWithName("BlueHome", recursively: true)
        let blueHomeEffect = scnView.scene!.rootNode.childNodeWithName("BlueHomeEffect", recursively: true)
        let redHome = scnView.scene!.rootNode.childNodeWithName("RedHome", recursively: true)
        let redHomeEffect = scnView.scene!.rootNode.childNodeWithName("RedHomeEffect", recursively: true)
        let yellow = scnView.scene!.rootNode.childNodeWithName("YellowFlare", recursively: true)
        let posN = scnView.scene!.rootNode.childNodeWithName("PossibleN", recursively: true)
        let posS = scnView.scene!.rootNode.childNodeWithName("PossibleS", recursively: true)
        let posE = scnView.scene!.rootNode.childNodeWithName("PossibleE", recursively: true)
        let posW = scnView.scene!.rootNode.childNodeWithName("PossibleW", recursively: true)
        let posNE = scnView.scene!.rootNode.childNodeWithName("PossibleNE", recursively: true)
        let posNW = scnView.scene!.rootNode.childNodeWithName("PossibleNW", recursively: true)
        let posSE = scnView.scene!.rootNode.childNodeWithName("PossibleSE", recursively: true)
        let posSW = scnView.scene!.rootNode.childNodeWithName("PossibleSW", recursively: true)
        blueHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        redHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        blueHome!.opacity = 0.4
        redHome!.opacity = 0.4
        yellow!.opacity = 0
        posN!.opacity = 0
        posS!.opacity = 0
        posE!.opacity = 0
        posW!.opacity = 0
        posNE!.opacity = 0
        posNW!.opacity = 0
        posSE!.opacity = 0
        posSW!.opacity = 0
        
        let menubutton = subScene.rootNode.childNodeWithName("Menu", recursively: true)
        let menuinverse = subScene.rootNode.childNodeWithName("menuinverse", recursively: true)
        let newGameButton = subScene.rootNode.childNodeWithName("newgame", recursively: true)
        let mainmenubutton = subScene.rootNode.childNodeWithName("mainmenubutton", recursively: true);
        menubutton!.position.x = -6; menubutton!.position.y = -58.5; menubutton!.position.z = 1
        menuinverse!.position.x = -6; menuinverse!.position.y = -58.5; menuinverse!.position.z = 0.8
        newGameButton!.position.x = -8; newGameButton!.position.y = -60; newGameButton!.position.z = 1
        mainmenubutton!.position.x = -8; mainmenubutton!.position.y = -60; mainmenubutton!.position.z = 1
        newGameButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        mainmenubutton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        scene.rootNode.addChildNode(menubutton!)
        scene.rootNode.addChildNode(menuinverse!)
        scene.rootNode.addChildNode(newGameButton!)
        scene.rootNode.addChildNode(mainmenubutton!)
    }
    
    func board8Scene() {
        multiPlayerRulesOn = false
        staticAI = false
        staticPlayer = false
        let scene = SCNScene(named: "art.scnassets/Board8Scene.dae")!
        let subScene = SCNScene(named: "art.scnassets/SubMenuScene.dae")!
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 12, y: -27.5, z: 55)
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 17, y: -34, z: 50)
        scene.rootNode.addChildNode(lightNode)
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = true
        scnView.showsStatistics = false
        scnView.backgroundColor = UIColor.blackColor()
        
        currentPlayer = "x"
        boardNumber = 8
        cols = 9
        rows = 16
        pSizeW = 4
        pSizeH = 4
        blueBeanActive = false
        redBeanActive = false
        aiStall = 0
        aiDirection = 0
        blueCaptured = 5
        redCaptured = 5
        cellWidth = Int(screenWidth/9)
        cellHeight = Int(screenHeight/16)
        for x in 0..<cols {
            boardArray.append(Array(count:rows, repeatedValue: .Empty))
            for y in 0..<rows {
                if x == 4 && y == 10 || x == 3 && y == 11 || x == 5 && y == 11 || x == 2 && y == 2 || x == 6 && y == 2 {
                    boardArray[x][y] = .BluePiece
                }
                else if x == 4 && y == 4 || x == 3 && y == 3 || x == 5 && y == 3 || x == 2 && y == 12 || x == 6 && y == 12 {
                    boardArray[x][y] = .RedPiece
                }
                else if x == 4 && y == 7 { boardArray[x][y] = .Bean
                }
                else { boardArray[x][y] = .Empty
                }
            }
        }
        
        let blue1 = scnView.scene!.rootNode.childNodeWithName("Blue01", recursively: true)
        let blue2 = scnView.scene!.rootNode.childNodeWithName("Blue02", recursively: true)
        let blue3 = scnView.scene!.rootNode.childNodeWithName("Blue03", recursively: true)
        let blue4 = scnView.scene!.rootNode.childNodeWithName("Blue04", recursively: true)
        let blue5 = scnView.scene!.rootNode.childNodeWithName("Blue05", recursively: true)
        let red1 = scnView.scene!.rootNode.childNodeWithName("Red01", recursively: true)
        let red2 = scnView.scene!.rootNode.childNodeWithName("Red02", recursively: true)
        let red3 = scnView.scene!.rootNode.childNodeWithName("Red03", recursively: true)
        let red4 = scnView.scene!.rootNode.childNodeWithName("Red04", recursively: true)
        let red5 = scnView.scene!.rootNode.childNodeWithName("Red05", recursively: true)
        blue1!.position.x = 16; blue1!.position.y = -40; blue1!.position.z = -1.5
        blue2!.position.x = 12; blue2!.position.y = -44; blue2!.position.z = -1.5
        blue3!.position.x = 20; blue3!.position.y = -44; blue3!.position.z = -1.5
        blue4!.position.x = 8; blue4!.position.y = -8; blue4!.position.z = -1.5
        blue5!.position.x = 24; blue5!.position.y = -8; blue5!.position.z = -1.5
        red1!.position.x = 16; red1!.position.y = -16; red1!.position.z = -1.5
        red2!.position.x = 12; red2!.position.y = -12; red2!.position.z = -1.5
        red3!.position.x = 20; red3!.position.y = -12; red3!.position.z = -1.5
        red4!.position.x = 8; red4!.position.y = -48; red4!.position.z = -1.5
        red5!.position.x = 24; red5!.position.y = -48; red5!.position.z = -1.5
        
        let blueHome = scnView.scene!.rootNode.childNodeWithName("BlueHome", recursively: true)
        let blueHomeEffect = scnView.scene!.rootNode.childNodeWithName("BlueHomeEffect", recursively: true)
        let redHome = scnView.scene!.rootNode.childNodeWithName("RedHome", recursively: true)
        let redHomeEffect = scnView.scene!.rootNode.childNodeWithName("RedHomeEffect", recursively: true)
        blueHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        redHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        blueHome!.opacity = 0.6
        redHome!.opacity = 0.6
        
        let yellow = scnView.scene!.rootNode.childNodeWithName("YellowFlare", recursively: true)
        let posN = scnView.scene!.rootNode.childNodeWithName("PossibleN", recursively: true)
        let posS = scnView.scene!.rootNode.childNodeWithName("PossibleS", recursively: true)
        let posE = scnView.scene!.rootNode.childNodeWithName("PossibleE", recursively: true)
        let posW = scnView.scene!.rootNode.childNodeWithName("PossibleW", recursively: true)
        let posNE = scnView.scene!.rootNode.childNodeWithName("PossibleNE", recursively: true)
        let posNW = scnView.scene!.rootNode.childNodeWithName("PossibleNW", recursively: true)
        let posSE = scnView.scene!.rootNode.childNodeWithName("PossibleSE", recursively: true)
        let posSW = scnView.scene!.rootNode.childNodeWithName("PossibleSW", recursively: true)
        yellow!.opacity = 0
        posN!.opacity = 0
        posS!.opacity = 0
        posE!.opacity = 0
        posW!.opacity = 0
        posNE!.opacity = 0
        posNW!.opacity = 0
        posSE!.opacity = 0
        posSW!.opacity = 0
        
        let menubutton = subScene.rootNode.childNodeWithName("Menu", recursively: true)
        let menuinverse = subScene.rootNode.childNodeWithName("menuinverse", recursively: true)
        let newGameButton = subScene.rootNode.childNodeWithName("newgame", recursively: true)
        let mainmenubutton = subScene.rootNode.childNodeWithName("mainmenubutton", recursively: true);
        menubutton!.position.x = -5.8; menubutton!.position.y = -59; menubutton!.position.z = 1
        menuinverse!.position.x = -5.6; menuinverse!.position.y = -58.7; menuinverse!.position.z = 0.8
        newGameButton!.position.x = -5.8; newGameButton!.position.y = -59.5; newGameButton!.position.z = 1.2
        mainmenubutton!.position.x = -5.8; mainmenubutton!.position.y = -59.5; mainmenubutton!.position.z = 1.2
        newGameButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        mainmenubutton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        scene.rootNode.addChildNode(menubutton!)
        scene.rootNode.addChildNode(menuinverse!)
        scene.rootNode.addChildNode(newGameButton!)
        scene.rootNode.addChildNode(mainmenubutton!)
    }
    
    func board9Scene() {
        multiPlayerRulesOn = false
        staticAI = false
        staticPlayer = false
        let scene = SCNScene(named: "art.scnassets/Board9Scene.dae")!
        let subScene = SCNScene(named: "art.scnassets/SubMenuScene.dae")!
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 12, y: -27.5, z: 55)
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 17, y: -34, z: 50)
        scene.rootNode.addChildNode(lightNode)
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = true
        scnView.showsStatistics = false
        scnView.backgroundColor = UIColor.blackColor()
        
        currentPlayer = "x"
        boardNumber = 9
        cols = 9
        rows = 16
        pSizeW = 4
        pSizeH = 4
        blueBeanActive = false
        redBeanActive = false
        aiStall = 0
        aiDirection = 0
        blueCaptured = 3
        redCaptured = 5
        cellWidth = Int(screenWidth/9)
        cellHeight = Int(screenHeight/16)
        for x in 0..<cols {
            boardArray.append(Array(count:rows, repeatedValue: .Empty))
            for y in 0..<rows {
                if x == 4 && y == 10 || x == 3 && y == 11 || x == 5 && y == 11 {
                    boardArray[x][y] = .BluePiece
                }
                else if x == 4 && y == 4 || x == 3 && y == 3 || x == 5 && y == 3 || x == 2 && y == 12 || x == 6 && y == 12 {
                    boardArray[x][y] = .RedPiece
                }
                else if x == 4 && y == 7 {
                    boardArray[x][y] = .Bean
                }
                else {
                    boardArray[x][y] = .Empty
                }
            }
        }
        
        let blue1 = scnView.scene!.rootNode.childNodeWithName("Blue01", recursively: true)
        let blue2 = scnView.scene!.rootNode.childNodeWithName("Blue02", recursively: true)
        let blue3 = scnView.scene!.rootNode.childNodeWithName("Blue03", recursively: true)
        let red1 = scnView.scene!.rootNode.childNodeWithName("Red01", recursively: true)
        let red2 = scnView.scene!.rootNode.childNodeWithName("Red02", recursively: true)
        let red3 = scnView.scene!.rootNode.childNodeWithName("Red03", recursively: true)
        let red4 = scnView.scene!.rootNode.childNodeWithName("Red04", recursively: true)
        let red5 = scnView.scene!.rootNode.childNodeWithName("Red05", recursively: true)
        blue1!.position.x = 16; blue1!.position.y = -40; blue1!.position.z = -1.5
        blue2!.position.x = 12; blue2!.position.y = -44; blue2!.position.z = -1.5
        blue3!.position.x = 20; blue3!.position.y = -44; blue3!.position.z = -1.5
        red1!.position.x = 16; red1!.position.y = -16; red1!.position.z = -1.5
        red2!.position.x = 12; red2!.position.y = -12; red2!.position.z = -1.5
        red3!.position.x = 20; red3!.position.y = -12; red3!.position.z = -1.5
        red4!.position.x = 8; red4!.position.y = -48; red4!.position.z = -1.5
        red5!.position.x = 24; red5!.position.y = -48; red5!.position.z = -1.5
        
        let blueHome = scnView.scene!.rootNode.childNodeWithName("BlueHome", recursively: true)
        let blueHomeEffect = scnView.scene!.rootNode.childNodeWithName("BlueHomeEffect", recursively: true)
        let redHome = scnView.scene!.rootNode.childNodeWithName("RedHome", recursively: true)
        let redHomeEffect = scnView.scene!.rootNode.childNodeWithName("RedHomeEffect", recursively: true)
        blueHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        redHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        blueHome!.opacity = 0.6
        redHome!.opacity = 0.6
        
        let yellow = scnView.scene!.rootNode.childNodeWithName("YellowFlare", recursively: true)
        let posN = scnView.scene!.rootNode.childNodeWithName("PossibleN", recursively: true)
        let posS = scnView.scene!.rootNode.childNodeWithName("PossibleS", recursively: true)
        let posE = scnView.scene!.rootNode.childNodeWithName("PossibleE", recursively: true)
        let posW = scnView.scene!.rootNode.childNodeWithName("PossibleW", recursively: true)
        let posNE = scnView.scene!.rootNode.childNodeWithName("PossibleNE", recursively: true)
        let posNW = scnView.scene!.rootNode.childNodeWithName("PossibleNW", recursively: true)
        let posSE = scnView.scene!.rootNode.childNodeWithName("PossibleSE", recursively: true)
        let posSW = scnView.scene!.rootNode.childNodeWithName("PossibleSW", recursively: true)
        yellow!.opacity = 0
        posN!.opacity = 0
        posS!.opacity = 0
        posE!.opacity = 0
        posW!.opacity = 0
        posNE!.opacity = 0
        posNW!.opacity = 0
        posSE!.opacity = 0
        posSW!.opacity = 0
        
        let menubutton = subScene.rootNode.childNodeWithName("Menu", recursively: true)
        let menuinverse = subScene.rootNode.childNodeWithName("menuinverse", recursively: true)
        let newGameButton = subScene.rootNode.childNodeWithName("newgame", recursively: true)
        let mainmenubutton = subScene.rootNode.childNodeWithName("mainmenubutton", recursively: true);
        menubutton!.position.x = -5.8; menubutton!.position.y = -59; menubutton!.position.z = 1
        menuinverse!.position.x = -5.6; menuinverse!.position.y = -58.7; menuinverse!.position.z = 0.8
        newGameButton!.position.x = -5.8; newGameButton!.position.y = -59.5; newGameButton!.position.z = 1.2
        mainmenubutton!.position.x = -5.8; mainmenubutton!.position.y = -59.5; mainmenubutton!.position.z = 1.2
        newGameButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        mainmenubutton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        scene.rootNode.addChildNode(menubutton!)
        scene.rootNode.addChildNode(menuinverse!)
        scene.rootNode.addChildNode(newGameButton!)
        scene.rootNode.addChildNode(mainmenubutton!)
    }
    
    func board10Scene() {
        multiPlayerRulesOn = false
        staticAI = false
        staticPlayer = false
        let scene = SCNScene(named: "art.scnassets/Board10Scene.dae")!
        let subScene = SCNScene(named: "art.scnassets/SubMenuScene.dae")!
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 12, y: -27.5, z: 55)
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 17, y: -34, z: 50)
        scene.rootNode.addChildNode(lightNode)
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = true
        scnView.showsStatistics = false
        scnView.backgroundColor = UIColor.blackColor()
        
        currentPlayer = "x"
        boardNumber = 10
        cols = 9
        rows = 16
        pSizeW = 4
        pSizeH = 4
        blueBeanActive = false
        redBeanActive = false
        aiStall = 0
        aiDirection = 0
        blueCaptured = 3
        redCaptured = 7
        cellWidth = Int(screenWidth/9)
        cellHeight = Int(screenHeight/16)
        for x in 0..<cols {
            boardArray.append(Array(count:rows, repeatedValue: .Empty))
            for y in 0..<rows {
                if x == 4 && y == 10 || x == 3 && y == 11 || x == 5 && y == 11 {
                    boardArray[x][y] = .BluePiece
                }
                else if x == 4 && y == 4 || x == 3 && y == 3 || x == 5 && y == 3 || x == 2 && y == 12 || x == 6 && y == 12 || x == 2 && y == 2 || x == 6 && y == 2 {
                    boardArray[x][y] = .RedPiece
                }
                else if x == 4 && y == 7 { boardArray[x][y] = .Bean }
                else {
                    boardArray[x][y] = .Empty
                }
            }
        }
        
        let blue1 = scnView.scene!.rootNode.childNodeWithName("Blue01", recursively: true)
        let blue2 = scnView.scene!.rootNode.childNodeWithName("Blue02", recursively: true)
        let blue3 = scnView.scene!.rootNode.childNodeWithName("Blue03", recursively: true)
        let red1 = scnView.scene!.rootNode.childNodeWithName("Red01", recursively: true)
        let red2 = scnView.scene!.rootNode.childNodeWithName("Red02", recursively: true)
        let red3 = scnView.scene!.rootNode.childNodeWithName("Red03", recursively: true)
        let red4 = scnView.scene!.rootNode.childNodeWithName("Red04", recursively: true)
        let red5 = scnView.scene!.rootNode.childNodeWithName("Red05", recursively: true)
        let red6 = scnView.scene!.rootNode.childNodeWithName("Red06", recursively: true)
        let red7 = scnView.scene!.rootNode.childNodeWithName("Red07", recursively: true)
        blue1!.position.x = 16; blue1!.position.y = -40; blue1!.position.z = -1.5
        blue2!.position.x = 12; blue2!.position.y = -44; blue2!.position.z = -1.5
        blue3!.position.x = 20; blue3!.position.y = -44; blue3!.position.z = -1.5
        red1!.position.x = 16; red1!.position.y = -16; red1!.position.z = -1.5
        red2!.position.x = 12; red2!.position.y = -12; red2!.position.z = -1.5
        red3!.position.x = 20; red3!.position.y = -12; red3!.position.z = -1.5
        red4!.position.x = 8; red4!.position.y = -48; red4!.position.z = -1.5
        red5!.position.x = 24; red5!.position.y = -48; red5!.position.z = -1.5
        red6!.position.x = 8; red6!.position.y = -8; red6!.position.z = -1.5
        red7!.position.x = 24; red7!.position.y = -8; red7!.position.z = -1.5
        
        let blueHome = scnView.scene!.rootNode.childNodeWithName("BlueHome", recursively: true)
        let blueHomeEffect = scnView.scene!.rootNode.childNodeWithName("BlueHomeEffect", recursively: true)
        let redHome = scnView.scene!.rootNode.childNodeWithName("RedHome", recursively: true)
        let redHomeEffect = scnView.scene!.rootNode.childNodeWithName("RedHomeEffect", recursively: true)
        blueHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        redHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        blueHome!.opacity = 0.6
        redHome!.opacity = 0.6
        
        let yellow = scnView.scene!.rootNode.childNodeWithName("YellowFlare", recursively: true)
        let posN = scnView.scene!.rootNode.childNodeWithName("PossibleN", recursively: true)
        let posS = scnView.scene!.rootNode.childNodeWithName("PossibleS", recursively: true)
        let posE = scnView.scene!.rootNode.childNodeWithName("PossibleE", recursively: true)
        let posW = scnView.scene!.rootNode.childNodeWithName("PossibleW", recursively: true)
        let posNE = scnView.scene!.rootNode.childNodeWithName("PossibleNE", recursively: true)
        let posNW = scnView.scene!.rootNode.childNodeWithName("PossibleNW", recursively: true)
        let posSE = scnView.scene!.rootNode.childNodeWithName("PossibleSE", recursively: true)
        let posSW = scnView.scene!.rootNode.childNodeWithName("PossibleSW", recursively: true)
        yellow!.opacity = 0
        posN!.opacity = 0
        posS!.opacity = 0
        posE!.opacity = 0
        posW!.opacity = 0
        posNE!.opacity = 0
        posNW!.opacity = 0
        posSE!.opacity = 0
        posSW!.opacity = 0
        
        let menubutton = subScene.rootNode.childNodeWithName("Menu", recursively: true)
        let menuinverse = subScene.rootNode.childNodeWithName("menuinverse", recursively: true)
        let newGameButton = subScene.rootNode.childNodeWithName("newgame", recursively: true)
        let mainmenubutton = subScene.rootNode.childNodeWithName("mainmenubutton", recursively: true);
        menubutton!.position.x = -5.8; menubutton!.position.y = -59; menubutton!.position.z = 1
        menuinverse!.position.x = -5.6; menuinverse!.position.y = -58.7; menuinverse!.position.z = 0.8
        newGameButton!.position.x = -5.8; newGameButton!.position.y = -59.5; newGameButton!.position.z = 1.2
        mainmenubutton!.position.x = -5.8; mainmenubutton!.position.y = -59.5; mainmenubutton!.position.z = 1.2
        newGameButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        mainmenubutton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        scene.rootNode.addChildNode(menubutton!)
        scene.rootNode.addChildNode(menuinverse!)
        scene.rootNode.addChildNode(newGameButton!)
        scene.rootNode.addChildNode(mainmenubutton!)
    }
    
/////////////////////////////
//   MULTI PLAYER SCENES  //
/////////////////////////////
    
    func boardMultiPlayer1Scene() {
        let scene = SCNScene(named: "art.scnassets/BoardMultiPlayer1Scene.dae")!
        let subScene = SCNScene(named: "art.scnassets/SubMenuScene.dae")!
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 12, y: -25.5, z: 54.5)
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 17, y: -34, z: 50)
        scene.rootNode.addChildNode(lightNode)
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = false
        scnView.showsStatistics = false
        scnView.backgroundColor = UIColor.blackColor()
        
        winLoseMarker = "gameOn"
        multiPlayerRulesOn = true
        staticPlayer = false
        currentPlayer = "x"
        multiNumber = 1
        cols = 5
        rows = 9
        pSizeW = 7
        pSizeH = 7
        blueBeanActive = false
        redBeanActive = false
        aiStall = 0
        aiDirection = 0
        blueCaptured = 3
        redCaptured = 3
        cellWidth = Int(screenWidth/5)
        cellHeight = Int(screenHeight/9)
        for x in 0..<cols {
            boardArray.append(Array(count:rows, repeatedValue: .Empty))
            for y in 0..<rows {
                if x == 2 && y == 6 || x == 1 && y == 7 || x == 3 && y == 7 {  boardArray[x][y] = .BluePiece }
                else if x == 1 && y == 1 || x == 2 && y == 2 || x == 3 && y == 1 { boardArray[x][y] = .RedPiece }
                else if x == 2 && y == 4 { boardArray[x][y] = .Bean }
                else { boardArray[x][y] = .Empty }
            }
        }
        
        let blue1 = scnView.scene!.rootNode.childNodeWithName("Blue01", recursively: true)
        let blue2 = scnView.scene!.rootNode.childNodeWithName("Blue02", recursively: true)
        let blue3 = scnView.scene!.rootNode.childNodeWithName("Blue03", recursively: true)
        let red1 = scnView.scene!.rootNode.childNodeWithName("Red01", recursively: true)
        let red2 = scnView.scene!.rootNode.childNodeWithName("Red02", recursively: true)
        let red3 = scnView.scene!.rootNode.childNodeWithName("Red03", recursively: true)
        let newBean = scnView.scene!.rootNode.childNodeWithName("NewBean", recursively: true)
        blue1!.position.x = 14; blue1!.position.y = -42; blue1!.position.z = -1.5
        blue2!.position.x = 7; blue2!.position.y = -49; blue2!.position.z = -1.5
        blue3!.position.x = 21; blue3!.position.y = -49; blue3!.position.z = -1.5
        red1!.position.x = 14; red1!.position.y = -14; red1!.position.z = -1.5
        red2!.position.x = 7; red2!.position.y = -7; red2!.position.z = -1.5
        red3!.position.x = 21; red3!.position.y = -7; red3!.position.z = -1.5
        newBean!.position.x = 14; newBean!.position.y = -28; newBean!.position.z = -1.5
        
        let blueHome = scnView.scene!.rootNode.childNodeWithName("BlueHome", recursively: true)
        let blueHomeEffect = scnView.scene!.rootNode.childNodeWithName("BlueHomeEffect", recursively: true)
        let redHome = scnView.scene!.rootNode.childNodeWithName("RedHome", recursively: true)
        let redHomeEffect = scnView.scene!.rootNode.childNodeWithName("RedHomeEffect", recursively: true)
        let yellow = scnView.scene!.rootNode.childNodeWithName("YellowFlare", recursively: true)
        let posN = scnView.scene!.rootNode.childNodeWithName("PossibleN", recursively: true)
        let posS = scnView.scene!.rootNode.childNodeWithName("PossibleS", recursively: true)
        let posE = scnView.scene!.rootNode.childNodeWithName("PossibleE", recursively: true)
        let posW = scnView.scene!.rootNode.childNodeWithName("PossibleW", recursively: true)
        let posNE = scnView.scene!.rootNode.childNodeWithName("PossibleNE", recursively: true)
        let posNW = scnView.scene!.rootNode.childNodeWithName("PossibleNW", recursively: true)
        let posSE = scnView.scene!.rootNode.childNodeWithName("PossibleSE", recursively: true)
        let posSW = scnView.scene!.rootNode.childNodeWithName("PossibleSW", recursively: true)
        blueHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        redHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        blueHome!.opacity = 0.5
        redHome!.opacity = 0.5
        yellow!.opacity = 0
        posN!.opacity = 0
        posS!.opacity = 0
        posE!.opacity = 0
        posW!.opacity = 0
        posNE!.opacity = 0
        posNW!.opacity = 0
        posSE!.opacity = 0
        posSW!.opacity = 0
        
        let menubutton = subScene.rootNode.childNodeWithName("Menu", recursively: true)
        let menuinverse = subScene.rootNode.childNodeWithName("menuinverse", recursively: true)
        let howtomultiButton = subScene.rootNode.childNodeWithName("howtomulti", recursively: true)
        let connectButton = subScene.rootNode.childNodeWithName("connect", recursively: true)
        let newGameButton = subScene.rootNode.childNodeWithName("newgame", recursively: true)
        let mainmenubutton = subScene.rootNode.childNodeWithName("mainmenubutton", recursively: true)
        let dirmulti = subScene.rootNode.childNodeWithName("dirmulti", recursively: true)
        let multiboard1 = subScene.rootNode.childNodeWithName("multiboard1", recursively: true)
        let multiboard2 = subScene.rootNode.childNodeWithName("multiboard2", recursively: true)
        let multiboard3 = subScene.rootNode.childNodeWithName("multiboard3", recursively: true)
        let multiboard4 = subScene.rootNode.childNodeWithName("multiboard4", recursively: true)
        menubutton!.position.x = -5.8; menubutton!.position.y = -56.4; menubutton!.position.z = 1
        menuinverse!.position.x = -5.6; menuinverse!.position.y = -56.1; menuinverse!.position.z = 0.8
        howtomultiButton!.position.x = -5.8; howtomultiButton!.position.y = -57.5; howtomultiButton!.position.z = 1
        connectButton!.position.x = -5.8; connectButton!.position.y = -57.5; connectButton!.position.z = 1
        newGameButton!.position.x = -5.8; newGameButton!.position.y = -57.5; newGameButton!.position.z = 1
        mainmenubutton!.position.x = -5.8; mainmenubutton!.position.y = -57.5; mainmenubutton!.position.z = 1
        dirmulti!.position.x = -5.8; dirmulti!.position.y = -56.4; dirmulti!.position.z = 1
        multiboard1!.position.x = -3.65; multiboard1!.position.y = -54; multiboard1!.position.z = 1
        multiboard1!.position.x = -3.65; multiboard1!.position.y = -54; multiboard1!.position.z = 1
        multiboard2!.position.x = -3.65; multiboard2!.position.y = -54; multiboard2!.position.z = 1
        multiboard3!.position.x = -3.65; multiboard3!.position.y = -54; multiboard3!.position.z = 1
        multiboard4!.position.x = -3.65; multiboard4!.position.y = -54; multiboard4!.position.z = 1
        howtomultiButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        connectButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        newGameButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        mainmenubutton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        multiboard1!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        multiboard2!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        multiboard3!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        multiboard4!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        dirmulti!.opacity = 0
        scene.rootNode.addChildNode(menubutton!)
        scene.rootNode.addChildNode(menuinverse!)
        scene.rootNode.addChildNode(howtomultiButton!)
        scene.rootNode.addChildNode(connectButton!)
        scene.rootNode.addChildNode(newGameButton!)
        scene.rootNode.addChildNode(mainmenubutton!)
        scene.rootNode.addChildNode(dirmulti!)
        scene.rootNode.addChildNode(multiboard1!)
        scene.rootNode.addChildNode(multiboard2!)
        scene.rootNode.addChildNode(multiboard3!)
        scene.rootNode.addChildNode(multiboard4!)
    }
    
    func boardMultiPlayer2Scene() {
        let scene = SCNScene(named: "art.scnassets/BoardMultiPlayer2Scene.dae")!
        let subScene = SCNScene(named: "art.scnassets/SubMenuScene.dae")!
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 12, y: -26.6, z: 56)
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 17, y: -34, z: 50)
        scene.rootNode.addChildNode(lightNode)
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = false
        scnView.showsStatistics = false
        scnView.backgroundColor = UIColor.blackColor()
        
        winLoseMarker = "gameOn"
        multiPlayerRulesOn = true
        staticPlayer = false
        currentPlayer = "x"
        multiNumber = 2
        cols = 7
        rows = 13
        pSizeW = 5
        pSizeH = 5
        blueBeanActive = false
        redBeanActive = false
        aiStall = 0
        aiDirection = 0
        blueCaptured = 5
        redCaptured = 5
        cellWidth = Int(screenWidth/7)
        cellHeight = Int(screenHeight/13)
        for x in 0..<cols {
            boardArray.append(Array(count:rows, repeatedValue: .Empty))
            for y in 0..<rows {
                if x == 3 && y == 9 || x == 2 && y == 10 || x == 4 && y == 10 || x == 1 && y == 1 || x == 5 && y == 1 {  boardArray[x][y] = .BluePiece }
                else if x == 3 && y == 3 || x == 2 && y == 2 || x == 4 && y == 2 || x == 1 && y == 11 || x == 5 && y == 11 { boardArray[x][y] = .RedPiece }
                else if x == 3 && y == 6 { boardArray[x][y] = .Bean }
                else { boardArray[x][y] = .Empty }
            }
        }
        
        let blue1 = scnView.scene!.rootNode.childNodeWithName("Blue01", recursively: true)
        let blue2 = scnView.scene!.rootNode.childNodeWithName("Blue02", recursively: true)
        let blue3 = scnView.scene!.rootNode.childNodeWithName("Blue03", recursively: true)
        let blue4 = scnView.scene!.rootNode.childNodeWithName("Blue04", recursively: true)
        let blue5 = scnView.scene!.rootNode.childNodeWithName("Blue05", recursively: true)
        let red1 = scnView.scene!.rootNode.childNodeWithName("Red01", recursively: true)
        let red2 = scnView.scene!.rootNode.childNodeWithName("Red02", recursively: true)
        let red3 = scnView.scene!.rootNode.childNodeWithName("Red03", recursively: true)
        let red4 = scnView.scene!.rootNode.childNodeWithName("Red04", recursively: true)
        let red5 = scnView.scene!.rootNode.childNodeWithName("Red05", recursively: true)
        let newBean = scnView.scene!.rootNode.childNodeWithName("NewBean", recursively: true)
        blue1!.position.x = 15; blue1!.position.y = -45; blue1!.position.z = -1.5
        blue2!.position.x = 10; blue2!.position.y = -50; blue2!.position.z = -1.5
        blue3!.position.x = 20; blue3!.position.y = -50; blue3!.position.z = -1.5
        blue4!.position.x = 5; blue4!.position.y = -5; blue4!.position.z = -1.5
        blue5!.position.x = 25; blue5!.position.y = -5; blue5!.position.z = -1.5
        red1!.position.x = 15; red1!.position.y = -15; red1!.position.z = -1.5
        red2!.position.x = 10; red2!.position.y = -10; red2!.position.z = -1.5
        red3!.position.x = 20; red3!.position.y = -10; red3!.position.z = -1.5
        red4!.position.x = 5; red4!.position.y = -55; red4!.position.z = -1.5
        red5!.position.x = 25; red5!.position.y = -55; red5!.position.z = -1.5
        newBean!.position.x = 15; newBean!.position.y = -30; newBean!.position.z = -1.5
        
        let blueHome = scnView.scene!.rootNode.childNodeWithName("BlueHome", recursively: true)
        let blueHomeEffect = scnView.scene!.rootNode.childNodeWithName("BlueHomeEffect", recursively: true)
        let redHome = scnView.scene!.rootNode.childNodeWithName("RedHome", recursively: true)
        let redHomeEffect = scnView.scene!.rootNode.childNodeWithName("RedHomeEffect", recursively: true)
        let yellow = scnView.scene!.rootNode.childNodeWithName("YellowFlare", recursively: true)
        let posN = scnView.scene!.rootNode.childNodeWithName("PossibleN", recursively: true)
        let posS = scnView.scene!.rootNode.childNodeWithName("PossibleS", recursively: true)
        let posE = scnView.scene!.rootNode.childNodeWithName("PossibleE", recursively: true)
        let posW = scnView.scene!.rootNode.childNodeWithName("PossibleW", recursively: true)
        let posNE = scnView.scene!.rootNode.childNodeWithName("PossibleNE", recursively: true)
        let posNW = scnView.scene!.rootNode.childNodeWithName("PossibleNW", recursively: true)
        let posSE = scnView.scene!.rootNode.childNodeWithName("PossibleSE", recursively: true)
        let posSW = scnView.scene!.rootNode.childNodeWithName("PossibleSW", recursively: true)
        blueHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        redHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        blueHome!.opacity = 0.3
        redHome!.opacity = 0.3
        yellow!.opacity = 0
        posN!.opacity = 0
        posS!.opacity = 0
        posE!.opacity = 0
        posW!.opacity = 0
        posNE!.opacity = 0
        posNW!.opacity = 0
        posSE!.opacity = 0
        posSW!.opacity = 0
        
        let menubutton = subScene.rootNode.childNodeWithName("Menu", recursively: true)
        let menuinverse = subScene.rootNode.childNodeWithName("menuinverse", recursively: true)
        let howtomultiButton = subScene.rootNode.childNodeWithName("howtomulti", recursively: true)
        let connectButton = subScene.rootNode.childNodeWithName("connect", recursively: true)
        let newGameButton = subScene.rootNode.childNodeWithName("newgame", recursively: true)
        let mainmenubutton = subScene.rootNode.childNodeWithName("mainmenubutton", recursively: true)
        let dirmulti = subScene.rootNode.childNodeWithName("dirmulti", recursively: true)
        let multiboard1 = subScene.rootNode.childNodeWithName("multiboard1", recursively: true)
        let multiboard2 = subScene.rootNode.childNodeWithName("multiboard2", recursively: true)
        let multiboard3 = subScene.rootNode.childNodeWithName("multiboard3", recursively: true)
        let multiboard4 = subScene.rootNode.childNodeWithName("multiboard4", recursively: true)
        menubutton!.position.x = -5.8; menubutton!.position.y = -56.4; menubutton!.position.z = 1.5
        menuinverse!.position.x = -5.6; menuinverse!.position.y = -56.1; menuinverse!.position.z = 0.8
        howtomultiButton!.position.x = -5.8; howtomultiButton!.position.y = -57.5; howtomultiButton!.position.z = 1
        connectButton!.position.x = -5.8; connectButton!.position.y = -57.5; connectButton!.position.z = 1
        newGameButton!.position.x = -5.8; newGameButton!.position.y = -57.5; newGameButton!.position.z = 1
        mainmenubutton!.position.x = -5.8; mainmenubutton!.position.y = -57.5; mainmenubutton!.position.z = 1
        dirmulti!.position.x = -5.8; dirmulti!.position.y = -56.4; dirmulti!.position.z = 1
        multiboard1!.position.x = -3.65; multiboard1!.position.y = -54; multiboard1!.position.z = 1
        multiboard1!.position.x = -3.65; multiboard1!.position.y = -54; multiboard1!.position.z = 1
        multiboard2!.position.x = -3.65; multiboard2!.position.y = -54; multiboard2!.position.z = 1
        multiboard3!.position.x = -3.65; multiboard3!.position.y = -54; multiboard3!.position.z = 1
        multiboard4!.position.x = -3.65; multiboard4!.position.y = -54; multiboard4!.position.z = 1
        howtomultiButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        connectButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        newGameButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        mainmenubutton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        multiboard1!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        multiboard2!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        multiboard3!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        multiboard4!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        dirmulti!.opacity = 0
        scene.rootNode.addChildNode(menubutton!)
        scene.rootNode.addChildNode(menuinverse!)
        scene.rootNode.addChildNode(howtomultiButton!)
        scene.rootNode.addChildNode(connectButton!)
        scene.rootNode.addChildNode(newGameButton!)
        scene.rootNode.addChildNode(mainmenubutton!)
        scene.rootNode.addChildNode(dirmulti!)
        scene.rootNode.addChildNode(multiboard1!)
        scene.rootNode.addChildNode(multiboard2!)
        scene.rootNode.addChildNode(multiboard3!)
        scene.rootNode.addChildNode(multiboard4!)
    }
    
    func boardMultiPlayer3Scene() {
        let scene = SCNScene(named: "art.scnassets/BoardMultiPlayer3Scene.dae")!
        let subScene = SCNScene(named: "art.scnassets/SubMenuScene.dae")!
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 12, y: -26.6, z: 56)
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 17, y: -34, z: 50)
        scene.rootNode.addChildNode(lightNode)
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = false
        scnView.showsStatistics = false
        scnView.backgroundColor = UIColor.blackColor()
        
        winLoseMarker = "gameOn"
        multiPlayerRulesOn = true
        staticPlayer = false
        currentPlayer = "x"
        multiNumber = 3
        cols = 7
        rows = 13
        pSizeW = 5
        pSizeH = 5
        blueBeanActive = false
        redBeanActive = false
        aiStall = 0
        aiDirection = 0
        blueCaptured = 5
        redCaptured = 5
        cellWidth = Int(screenWidth/7)
        cellHeight = Int(screenHeight/13)
        for x in 0..<cols {
            boardArray.append(Array(count:rows, repeatedValue: .Empty))
            for y in 0..<rows {
                if x == 3 && y == 9 || x == 2 && y == 10 || x == 4 && y == 10 || x == 2 && y == 12 || x == 4 && y == 12 { boardArray[x][y] = .BluePiece }
                else if x == 3 && y == 3 || x == 2 && y == 2 || x == 4 && y == 2 || x == 2 && y == 0 || x == 4 && y == 0 { boardArray[x][y] = .RedPiece }
                else if x == 3 && y == 6 { boardArray[x][y] = .Bean }
                else { boardArray[x][y] = .Empty }
            }
        }
        
        let blue1 = scnView.scene!.rootNode.childNodeWithName("Blue01", recursively: true)
        let blue2 = scnView.scene!.rootNode.childNodeWithName("Blue02", recursively: true)
        let blue3 = scnView.scene!.rootNode.childNodeWithName("Blue03", recursively: true)
        let blue4 = scnView.scene!.rootNode.childNodeWithName("Blue04", recursively: true)
        let blue5 = scnView.scene!.rootNode.childNodeWithName("Blue05", recursively: true)
        let red1 = scnView.scene!.rootNode.childNodeWithName("Red01", recursively: true)
        let red2 = scnView.scene!.rootNode.childNodeWithName("Red02", recursively: true)
        let red3 = scnView.scene!.rootNode.childNodeWithName("Red03", recursively: true)
        let red4 = scnView.scene!.rootNode.childNodeWithName("Red04", recursively: true)
        let red5 = scnView.scene!.rootNode.childNodeWithName("Red05", recursively: true)
        blue1!.position.x = 15; blue1!.position.y = -45; blue1!.position.z = -1.5
        blue2!.position.x = 10; blue2!.position.y = -50; blue2!.position.z = -1.5
        blue3!.position.x = 20; blue3!.position.y = -50; blue3!.position.z = -1.5
        blue4!.position.x = 10; blue4!.position.y = -60; blue4!.position.z = -1.5
        blue5!.position.x = 20; blue5!.position.y = -60; blue5!.position.z = -1.5
        red1!.position.x = 15; red1!.position.y = -15; red1!.position.z = -1.5
        red2!.position.x = 10; red2!.position.y = -10; red2!.position.z = -1.5
        red3!.position.x = 20; red3!.position.y = -10; red3!.position.z = -1.5
        red4!.position.x = 10; red4!.position.y = 0; red4!.position.z = -1.5
        red5!.position.x = 20; red5!.position.y = 0; red5!.position.z = -1.5
        
        let blueHome = scnView.scene!.rootNode.childNodeWithName("BlueHome", recursively: true)
        let blueHomeEffect = scnView.scene!.rootNode.childNodeWithName("BlueHomeEffect", recursively: true)
        let redHome = scnView.scene!.rootNode.childNodeWithName("RedHome", recursively: true)
        let redHomeEffect = scnView.scene!.rootNode.childNodeWithName("RedHomeEffect", recursively: true)
        let yellow = scnView.scene!.rootNode.childNodeWithName("YellowFlare", recursively: true)
        let posN = scnView.scene!.rootNode.childNodeWithName("PossibleN", recursively: true)
        let posS = scnView.scene!.rootNode.childNodeWithName("PossibleS", recursively: true)
        let posE = scnView.scene!.rootNode.childNodeWithName("PossibleE", recursively: true)
        let posW = scnView.scene!.rootNode.childNodeWithName("PossibleW", recursively: true)
        let posNE = scnView.scene!.rootNode.childNodeWithName("PossibleNE", recursively: true)
        let posNW = scnView.scene!.rootNode.childNodeWithName("PossibleNW", recursively: true)
        let posSE = scnView.scene!.rootNode.childNodeWithName("PossibleSE", recursively: true)
        let posSW = scnView.scene!.rootNode.childNodeWithName("PossibleSW", recursively: true)
        blueHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        redHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        blueHome!.opacity = 0.3
        redHome!.opacity = 0.3
        yellow!.opacity = 0
        posN!.opacity = 0
        posS!.opacity = 0
        posE!.opacity = 0
        posW!.opacity = 0
        posNE!.opacity = 0
        posNW!.opacity = 0
        posSE!.opacity = 0
        posSW!.opacity = 0
        
        let menubutton = subScene.rootNode.childNodeWithName("Menu", recursively: true)
        let menuinverse = subScene.rootNode.childNodeWithName("menuinverse", recursively: true)
        let howtomultiButton = subScene.rootNode.childNodeWithName("howtomulti", recursively: true)
        let connectButton = subScene.rootNode.childNodeWithName("connect", recursively: true)
        let newGameButton = subScene.rootNode.childNodeWithName("newgame", recursively: true)
        let mainmenubutton = subScene.rootNode.childNodeWithName("mainmenubutton", recursively: true)
        let dirmulti = subScene.rootNode.childNodeWithName("dirmulti", recursively: true)
        let multiboard1 = subScene.rootNode.childNodeWithName("multiboard1", recursively: true)
        let multiboard2 = subScene.rootNode.childNodeWithName("multiboard2", recursively: true)
        let multiboard3 = subScene.rootNode.childNodeWithName("multiboard3", recursively: true)
        let multiboard4 = subScene.rootNode.childNodeWithName("multiboard4", recursively: true)
        menubutton!.position.x = -6; menubutton!.position.y = -58.5; menubutton!.position.z = 1
        menuinverse!.position.x = -6; menuinverse!.position.y = -58.5; menuinverse!.position.z = 0.8
        howtomultiButton!.position.x = -5.8; howtomultiButton!.position.y = -57.5; howtomultiButton!.position.z = 1
        connectButton!.position.x = -5.8; connectButton!.position.y = -57.5; connectButton!.position.z = 1
        newGameButton!.position.x = -5.8; newGameButton!.position.y = -57.5; newGameButton!.position.z = 1
        mainmenubutton!.position.x = -5.8; mainmenubutton!.position.y = -57.5; mainmenubutton!.position.z = 1
        dirmulti!.position.x = -5.8; dirmulti!.position.y = -56.4; dirmulti!.position.z = 1
        multiboard1!.position.x = -3.65; multiboard1!.position.y = -54; multiboard1!.position.z = 1
        multiboard1!.position.x = -3.65; multiboard1!.position.y = -54; multiboard1!.position.z = 1
        multiboard2!.position.x = -3.65; multiboard2!.position.y = -54; multiboard2!.position.z = 1
        multiboard3!.position.x = -3.65; multiboard3!.position.y = -54; multiboard3!.position.z = 1
        multiboard4!.position.x = -3.65; multiboard4!.position.y = -54; multiboard4!.position.z = 1
        howtomultiButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        connectButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        newGameButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        mainmenubutton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        multiboard1!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        multiboard2!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        multiboard3!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        multiboard4!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        dirmulti!.opacity = 0
        scene.rootNode.addChildNode(menubutton!)
        scene.rootNode.addChildNode(menuinverse!)
        scene.rootNode.addChildNode(howtomultiButton!)
        scene.rootNode.addChildNode(connectButton!)
        scene.rootNode.addChildNode(newGameButton!)
        scene.rootNode.addChildNode(mainmenubutton!)
        scene.rootNode.addChildNode(dirmulti!)
        scene.rootNode.addChildNode(multiboard1!)
        scene.rootNode.addChildNode(multiboard2!)
        scene.rootNode.addChildNode(multiboard3!)
        scene.rootNode.addChildNode(multiboard4!)
    }
    
    func boardMultiPlayer4Scene() {
        let scene = SCNScene(named: "art.scnassets/BoardMultiPlayer4Scene.dae")!
        let subScene = SCNScene(named: "art.scnassets/SubMenuScene.dae")!
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 12, y: -27.5, z: 55)
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 17, y: -34, z: 50)
        scene.rootNode.addChildNode(lightNode)
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = false
        scnView.showsStatistics = false
        scnView.backgroundColor = UIColor.blackColor()
        
        winLoseMarker = "gameOn"
        multiPlayerRulesOn = true
        staticPlayer = false
        currentPlayer = "x"
        multiNumber = 4
        cols = 9
        rows = 15
        pSizeW = 4
        pSizeH = 4
        blueBeanActive = false
        redBeanActive = false
        aiStall = 0
        aiDirection = 0
        blueCaptured = 5
        redCaptured = 5
        cellWidth = Int(screenWidth/9)
        cellHeight = Int(screenHeight/15)
        for x in 0..<cols {
            boardArray.append(Array(count:rows, repeatedValue: .Empty))
            for y in 0..<rows {
                if x == 4 && y == 10 || x == 3 && y == 11 || x == 5 && y == 11 || x == 2 && y == 2 || x == 6 && y == 2 {  boardArray[x][y] = .BluePiece }
                else if x == 4 && y == 4 || x == 3 && y == 3 || x == 5 && y == 3 || x == 2 && y == 12 || x == 6 && y == 12 { boardArray[x][y] = .RedPiece }
                else if x == 4 && y == 7 { boardArray[x][y] = .Bean }
                else { boardArray[x][y] = .Empty }
            }
        }
        
        let blue1 = scnView.scene!.rootNode.childNodeWithName("Blue01", recursively: true)
        let blue2 = scnView.scene!.rootNode.childNodeWithName("Blue02", recursively: true)
        let blue3 = scnView.scene!.rootNode.childNodeWithName("Blue03", recursively: true)
        let blue4 = scnView.scene!.rootNode.childNodeWithName("Blue04", recursively: true)
        let blue5 = scnView.scene!.rootNode.childNodeWithName("Blue05", recursively: true)
        let red1 = scnView.scene!.rootNode.childNodeWithName("Red01", recursively: true)
        let red2 = scnView.scene!.rootNode.childNodeWithName("Red02", recursively: true)
        let red3 = scnView.scene!.rootNode.childNodeWithName("Red03", recursively: true)
        let red4 = scnView.scene!.rootNode.childNodeWithName("Red04", recursively: true)
        let red5 = scnView.scene!.rootNode.childNodeWithName("Red05", recursively: true)
        blue1!.position.x = 16; blue1!.position.y = -40; blue1!.position.z = -1.5
        blue2!.position.x = 12; blue2!.position.y = -44; blue2!.position.z = -1.5
        blue3!.position.x = 20; blue3!.position.y = -44; blue3!.position.z = -1.5
        blue4!.position.x = 8; blue4!.position.y = -8; blue4!.position.z = -1.5
        blue5!.position.x = 24; blue5!.position.y = -8; blue5!.position.z = -1.5
        red1!.position.x = 16; red1!.position.y = -16; red1!.position.z = -1.5
        red2!.position.x = 12; red2!.position.y = -12; red2!.position.z = -1.5
        red3!.position.x = 20; red3!.position.y = -12; red3!.position.z = -1.5
        red4!.position.x = 8; red4!.position.y = -48; red4!.position.z = -1.5
        red5!.position.x = 24; red5!.position.y = -48; red5!.position.z = -1.5
        
        let blueHome = scnView.scene!.rootNode.childNodeWithName("BlueHome", recursively: true)
        let blueHomeEffect = scnView.scene!.rootNode.childNodeWithName("BlueHomeEffect", recursively: true)
        let redHome = scnView.scene!.rootNode.childNodeWithName("RedHome", recursively: true)
        let redHomeEffect = scnView.scene!.rootNode.childNodeWithName("RedHomeEffect", recursively: true)
        let yellow = scnView.scene!.rootNode.childNodeWithName("YellowFlare", recursively: true)
        let posN = scnView.scene!.rootNode.childNodeWithName("PossibleN", recursively: true)
        let posS = scnView.scene!.rootNode.childNodeWithName("PossibleS", recursively: true)
        let posE = scnView.scene!.rootNode.childNodeWithName("PossibleE", recursively: true)
        let posW = scnView.scene!.rootNode.childNodeWithName("PossibleW", recursively: true)
        let posNE = scnView.scene!.rootNode.childNodeWithName("PossibleNE", recursively: true)
        let posNW = scnView.scene!.rootNode.childNodeWithName("PossibleNW", recursively: true)
        let posSE = scnView.scene!.rootNode.childNodeWithName("PossibleSE", recursively: true)
        let posSW = scnView.scene!.rootNode.childNodeWithName("PossibleSW", recursively: true)
        blueHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        redHomeEffect!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        blueHome!.opacity = 0.3
        redHome!.opacity = 0.3
        yellow!.opacity = 0
        posN!.opacity = 0
        posS!.opacity = 0
        posE!.opacity = 0
        posW!.opacity = 0
        posNE!.opacity = 0
        posNW!.opacity = 0
        posSE!.opacity = 0
        posSW!.opacity = 0
        
        let menubutton = subScene.rootNode.childNodeWithName("Menu", recursively: true)
        let menuinverse = subScene.rootNode.childNodeWithName("menuinverse", recursively: true)
        let howtomultiButton = subScene.rootNode.childNodeWithName("howtomulti", recursively: true)
        let connectButton = subScene.rootNode.childNodeWithName("connect", recursively: true)
        let newGameButton = subScene.rootNode.childNodeWithName("newgame", recursively: true)
        let mainmenubutton = subScene.rootNode.childNodeWithName("mainmenubutton", recursively: true)
        let dirmulti = subScene.rootNode.childNodeWithName("dirmulti", recursively: true)
        let multiboard1 = subScene.rootNode.childNodeWithName("multiboard1", recursively: true)
        let multiboard2 = subScene.rootNode.childNodeWithName("multiboard2", recursively: true)
        let multiboard3 = subScene.rootNode.childNodeWithName("multiboard3", recursively: true)
        let multiboard4 = subScene.rootNode.childNodeWithName("multiboard4", recursively: true)
        menubutton!.position.x = -5.8; menubutton!.position.y = -56.4; menubutton!.position.z = 1
        menuinverse!.position.x = -5.6; menuinverse!.position.y = -56.1; menuinverse!.position.z = 0.8
        howtomultiButton!.position.x = -5.8; howtomultiButton!.position.y = -57.5; howtomultiButton!.position.z = 1
        connectButton!.position.x = -5.8; connectButton!.position.y = -57.5; connectButton!.position.z = 1
        newGameButton!.position.x = -5.8; newGameButton!.position.y = -57.5; newGameButton!.position.z = 1
        mainmenubutton!.position.x = -5.8; mainmenubutton!.position.y = -57.5; mainmenubutton!.position.z = 1
        dirmulti!.position.x = -5.8; dirmulti!.position.y = -56.4; dirmulti!.position.z = 1
        multiboard1!.position.x = -3.65; multiboard1!.position.y = -54; multiboard1!.position.z = 1
        multiboard1!.position.x = -3.65; multiboard1!.position.y = -54; multiboard1!.position.z = 1
        multiboard2!.position.x = -3.65; multiboard2!.position.y = -54; multiboard2!.position.z = 1
        multiboard3!.position.x = -3.65; multiboard3!.position.y = -54; multiboard3!.position.z = 1
        multiboard4!.position.x = -3.65; multiboard4!.position.y = -54; multiboard4!.position.z = 1
        howtomultiButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        connectButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        newGameButton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        mainmenubutton!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        multiboard1!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        multiboard2!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        multiboard3!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        multiboard4!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        dirmulti!.opacity = 0
        scene.rootNode.addChildNode(menubutton!)
        scene.rootNode.addChildNode(menuinverse!)
        scene.rootNode.addChildNode(howtomultiButton!)
        scene.rootNode.addChildNode(connectButton!)
        scene.rootNode.addChildNode(newGameButton!)
        scene.rootNode.addChildNode(mainmenubutton!)
        scene.rootNode.addChildNode(dirmulti!)
        scene.rootNode.addChildNode(multiboard1!)
        scene.rootNode.addChildNode(multiboard2!)
        scene.rootNode.addChildNode(multiboard3!)
        scene.rootNode.addChildNode(multiboard4!)
    }
    
    func gameOverYouLose() {
        let scene = SCNScene(named: "art.scnassets/LoseScene.dae")!
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 12, y: -25.5, z: 54.5)
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 17, y: -34, z: 50)
        scene.rootNode.addChildNode(lightNode)
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = false
        scnView.showsStatistics = false
        scnView.backgroundColor = UIColor.blackColor()
        bgMusic!.volume = 0
        swordClang!.stop()
        soundLoseThud!.currentTime = 0
        if sfxVol == 1 { soundLoseThud!.volume = 0.00001; soundLoseThud!.play() }
        if sfxVol == 2 { soundLoseThud!.volume = 0.1; soundLoseThud!.play() }
        if sfxVol == 3 { soundLoseThud!.volume = 0.5; soundLoseThud!.play() }
        if sfxVol == 4 { soundLoseThud!.volume = 1.0; soundLoseThud!.play() }
        
        let youlostpic = scnView.scene!.rootNode.childNodeWithName("youlostpic", recursively: true)
        let youlosttext = scnView.scene!.rootNode.childNodeWithName("youlosttext", recursively: true)
        
        let shrinkIt = SCNAction.scaleBy(0.2, duration: 6)
        let moveStuffLeft = SCNAction.moveBy(SCNVector3(x: -20, y: 0, z: 0), duration: 5)
        let shrinkStuff1 = SCNAction.sequence([SCNAction.waitForDuration(3.0), shrinkIt, SCNAction.waitForDuration(1.0), moveStuffLeft])
        
        youlosttext!.runAction(shrinkStuff1)
        youlostpic!.runAction(shrinkIt)
    }
    
    func gameOverYouWin() {
        let scene = SCNScene(named: "art.scnassets/WinScene.dae")!
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 12, y: -25.5, z: 54.5)
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 17, y: -34, z: 50)
        scene.rootNode.addChildNode(lightNode)
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = false
        scnView.showsStatistics = false
        scnView.backgroundColor = UIColor.blackColor()
        
        bgMusic!.volume = 0
        soundWin!.currentTime = 0
        fireworkSound!.currentTime = 0
        swordClang!.stop()
        if sfxVol == 1 { soundWin!.volume = 0.00001; soundWin!.play(); fireworkSound!.volume = 0.00001; fireworkSound!.play() }
        if sfxVol == 2 { soundWin!.volume = 0.1; soundWin!.play(); fireworkSound!.volume = 0.1; fireworkSound!.play() }
        if sfxVol == 3 { soundWin!.volume = 0.5; soundWin!.play(); fireworkSound!.volume = 0.5; fireworkSound!.play() }
        if sfxVol == 4 { soundWin!.volume = 1.0; soundWin!.play(); fireworkSound!.volume = 1.0; fireworkSound!.play() }
        
        let navya = scnView.scene!.rootNode.childNodeWithName("navya", recursively: true); navya!.opacity = 0.0
        let navyb = scnView.scene!.rootNode.childNodeWithName("navyb", recursively: true); navyb!.opacity = 0.0
        let navytext = scnView.scene!.rootNode.childNodeWithName("navytext", recursively: true); navytext!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        let garbanzoa = scnView.scene!.rootNode.childNodeWithName("garbanzoa", recursively: true); garbanzoa!.opacity = 0.0
        let garbanzob = scnView.scene!.rootNode.childNodeWithName("garbanzob", recursively: true); garbanzob!.opacity = 0.0
        let garbanzotext = scnView.scene!.rootNode.childNodeWithName("garbanzotext", recursively: true); garbanzotext!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        let soya = scnView.scene!.rootNode.childNodeWithName("soya", recursively: true); soya!.opacity = 0.0
        let soyb = scnView.scene!.rootNode.childNodeWithName("soyb", recursively: true); soyb!.opacity = 0.0
        let soytext = scnView.scene!.rootNode.childNodeWithName("soytext", recursively: true); soytext!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        let pintoa = scnView.scene!.rootNode.childNodeWithName("pintoa", recursively: true); pintoa!.opacity = 0.0
        let pintob = scnView.scene!.rootNode.childNodeWithName("pintob", recursively: true); pintob!.opacity = 0.0
        let pintotext = scnView.scene!.rootNode.childNodeWithName("pintotext", recursively: true); pintotext!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        let blacka = scnView.scene!.rootNode.childNodeWithName("blacka", recursively: true); blacka!.opacity = 0.0
        let blackb = scnView.scene!.rootNode.childNodeWithName("blackb", recursively: true); blackb!.opacity = 0.0
        let blacktext = scnView.scene!.rootNode.childNodeWithName("blacktext", recursively: true); blacktext!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        let adzukia = scnView.scene!.rootNode.childNodeWithName("adzukia", recursively: true); adzukia!.opacity = 0.0
        let adzukib = scnView.scene!.rootNode.childNodeWithName("adzukib", recursively: true); adzukib!.opacity = 0.0
        let adzukitext = scnView.scene!.rootNode.childNodeWithName("adzukitext", recursively: true); adzukitext!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        let munga = scnView.scene!.rootNode.childNodeWithName("munga", recursively: true); munga!.opacity = 0.0
        let mungb = scnView.scene!.rootNode.childNodeWithName("mungb", recursively: true); mungb!.opacity = 0.0
        let mungtext = scnView.scene!.rootNode.childNodeWithName("mungtext", recursively: true); mungtext!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        let fabaa = scnView.scene!.rootNode.childNodeWithName("fabaa", recursively: true); fabaa!.opacity = 0.0
        let fabab = scnView.scene!.rootNode.childNodeWithName("fabab", recursively: true); fabab!.opacity = 0.0
        let fabatext = scnView.scene!.rootNode.childNodeWithName("fabatext", recursively: true); fabatext!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        let coffeea = scnView.scene!.rootNode.childNodeWithName("coffeea", recursively: true); coffeea!.opacity = 0.0
        let coffeeb = scnView.scene!.rootNode.childNodeWithName("coffeeb", recursively: true); coffeeb!.opacity = 0.0
        let coffeetext = scnView.scene!.rootNode.childNodeWithName("coffeetext", recursively: true); coffeetext!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        let kidneya = scnView.scene!.rootNode.childNodeWithName("kidneya", recursively: true); kidneya!.opacity = 0.0
        let kidneyb = scnView.scene!.rootNode.childNodeWithName("kidneyb", recursively: true); kidneyb!.opacity = 0.0
        let kidneytext = scnView.scene!.rootNode.childNodeWithName("kidneytext", recursively: true); kidneytext!.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        
        let flare1 = scnView.scene!.rootNode.childNodeWithName("flare1", recursively: true)
        let flare2 = scnView.scene!.rootNode.childNodeWithName("flare2", recursively: true)
        let flare3 = scnView.scene!.rootNode.childNodeWithName("flare3", recursively: true)
        let flare4 = scnView.scene!.rootNode.childNodeWithName("flare4", recursively: true)
        
        let waitQuarter = SCNAction.waitForDuration(0.25)
        let waitHalf = SCNAction.waitForDuration(0.5)
        let wait1 = SCNAction.waitForDuration(1.0)
        let wait3 = SCNAction.waitForDuration(3.0)
        let expandText1 = SCNAction.scaleBy(2000, duration: 0.7)
        let contractText1 = SCNAction.scaleBy(0.6, duration: 0.4)
        let expandText2 = SCNAction.scaleBy(1.1, duration: 0.2)
        let contractText2 = SCNAction.scaleBy(0.90909, duration: 0.2)
        let textExpander = SCNAction.sequence([wait3, expandText1, contractText1, expandText2, contractText2])
        
        let expander = SCNAction.scaleBy(30, duration: 1)
        let reducer = SCNAction.scaleBy(0.033333, duration: 0.01)
        let fadeIn1 = SCNAction.fadeInWithDuration(0.1)
        let fadeOut1 = SCNAction.fadeOutWithDuration(0.25)
        
        flare1!.runAction(SCNAction.repeatAction(SCNAction.sequence([expander, waitQuarter, fadeOut1, reducer, waitQuarter, fadeIn1]), count: 30))
        flare2!.runAction(SCNAction.repeatAction(SCNAction.sequence([waitHalf, expander, waitQuarter, fadeOut1, reducer, waitQuarter, fadeIn1]), count: 30))
        flare3!.runAction(SCNAction.repeatAction(SCNAction.sequence([wait1, expander, waitQuarter, fadeOut1, reducer, waitQuarter, fadeIn1]), count: 30))
        flare4!.runAction(SCNAction.repeatAction(SCNAction.sequence([wait1, waitHalf, expander, waitQuarter, fadeOut1, reducer, waitQuarter, fadeIn1]), count: 30))
        
        if boardNumber == 1 { garbanzoOpen = true; navya!.opacity = 1.0; navytext!.runAction(textExpander) }
        if boardNumber == 2 { soyOpen = true; garbanzoa!.opacity = 1.0; garbanzotext!.runAction(textExpander) }
        if boardNumber == 3 { adzukiOpen = true; soya!.opacity = 1.0; soytext!.runAction(textExpander) }
        if boardNumber == 4 { pintoOpen = true; adzukia!.opacity = 1.0; adzukitext!.runAction(textExpander) }
        if boardNumber == 5 { blackOpen = true; pintoa!.opacity = 1.0; pintotext!.runAction(textExpander) }
        if boardNumber == 6 { kidneyOpen = true; blacka!.opacity = 1.0; blacktext!.runAction(textExpander) }
        if boardNumber == 7 { mungOpen = true; kidneya!.opacity = 1.0; kidneytext!.runAction(textExpander) }
        if boardNumber == 8 { fabaOpen = true; munga!.opacity = 1.0; mungtext!.runAction(textExpander) }
        if boardNumber == 9 { coffeeOpen = true; fabaa!.opacity = 1.0; fabatext!.runAction(textExpander) }
        if boardNumber == 10 { winnerOpen = true; coffeea!.opacity = 1.0; coffeetext!.runAction(textExpander) }
    }
    
    func multiplayerBlueWinsScene() {
        timer1.invalidate()
        timer2.invalidate()
        pauseCount = 0
        
        selBall = 0
        currentPlayer = "x"
        staticAI = true
        cols = 5
        rows = 9
        pSizeW = 7
        pSizeH = 7
        cellWidth = Int(screenWidth/5)
        cellHeight = Int(screenHeight/9)
        
        let scene = SCNScene(named: "art.scnassets/WinLoseMultiplayerScene.dae")!
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 12, y: -25.5, z: 54.5)
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 17, y: -34, z: 50)
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = false
        scnView.showsStatistics = false
        scnView.backgroundColor = UIColor.whiteColor()
        
        let wlBlueText = scnView.scene!.rootNode.childNodeWithName("winloseblue", recursively: true)
        let wlRedText = scnView.scene!.rootNode.childNodeWithName("winlosered", recursively: true)
        let wlRedPic = scnView.scene!.rootNode.childNodeWithName("winloseredwins", recursively: true)
        let wlBluePic = scnView.scene!.rootNode.childNodeWithName("winlosebluewins", recursively: true)

        print("win lose marker is blue. BLUE WINS!")
        wlBluePic!.position.x = 0
        wlRedPic!.position.x = -50
        wlRedText!.position.y = 13
        wlBlueText!.position.y = -13
        
        for x in 0..<cols {
            boardArray.append(Array(count:rows, repeatedValue: .Empty))
            for y in 0..<rows { boardArray[x][y] = .Empty }
        }
    }
    
    func multiplayerRedWinsScene() {
        timer1.invalidate()
        timer2.invalidate()
        pauseCount = 0
        
        selBall = 0
        currentPlayer = "x"
        staticAI = true
        cols = 5
        rows = 9
        pSizeW = 7
        pSizeH = 7
        cellWidth = Int(screenWidth/5)
        cellHeight = Int(screenHeight/9)
        
        let scene = SCNScene(named: "art.scnassets/WinLoseMultiplayerScene.dae")!
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 12, y: -25.5, z: 54.5)
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 17, y: -34, z: 50)
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = true
        scnView.showsStatistics = false
        scnView.backgroundColor = UIColor.whiteColor()
        
        let wlBlueText = scnView.scene!.rootNode.childNodeWithName("winloseblue", recursively: true)
        let wlRedText = scnView.scene!.rootNode.childNodeWithName("winlosered", recursively: true)
        let wlRedPic = scnView.scene!.rootNode.childNodeWithName("winloseredwins", recursively: true)
        let wlBluePic = scnView.scene!.rootNode.childNodeWithName("winlosebluewins", recursively: true)
        
        wlBluePic!.position.x = -50
        wlRedPic!.position.x = 0
        wlRedText!.position.y = 0
        wlBlueText!.position.y = 0
        
        for x in 0..<cols {
            boardArray.append(Array(count:rows, repeatedValue: .Empty))
            for y in 0..<rows { boardArray[x][y] = .Empty }
        }
    }
    
    func handleTap(gestureRecognize: UIGestureRecognizer) {
        let scnView = self.view as! SCNView
        let point = gestureRecognize.locationInView(scnView)
        let tapLoc = BoardLoc(x: Int(point.x) / cellWidth, y: Int(point.y) / cellHeight)
        let locX = Float(Int(point.x) / cellWidth) * Float(pSizeW)
        let locY = Float(Int(point.y) / cellHeight) * -Float(pSizeH)
        
        let menubutton = scnView.scene!.rootNode.childNodeWithName("Menu", recursively: true)
        let menuinverse = scnView.scene!.rootNode.childNodeWithName("menuinverse", recursively: true)
        let howtomultiButton = scnView.scene!.rootNode.childNodeWithName("howtomulti", recursively: true)
        let connectButton = scnView.scene!.rootNode.childNodeWithName("connect", recursively: true)
        let newGameButton = scnView.scene!.rootNode.childNodeWithName("newgame", recursively: true)
        let mainmenubutton = scnView.scene!.rootNode.childNodeWithName("mainmenubutton", recursively: true)
        let dirmulti = scnView.scene!.rootNode.childNodeWithName("dirmulti", recursively: true)
        let multiboard1 = scnView.scene!.rootNode.childNodeWithName("multiboard1", recursively: true)
        let multiboard2 = scnView.scene!.rootNode.childNodeWithName("multiboard2", recursively: true)
        let multiboard3 = scnView.scene!.rootNode.childNodeWithName("multiboard3", recursively: true)
        let multiboard4 = scnView.scene!.rootNode.childNodeWithName("multiboard4", recursively: true)
        
        let blue1 = scnView.scene!.rootNode.childNodeWithName("Blue01", recursively: true)
        let blue2 = scnView.scene!.rootNode.childNodeWithName("Blue02", recursively: true)
        let blue3 = scnView.scene!.rootNode.childNodeWithName("Blue03", recursively: true)
        let blue4 = scnView.scene!.rootNode.childNodeWithName("Blue04", recursively: true)
        let blue5 = scnView.scene!.rootNode.childNodeWithName("Blue05", recursively: true)
        let blue6 = scnView.scene!.rootNode.childNodeWithName("Blue06", recursively: true)
        let blue7 = scnView.scene!.rootNode.childNodeWithName("Blue07", recursively: true)
        let blueBean = scnView.scene!.rootNode.childNodeWithName("BlueBeanObject", recursively: true)
        let red1 = scnView.scene!.rootNode.childNodeWithName("Red01", recursively: true)
        let red2 = scnView.scene!.rootNode.childNodeWithName("Red02", recursively: true)
        let red3 = scnView.scene!.rootNode.childNodeWithName("Red03", recursively: true)
        let red4 = scnView.scene!.rootNode.childNodeWithName("Red04", recursively: true)
        let red5 = scnView.scene!.rootNode.childNodeWithName("Red05", recursively: true)
        let red6 = scnView.scene!.rootNode.childNodeWithName("Red06", recursively: true)
        let red7 = scnView.scene!.rootNode.childNodeWithName("Red07", recursively: true)
        let redBean = scnView.scene!.rootNode.childNodeWithName("RedBeanObject", recursively: true)
        let newbean = scnView.scene!.rootNode.childNodeWithName("NewBean", recursively: true)
        let blueHome = scnView.scene!.rootNode.childNodeWithName("BlueHome", recursively: true)
        let redHome = scnView.scene!.rootNode.childNodeWithName("RedHome", recursively: true)
        let blueHomeEffect = scnView.scene!.rootNode.childNodeWithName("BlueHomeEffect", recursively: true)
        let redHomeEffect = scnView.scene!.rootNode.childNodeWithName("RedHomeEffect", recursively: true)
        
        let backgroundnormal = scnView.scene!.rootNode.childNodeWithName("backgroundnormal", recursively: true)
        let backgroundcolor = scnView.scene!.rootNode.childNodeWithName("backgroundcolor", recursively: true)
        let learnbutton = scnView.scene!.rootNode.childNodeWithName("learnbutton", recursively: true)
        let learncolor = scnView.scene!.rootNode.childNodeWithName("learncolor", recursively: true)
        let vsaibutton = scnView.scene!.rootNode.childNodeWithName("vsaibutton", recursively: true)
        let vsaicolor = scnView.scene!.rootNode.childNodeWithName("vsaicolor", recursively: true)
        let peepsbutton = scnView.scene!.rootNode.childNodeWithName("peepsbutton", recursively: true)
        let peepscolor = scnView.scene!.rootNode.childNodeWithName("peepscolor", recursively: true)
        let soundbutton = scnView.scene!.rootNode.childNodeWithName("soundbutton", recursively: true)
        let soundcolor = scnView.scene!.rootNode.childNodeWithName("soundcolor", recursively: true)
        let guidebutton = scnView.scene!.rootNode.childNodeWithName("guidebutton", recursively: true)
        let guidecolor = scnView.scene!.rootNode.childNodeWithName("guidecolor", recursively: true)
        let title1 = scnView.scene!.rootNode.childNodeWithName("title1", recursively: true)
        let title2 = scnView.scene!.rootNode.childNodeWithName("title2", recursively: true)
        let title3 = scnView.scene!.rootNode.childNodeWithName("title3", recursively: true)
        let title4 = scnView.scene!.rootNode.childNodeWithName("title4", recursively: true)
        let title5 = scnView.scene!.rootNode.childNodeWithName("title5", recursively: true)
        let title1color = scnView.scene!.rootNode.childNodeWithName("title1color", recursively: true)
        let title2color = scnView.scene!.rootNode.childNodeWithName("title2color", recursively: true)
        let title3color = scnView.scene!.rootNode.childNodeWithName("title3color", recursively: true)
        let title4color = scnView.scene!.rootNode.childNodeWithName("title4color", recursively: true)
        let title5color = scnView.scene!.rootNode.childNodeWithName("title5color", recursively: true)
        let sfxOff = scnView.scene!.rootNode.childNodeWithName("effectsvoloff", recursively: true)
        let sfxLo = scnView.scene!.rootNode.childNodeWithName("effectsvollow", recursively: true)
        let sfxMid = scnView.scene!.rootNode.childNodeWithName("effectsvolmid", recursively: true)
        let sfxHi = scnView.scene!.rootNode.childNodeWithName("effectsvolhigh", recursively: true)
        let musicOff = scnView.scene!.rootNode.childNodeWithName("musicoff", recursively: true)
        let musicLo = scnView.scene!.rootNode.childNodeWithName("musiclow", recursively: true)
        let musicMid = scnView.scene!.rootNode.childNodeWithName("musicmid", recursively: true)
        let musicHi = scnView.scene!.rootNode.childNodeWithName("musichigh", recursively: true)
        let guideson = scnView.scene!.rootNode.childNodeWithName("guideson", recursively: true)
        let guidesoff = scnView.scene!.rootNode.childNodeWithName("guidesoff", recursively: true)
        
        let navya = scnView.scene!.rootNode.childNodeWithName("navya", recursively: true)
        let garbanzoa = scnView.scene!.rootNode.childNodeWithName("garbanzoa", recursively: true)
        let soya = scnView.scene!.rootNode.childNodeWithName("soya", recursively: true)
        let pintoa = scnView.scene!.rootNode.childNodeWithName("pintoa", recursively: true)
        let blacka = scnView.scene!.rootNode.childNodeWithName("blacka", recursively: true)
        let adzukia = scnView.scene!.rootNode.childNodeWithName("adzukia", recursively: true)
        let munga = scnView.scene!.rootNode.childNodeWithName("munga", recursively: true)
        let fabaa = scnView.scene!.rootNode.childNodeWithName("fabaa", recursively: true)
        let coffeea = scnView.scene!.rootNode.childNodeWithName("coffeea", recursively: true)
        let kidneya = scnView.scene!.rootNode.childNodeWithName("kidneya", recursively: true)
        let navyb = scnView.scene!.rootNode.childNodeWithName("navyb", recursively: true)
        let garbanzob = scnView.scene!.rootNode.childNodeWithName("garbanzob", recursively: true)
        let soyb = scnView.scene!.rootNode.childNodeWithName("soyb", recursively: true)
        let pintob = scnView.scene!.rootNode.childNodeWithName("pintob", recursively: true)
        let blackb = scnView.scene!.rootNode.childNodeWithName("blackb", recursively: true)
        let adzukib = scnView.scene!.rootNode.childNodeWithName("adzukib", recursively: true)
        let mungb = scnView.scene!.rootNode.childNodeWithName("mungb", recursively: true)
        let fabab = scnView.scene!.rootNode.childNodeWithName("fabab", recursively: true)
        let coffeeb = scnView.scene!.rootNode.childNodeWithName("coffeeb", recursively: true)
        let kidneyb = scnView.scene!.rootNode.childNodeWithName("kidneyb", recursively: true)
        
        let bean01 = scnView.scene!.rootNode.childNodeWithName("bean01", recursively: true)
        let bean02 = scnView.scene!.rootNode.childNodeWithName("bean02", recursively: true)
        let bean03 = scnView.scene!.rootNode.childNodeWithName("bean03", recursively: true)
        let bean04 = scnView.scene!.rootNode.childNodeWithName("bean04", recursively: true)
        let bean05 = scnView.scene!.rootNode.childNodeWithName("bean05", recursively: true)
        let bean06 = scnView.scene!.rootNode.childNodeWithName("bean06", recursively: true)
        let bean07 = scnView.scene!.rootNode.childNodeWithName("bean07", recursively: true)
        let bean08 = scnView.scene!.rootNode.childNodeWithName("bean08", recursively: true)
        let bean09 = scnView.scene!.rootNode.childNodeWithName("bean09", recursively: true)
        let bean10 = scnView.scene!.rootNode.childNodeWithName("bean10", recursively: true)
        let dir01b = scnView.scene!.rootNode.childNodeWithName("dir01b", recursively: true)
        let dir02b = scnView.scene!.rootNode.childNodeWithName("dir02b", recursively: true)
        let dir03b = scnView.scene!.rootNode.childNodeWithName("dir03b", recursively: true)
        let dir04b = scnView.scene!.rootNode.childNodeWithName("dir04b", recursively: true)
        let dir05b = scnView.scene!.rootNode.childNodeWithName("dir05b", recursively: true)
        let dir06b = scnView.scene!.rootNode.childNodeWithName("dir06b", recursively: true)
        let dir07b = scnView.scene!.rootNode.childNodeWithName("dir07b", recursively: true)
        let dir08b = scnView.scene!.rootNode.childNodeWithName("dir08b", recursively: true)
        let dir09b = scnView.scene!.rootNode.childNodeWithName("dir09b", recursively: true)
        let piece1 = scnView.scene!.rootNode.childNodeWithName("piece1", recursively: true)
        let piece2 = scnView.scene!.rootNode.childNodeWithName("piece2", recursively: true)
        let piece3 = scnView.scene!.rootNode.childNodeWithName("piece3", recursively: true)
        let piece4 = scnView.scene!.rootNode.childNodeWithName("piece4", recursively: true)
        let piece5 = scnView.scene!.rootNode.childNodeWithName("piece5", recursively: true)

        let yellow = scnView.scene!.rootNode.childNodeWithName("YellowFlare", recursively: true)
        let posN = scnView.scene!.rootNode.childNodeWithName("PossibleN", recursively: true)
        let posS = scnView.scene!.rootNode.childNodeWithName("PossibleS", recursively: true)
        let posE = scnView.scene!.rootNode.childNodeWithName("PossibleE", recursively: true)
        let posW = scnView.scene!.rootNode.childNodeWithName("PossibleW", recursively: true)
        let posNE = scnView.scene!.rootNode.childNodeWithName("PossibleNE", recursively: true)
        let posNW = scnView.scene!.rootNode.childNodeWithName("PossibleNW", recursively: true)
        let posSE = scnView.scene!.rootNode.childNodeWithName("PossibleSE", recursively: true)
        let posSW = scnView.scene!.rootNode.childNodeWithName("PossibleSW", recursively: true)
        let arrowposN = scnView.scene!.rootNode.childNodeWithName("arrowposN", recursively: true)
        let arrowposS = scnView.scene!.rootNode.childNodeWithName("arrowposS", recursively: true)
        let arrowposE = scnView.scene!.rootNode.childNodeWithName("arrowposE", recursively: true)
        let arrowposW = scnView.scene!.rootNode.childNodeWithName("arrowposW", recursively: true)
        let arrowposNE = scnView.scene!.rootNode.childNodeWithName("arrowposNE", recursively: true)
        let arrowposNW = scnView.scene!.rootNode.childNodeWithName("arrowposNW", recursively: true)
        let arrowposSE = scnView.scene!.rootNode.childNodeWithName("arrowposSE", recursively: true)
        let arrowposSW = scnView.scene!.rootNode.childNodeWithName("arrowposSW", recursively: true)
        
        let shrinker = SCNAction.scaleBy(0.001, duration: 0.1)
        let expander = SCNAction.scaleBy(1000, duration: 0.1)
        let popIn = SCNAction.fadeInWithDuration(0.001)
        let popOut = SCNAction.fadeOutWithDuration(0.001)
        let slipOut = SCNAction.fadeOutWithDuration(0.05)
        let fadeIn = SCNAction.fadeInWithDuration(0.5)
        let fadeOut = SCNAction.fadeOutWithDuration(1.0)
        let wait1 = SCNAction.waitForDuration(1)
        let wait2 = SCNAction.waitForDuration(2)
        let wait3 = SCNAction.waitForDuration(3)
        let wait4 = SCNAction.waitForDuration(4)
        let wait6 = SCNAction.waitForDuration(6)
        let popWaitSlipOut = SCNAction.sequence([popIn, wait3, slipOut])
        let scaleBeanUp = SCNAction.scaleBy(4, duration: 0.2)
        let scaleBeanDown = SCNAction.scaleBy(0.2, duration: 0.2)
        let scalePieceDown = SCNAction.scaleBy(0.001, duration: 0.5)
        let scalePieceUp = SCNAction.scaleBy(1000, duration: 0.5)
        let hitPiece = SCNAction.sequence([scalePieceDown, wait1, scalePieceUp])
        let setBeanSize = SCNAction.scaleBy(2, duration: 2)
        let openBeanLevel = SCNAction.sequence([popIn, scaleBeanUp, scaleBeanDown, scaleBeanUp, scaleBeanDown, setBeanSize])
        
        let waveWait1 = SCNAction.waitForDuration(2)
        let waveWait2 = SCNAction.waitForDuration(2.2)
        let waveWait3 = SCNAction.waitForDuration(2.4)
        let waveWait4 = SCNAction.waitForDuration(2.6)
        let waveWait5 = SCNAction.waitForDuration(2.8)
        let waveWait6 = SCNAction.waitForDuration(3.0)
        let waveWait7 = SCNAction.waitForDuration(3.2)
        let waveWait8 = SCNAction.waitForDuration(3.4)
        let waveWait9 = SCNAction.waitForDuration(3.6)
        let waveWait10 = SCNAction.waitForDuration(3.8)
        
        // win characters
        let hideWinBean = SCNAction.fadeOutWithDuration(0.01)
        let showWinBean = SCNAction.fadeInWithDuration(0.01)
        let popWinBeanA2 = SCNAction.sequence([hideWinBean, wait2, showWinBean])
        let popWinBeanB2 = SCNAction.sequence([showWinBean, wait2, hideWinBean])
        let popWinBeanA4 = SCNAction.sequence([hideWinBean, wait4, showWinBean])
        let popWinBeanB4 = SCNAction.sequence([showWinBean, wait4, hideWinBean])
        let popWinBeanA6 = SCNAction.sequence([hideWinBean, wait6, showWinBean])
        let popWinBeanB6 = SCNAction.sequence([showWinBean, wait6, hideWinBean])

        // place possible moves
        let contractor = SCNAction.scaleBy(0.00892857142, duration: 0.001)
        let uncontractor = SCNAction.scaleBy(112, duration: 0.001)
        let popPos = SCNAction.sequence([popOut, uncontractor, contractor, fadeIn, wait1, fadeOut])
        let getPosN1 = SCNAction.moveTo(SCNVector3(x: locX, y: locY + Float(pSizeH), z: -1.4), duration: 0.005)
        let getPosS1 = SCNAction.moveTo(SCNVector3(x: locX, y: locY - Float(pSizeH), z: -1.4), duration: 0.005)
        let getPosE1 = SCNAction.moveTo(SCNVector3(x: locX + Float(pSizeW) , y: locY, z: -1.4), duration: 0.005)
        let getPosW1 = SCNAction.moveTo(SCNVector3(x: locX - Float(pSizeW) , y: locY, z: -1.4), duration: 0.005)
        let getPosNE1 = SCNAction.moveTo(SCNVector3(x: locX + Float(pSizeW), y: locY + Float(pSizeH), z: -1.4), duration: 0.005)
        let getPosSE1 = SCNAction.moveTo(SCNVector3(x: locX + Float(pSizeW), y: locY - Float(pSizeH), z: -1.4), duration: 0.005)
        let getPosNW1 = SCNAction.moveTo(SCNVector3(x: locX - Float(pSizeW), y: locY + Float(pSizeH), z: -1.4), duration: 0.005)
        let getPosSW1 = SCNAction.moveTo(SCNVector3(x: locX - Float(pSizeW), y: locY - Float(pSizeH), z: -1.4), duration: 0.005)
        let getPosN2 = SCNAction.moveTo(SCNVector3(x: locX, y: locY + Float(pSizeH) * 2, z: -1.4), duration: 0.005)
        let getPosS2 = SCNAction.moveTo(SCNVector3(x: locX, y: locY - Float(pSizeH) * 2, z: -1.4), duration: 0.005)
        let getPosE2 = SCNAction.moveTo(SCNVector3(x: locX + Float(pSizeW) * 2 , y: locY, z: -1.4), duration: 0.005)
        let getPosW2 = SCNAction.moveTo(SCNVector3(x: locX - Float(pSizeW) * 2 , y: locY, z: -1.4), duration: 0.005)
        let getPosNE2 = SCNAction.moveTo(SCNVector3(x: locX + Float(pSizeW) * 2, y: locY + Float(pSizeH) * 2, z: -1.4), duration: 0.005)
        let getPosNW2 = SCNAction.moveTo(SCNVector3(x: locX - Float(pSizeW) * 2, y: locY + Float(pSizeH) * 2, z: -1.4), duration: 0.005)
        let getPosSE2 = SCNAction.moveTo(SCNVector3(x: locX + Float(pSizeW) * 2, y: locY - Float(pSizeH) * 2, z: -1.4), duration: 0.005)
        let getPosSW2 = SCNAction.moveTo(SCNVector3(x: locX - Float(pSizeW) * 2, y: locY - Float(pSizeH) * 2, z: -1.4), duration: 0.005)
        let getPosN3 = SCNAction.moveTo(SCNVector3(x: locX, y: locY + Float(pSizeH) * 3, z: -1.6), duration: 0.005)
        let getPosS3 = SCNAction.moveTo(SCNVector3(x: locX, y: locY - Float(pSizeH) * 3, z: -1.6), duration: 0.005)
        let getPosE3 = SCNAction.moveTo(SCNVector3(x: locX + Float(pSizeW) * 3 , y: locY, z: -1.6), duration: 0.005)
        let getPosW3 = SCNAction.moveTo(SCNVector3(x: locX - Float(pSizeW) * 3 , y: locY, z: -1.6), duration: 0.005)
        let getPosNE3 = SCNAction.moveTo(SCNVector3(x: locX + Float(pSizeW) * 3, y: locY + Float(pSizeH) * 3, z: -1.6), duration: 0.005)
        let getPosNW3 = SCNAction.moveTo(SCNVector3(x: locX - Float(pSizeW) * 3, y: locY + Float(pSizeH) * 3, z: -1.6), duration: 0.005)
        let getPosSE3 = SCNAction.moveTo(SCNVector3(x: locX + Float(pSizeW) * 3, y: locY - Float(pSizeH) * 3, z: -1.6), duration: 0.005)
        let getPosSW3 = SCNAction.moveTo(SCNVector3(x: locX - Float(pSizeW) * 3, y: locY - Float(pSizeH) * 3, z: -1.6), duration: 0.005)
        
        // game actions
        let movePlayer = SCNAction.moveTo(SCNVector3(x: locX, y: locY, z: -1.5), duration: 0.01)
        let takeOff = SCNAction.moveTo(SCNVector3(x: 17, y: -100, z: -35), duration: 0.01)
        
        //effect actions
        let effectA = SCNAction.scaleBy(1000, duration: 0.1)
        let effectB = SCNAction.scaleBy(2, duration: 0.1)
        let effectC = SCNAction.scaleBy(0.5, duration: 0.1)
        let effectD = SCNAction.scaleBy(0.001, duration: 0.1)
        let show = SCNAction.fadeInWithDuration(0.001)
        let hide = SCNAction.fadeOutWithDuration(0.4)
        let pause = SCNAction.waitForDuration(0.4)
        let popHome = SCNAction.sequence([pause, show, effectA, effectB, effectC, pause, effectD, hide])
        
/////////////////
//  HANDLE TAP //
/////////////////
        
        let hitResults = scnView.hitTest(point, options: nil)
        if hitResults.count > 0 {
            let result: AnyObject! = hitResults[0]

            if result.node!.name!.hasPrefix("Menu") {
                sound1()
                newGameButton!.runAction(expander)
                mainmenubutton!.runAction(expander)
                menubutton!.runAction(shrinker)
                menuinverse!.runAction(expander)
                if multiPlayerRulesOn == true {
                    howtomultiButton!.runAction(expander)
                    connectButton!.runAction(expander)
                    multiboard1!.runAction(expander)
                    multiboard2!.runAction(expander)
                    multiboard3!.runAction(expander)
                    multiboard4!.runAction(expander)
                    dirmulti!.opacity = 0
                }
            }
            
            if result.node!.name!.hasPrefix("menuinverse") {
                sound1()
                menubutton!.runAction(expander)
                menuinverse!.runAction(shrinker)
                newGameButton!.runAction(shrinker)
                mainmenubutton!.runAction(shrinker)
                
                if multiPlayerRulesOn == true {
                    howtomultiButton!.runAction(shrinker)
                    connectButton!.runAction(shrinker)
                    multiboard1!.runAction(shrinker)
                    multiboard2!.runAction(shrinker)
                    multiboard3!.runAction(shrinker)
                    multiboard4!.runAction(shrinker)
                }
            }
            
            if result.node!.name!.hasPrefix("howtomulti") {
                sound1()
                dirmulti!.opacity = 1
                menubutton!.runAction(expander)
                menuinverse!.runAction(shrinker)
                howtomultiButton!.runAction(shrinker)
                connectButton!.runAction(shrinker)
                newGameButton!.runAction(shrinker)
                mainmenubutton!.runAction(shrinker)
                multiboard1!.runAction(shrinker)
                multiboard2!.runAction(shrinker)
                multiboard3!.runAction(shrinker)
                multiboard4!.runAction(shrinker)
            }
            
            if result.node!.name!.hasPrefix("connect") {
                sound1()
                menubutton!.runAction(expander)
                menuinverse!.runAction(shrinker)
                howtomultiButton!.runAction(shrinker)
                multiboard1!.runAction(shrinker)
                multiboard2!.runAction(shrinker)
                multiboard3!.runAction(shrinker)
                multiboard4!.runAction(shrinker)
                connectButton!.runAction(shrinker)
                newGameButton!.runAction(shrinker)
                mainmenubutton!.runAction(shrinker)
                
                if appDelegate.mpcHandler.session != nil  {
                    appDelegate.mpcHandler.setupBrowser()
                    appDelegate.mpcHandler.browser.delegate = self
                    self.presentViewController(appDelegate.mpcHandler.browser, animated: true, completion: nil)
                }
            }
            
            if result.node!.name!.hasPrefix("newgame") {
                sound1()
                if multiPlayerRulesOn == true {
                    menubutton!.runAction(expander)
                    menuinverse!.runAction(shrinker)
                    howtomultiButton!.runAction(shrinker)
                    connectButton!.runAction(shrinker)
                    newGameButton!.runAction(shrinker)
                    mainmenubutton!.runAction(shrinker)
                    multiboard1!.runAction(shrinker)
                    multiboard2!.runAction(shrinker)
                    multiboard3!.runAction(shrinker)
                    multiboard4!.runAction(shrinker)
                    boardMultiPlayer1Scene()
                    
                    let messageDict = ["string":"New Game"]
                    let messageData = try? NSJSONSerialization.dataWithJSONObject(messageDict, options: NSJSONWritingOptions.PrettyPrinted)
                    var error:NSError?
                    do {
                        try appDelegate.mpcHandler.session.sendData(messageData!, toPeers: appDelegate.mpcHandler.session.connectedPeers, withMode: MCSessionSendDataMode.Reliable)
                    }
                    catch let error1 as NSError {
                        error = error1
                    }
                    if error != nil {
                        print("error: \(error?.localizedDescription)")
                    }
                }
                    
                else if boardNumber == 1 { board1Scene() }
                else if boardNumber == 2 { board2Scene() }
                else if boardNumber == 3 { board3Scene() }
                else if boardNumber == 4 { board4Scene() }
                else if boardNumber == 5 { board5Scene() }
                else if boardNumber == 6 { board6Scene() }
                else if boardNumber == 7 { board7Scene() }
                else if boardNumber == 8 { board8Scene() }
                else if boardNumber == 9 { board9Scene() }
                else if boardNumber == 10 { board10Scene() }
                else if multiNumber == 1 { boardMultiPlayer1Scene() }
                else if multiNumber == 2 { boardMultiPlayer2Scene() }
                else if multiNumber == 3 { boardMultiPlayer3Scene() }
                else if multiNumber == 4 { boardMultiPlayer4Scene() }
            }
            
            if result.node!.name!.hasPrefix("mainmenubutton") {
                sound1()
                menubutton!.opacity = 1
                menuScene()
            }
            
            if result.node!.name!.hasPrefix("piece1") { piece1!.runAction(hitPiece); sound1() }
            if result.node!.name!.hasPrefix("piece2") { piece2!.runAction(hitPiece); sound1() }
            if result.node!.name!.hasPrefix("piece3") { piece3!.runAction(hitPiece); sound1() }
            if result.node!.name!.hasPrefix("piece4") { piece4!.runAction(hitPiece); sound1() }
            if result.node!.name!.hasPrefix("piece5") { piece5!.runAction(hitPiece); sound1() }
            
            if result.node!.name!.hasPrefix("title1") || result.node!.name!.hasPrefix("title2") || result.node!.name!.hasPrefix("title3") ||
                result.node!.name!.hasPrefix("title4") || result.node!.name!.hasPrefix("title5") { sound1()
                    backgroundcolor!.runAction(popIn); backgroundnormal!.runAction(popOut)
                    learncolor!.runAction(popIn); learnbutton!.runAction(popOut)
                    vsaicolor!.runAction(popIn); vsaibutton!.runAction(popOut)
                    peepscolor!.runAction(popIn); peepsbutton!.runAction(popOut)
                    soundcolor!.runAction(popIn); soundbutton!.runAction(popOut)
                    guidecolor!.runAction(popIn); guidebutton!.runAction(popOut)
                    title1color!.runAction(popIn); title1!.runAction(popOut)
                    title2color!.runAction(popIn); title2!.runAction(popOut)
                    title3color!.runAction(popIn); title3!.runAction(popOut)
                    title4color!.runAction(popIn); title4!.runAction(popOut)
                    title5color!.runAction(popIn); title5!.runAction(popOut)
            }
            
            if result.node!.name!.hasPrefix("title1color") || result.node!.name!.hasPrefix("title2color") || result.node!.name!.hasPrefix("title3color") ||
                result.node!.name!.hasPrefix("title4color") || result.node!.name!.hasPrefix("title5color") { sound1()
                    backgroundcolor!.runAction(popOut); backgroundnormal!.runAction(popIn)
                    learncolor!.runAction(popOut); learnbutton!.runAction(popIn)
                    vsaicolor!.runAction(popOut); vsaibutton!.runAction(popIn)
                    peepscolor!.runAction(popOut); peepsbutton!.runAction(popIn)
                    soundcolor!.runAction(popOut); soundbutton!.runAction(popIn)
                    guidecolor!.runAction(popOut); guidebutton!.runAction(popIn)
                    title1color!.runAction(popOut); title1!.runAction(popIn)
                    title2color!.runAction(popOut); title2!.runAction(popIn)
                    title3color!.runAction(popOut); title3!.runAction(popIn)
                    title4color!.runAction(popOut); title4!.runAction(popIn)
                    title5color!.runAction(popOut); title5!.runAction(popIn)
            }
            
            if result.node!.name!.hasPrefix("peepsbutton") || result.node!.name!.hasPrefix("peepscolor") { sound1(); boardMultiPlayer1Scene() }
            
            if result.node!.name!.hasPrefix("learnbutton") || result.node!.name!.hasPrefix("learncolor") { sound1(); teachingPart = 1; teachScene() }
            
            if result.node!.name!.hasPrefix("vsaibutton") || result.node!.name!.hasPrefix("vsaicolor") { sound1()
                vsaibutton!.runAction(SCNAction.fadeOutWithDuration(0.5)); vsaicolor!.runAction(SCNAction.fadeOutWithDuration(0.5))
                bean01!.runAction(SCNAction.sequence([waveWait1, openBeanLevel]))
                navyOpen = true
                if garbanzoOpen == true { bean02!.runAction(SCNAction.sequence([waveWait2, openBeanLevel])) }
                if soyOpen == true { bean03!.runAction(SCNAction.sequence([waveWait3, openBeanLevel])) }
                if adzukiOpen == true { bean04!.runAction(SCNAction.sequence([waveWait4,openBeanLevel])) }
                if pintoOpen == true { bean05!.runAction(SCNAction.sequence([waveWait5, openBeanLevel])) }
                if blackOpen == true { bean06!.runAction(SCNAction.sequence([waveWait6, openBeanLevel])) }
                if kidneyOpen == true { bean07!.runAction(SCNAction.sequence([waveWait7, openBeanLevel])) }
                if mungOpen == true { bean08!.runAction(SCNAction.sequence([waveWait8, openBeanLevel])) }
                if fabaOpen == true { bean09!.runAction(SCNAction.sequence([waveWait9, openBeanLevel])) }
                if coffeeOpen == true { bean10!.runAction(SCNAction.sequence([waveWait10, openBeanLevel])) }
            }
            
            if result.node!.name!.hasPrefix("bean01") { sound1(); board1Scene() }
            if result.node!.name!.hasPrefix("bean02") { sound1(); board2Scene() }
            if result.node!.name!.hasPrefix("bean03") { sound1(); board3Scene() }
            if result.node!.name!.hasPrefix("bean04") { sound1(); board4Scene() }
            if result.node!.name!.hasPrefix("bean05") { sound1(); board5Scene() }
            if result.node!.name!.hasPrefix("bean06") { sound1(); board6Scene() }
            if result.node!.name!.hasPrefix("bean07") { sound1(); board7Scene() }
            if result.node!.name!.hasPrefix("bean08") { sound1(); board8Scene() }
            if result.node!.name!.hasPrefix("bean09") { sound1(); board9Scene() }
            if result.node!.name!.hasPrefix("bean10") { sound1(); board10Scene() }
            
            if result.node!.name!.hasPrefix("soundbutton") || result.node!.name!.hasPrefix("soundcolor") { sound1()
                if sfxVol == 3 { sfxMid!.runAction(popWaitSlipOut) }
                else if sfxVol == 4 { sfxHi!.runAction(popWaitSlipOut) }
                else if sfxVol == 1 { sfxOff!.runAction(popWaitSlipOut) }
                else { sfxLo!.runAction(popWaitSlipOut) }
                
                if musicVol == 3 {  musicMid!.runAction(popWaitSlipOut) }
                else if musicVol == 4 { musicHi!.runAction(popWaitSlipOut) }
                else if musicVol == 1 { musicOff!.runAction(popWaitSlipOut) }
                else {  musicLo!.runAction(popWaitSlipOut) }
            }
            
            if result.node!.name!.hasPrefix("musichigh") { musicVol = 1; bgMusic!.volume = 0.00001; musicHi!.runAction(slipOut); musicOff!.runAction(popWaitSlipOut) }
            if result.node!.name!.hasPrefix("musicoff") { musicVol = 2; bgMusic!.volume = 0.01; musicOff!.runAction(slipOut); musicLo!.runAction(popWaitSlipOut) }
            if result.node!.name!.hasPrefix("musiclow") { musicVol = 3; bgMusic!.volume = 0.08; musicLo!.runAction(slipOut);  musicMid!.runAction(popWaitSlipOut) }
            if result.node!.name!.hasPrefix("musicmid") { musicVol = 4; bgMusic!.volume = 0.6; musicMid!.runAction(slipOut); musicHi!.runAction(popWaitSlipOut) }
            if result.node!.name!.hasPrefix("effectsvolmid") { sfxVol = 4; sound1(); sfxMid!.runAction(slipOut); sfxHi!.runAction(SCNAction.sequence([popWaitSlipOut])) }
            if result.node!.name!.hasPrefix("effectsvolhigh") { sfxVol = 1; sound1(); sfxHi!.runAction(slipOut); sfxOff!.runAction(SCNAction.sequence([popWaitSlipOut])) }
            if result.node!.name!.hasPrefix("effectsvoloff") { sfxVol = 2; sound1(); sfxOff!.runAction(slipOut); sfxLo!.runAction(SCNAction.sequence([popWaitSlipOut])) }
            if result.node!.name!.hasPrefix("effectsvollow") { sfxVol = 3; sound1(); sfxLo!.runAction(slipOut); sfxMid!.runAction(SCNAction.sequence([popWaitSlipOut])) }
            
            if result.node!.name!.hasPrefix("guidebutton") || result.node!.name!.hasPrefix("guidecolor") { sound1()
                if helpersOn == true { sound1()
                    guideson!.runAction(popWaitSlipOut)
                } else {
                    guidesoff!.runAction(popWaitSlipOut)
                }
            }
            
            if result.node!.name!.hasPrefix("guideson") { sound1()
                guidesoff!.runAction(popWaitSlipOut)
                guideson!.runAction(SCNAction.fadeOutWithDuration(0.001))
                guideson!.opacity = 0
                helpersOn = false
            }
            if result.node!.name!.hasPrefix("guidesoff") { sound1()
                guideson!.runAction(popWaitSlipOut)
                guidesoff!.opacity = 0
                helpersOn = true
            }
            
            if result.node!.name!.hasPrefix("dir01b") { sound1(); dir04b!.opacity = 1; dir01b!.opacity = 0 }
            if result.node!.name!.hasPrefix("dir04b") { sound1(); dir02b!.opacity = 1; dir04b!.opacity = 0 }
            if result.node!.name!.hasPrefix("dir02b") { sound1(); dir03b!.opacity = 1; dir02b!.opacity = 0; teachingPart += 1; teachScene() }
            if result.node!.name!.hasPrefix("dir03b") { sound1(); dir05b!.opacity = 1; dir03b!.opacity = 0 }
            if result.node!.name!.hasPrefix("dir05b") { sound1(); dir06b!.opacity = 1; dir05b!.opacity = 0 }
            if result.node!.name!.hasPrefix("dir06b") { sound1(); dir07b!.opacity = 1; dir06b!.opacity = 0 }
            if result.node!.name!.hasPrefix("dir07b") { sound1(); dir08b!.opacity = 1; dir07b!.opacity = 0; teachingPart += 1; teachScene() }
            if result.node!.name!.hasPrefix("dir08b") { sound1(); dir09b!.opacity = 1; dir08b!.opacity = 0 }
            if result.node!.name!.hasPrefix("dir09b") { sound1(); menuScene() }
            
            if result.node!.name!.hasPrefix("dirmulti") {
                sound1()
                dirmulti!.opacity = 0
            }
            
            //  Win/Lose Scene
            if result.node!.name!.hasPrefix("youlostpic") { selLoc = nil; sound1(); menuScene() }
            if result.node!.name!.hasPrefix("youlosttext") { selLoc = nil; sound1(); menuScene() }
            if result.node!.name!.hasPrefix("navytext") { sound1(); menuScene() }
            if result.node!.name!.hasPrefix("garbanzotext") { sound1(); menuScene() }
            if result.node!.name!.hasPrefix("soytext") { sound1(); menuScene() }
            if result.node!.name!.hasPrefix("adzukitext") { sound1(); menuScene() }
            if result.node!.name!.hasPrefix("pintotext") { sound1(); menuScene() }
            if result.node!.name!.hasPrefix("blacktext") { sound1(); menuScene() }
            if result.node!.name!.hasPrefix("kidneytext") { sound1(); menuScene() }
            if result.node!.name!.hasPrefix("mungtext") { sound1(); menuScene() }
            if result.node!.name!.hasPrefix("fabatext") { sound1(); menuScene() }
            if result.node!.name!.hasPrefix("coffeetext") { sound1(); menuScene() }
            if result.node!.name!.hasPrefix("adzukia") { moogSound(); adzukia!.runAction(popWinBeanA4); adzukib!.runAction(popWinBeanB4) }
            if result.node!.name!.hasPrefix("soya") { balalaikaSound(); soya!.runAction(popWinBeanA6); soyb!.runAction(popWinBeanB6) }
            if result.node!.name!.hasPrefix("garbanzoa") { didgeridooSound(); garbanzoa!.runAction(popWinBeanA2); garbanzob!.runAction(popWinBeanB2) }
            if result.node!.name!.hasPrefix("navya") { xylophoneSound(); navya!.runAction(popWinBeanA6); navyb!.runAction(popWinBeanB6) }
            if result.node!.name!.hasPrefix("pintoa") { accordianSound();  pintoa!.runAction(popWinBeanA4); pintob!.runAction(popWinBeanB4) }
            if result.node!.name!.hasPrefix("blacka") { glassharmonicaSound(); blacka!.runAction(popWinBeanA4); blackb!.runAction(popWinBeanB4); }
            if result.node!.name!.hasPrefix("kidneya") { zuesophoneSound(); kidneya!.runAction(popWinBeanA4); kidneyb!.runAction(popWinBeanB4) }
            if result.node!.name!.hasPrefix("munga") { trumpetSound();  munga!.runAction(popWinBeanA2); mungb!.runAction(popWinBeanB2) }
            if result.node!.name!.hasPrefix("fabaa") { organSound(); fabaa!.runAction(popWinBeanA4); fabab!.runAction(popWinBeanB4) }
            if result.node!.name!.hasPrefix("coffeea") { cowbellSound(); coffeea!.runAction(popWinBeanA2); coffeeb!.runAction(popWinBeanB2); }
            if result.node!.name!.hasPrefix("winlosetitle") { selLoc = nil; sound1(); menuScene() }
            
/////////////////////
//  SINGLE PLAYER  //
/////////////////////
            
            if multiPlayerRulesOn == false {
                if currentPlayer == "x" && staticPlayer == false {
                    if getTile(tapLoc) == .BluePiece || getTile(tapLoc) == .BlueBean {
                        sound1()
                        selLoc = tapLoc
                        if result.node!.name!.hasPrefix("Blue01") { selBall = 1 }
                        if result.node!.name!.hasPrefix("Blue02") { selBall = 2 }
                        if result.node!.name!.hasPrefix("Blue03") { selBall = 3 }
                        if result.node!.name!.hasPrefix("Blue04") { selBall = 4 }
                        if result.node!.name!.hasPrefix("Blue05") { selBall = 5 }
                        if result.node!.name!.hasPrefix("Blue04") { selBall = 4 }
                        if result.node!.name!.hasPrefix("Blue05") { selBall = 5 }
                        if result.node!.name!.hasPrefix("Blue06") { selBall = 6 }
                        if result.node!.name!.hasPrefix("Blue07") { selBall = 7 }
                        if result.node!.name!.hasPrefix("BlueBeanObject") { selBall = 10 }
                    }
                    
                    if getTile(tapLoc) != .BluePiece && getTile(tapLoc) != .BlueBean && selLoc == nil { return }
                    
                    // find possible moves
                    let rowCount = getRowCount(selLoc!)
                    let nLimit = getNLimit(selLoc!)
                    let sLimit = getSLimit(selLoc!)
                    let wLimit = getWLimit(selLoc!)
                    let eLimit = getELimit(selLoc!)
                    let nwLimit = getNWLimit(selLoc!)
                    let swLimit = getSWLimit(selLoc!)
                    let seLimit = getSELimit(selLoc!)
                    let neLimit = getNELimit(selLoc!)
                    
                    if tapLoc.y < selLoc!.y && tapLoc.x == selLoc!.x && selLoc!.x == nLimit.x && tapLoc.y < nLimit.y ||
                        tapLoc.y > selLoc!.y && tapLoc.x == selLoc!.x && selLoc!.x == sLimit.x && tapLoc.y > sLimit.y ||
                        tapLoc.y == selLoc!.y && tapLoc.x < selLoc!.x && tapLoc.x < wLimit.x && selLoc!.y == wLimit.y ||
                        tapLoc.y == selLoc!.y && tapLoc.x > selLoc!.x && tapLoc.x > eLimit.x && selLoc!.y == eLimit.y && selLoc != nil { return }
                    if tapLoc.x < selLoc!.x && tapLoc.y < selLoc!.y && tapLoc.x < nwLimit.x && tapLoc.y < nwLimit.y ||
                        tapLoc.x > selLoc!.x && tapLoc.y > selLoc!.y && tapLoc.x > seLimit.x && tapLoc.y > seLimit.y ||
                        tapLoc.x < selLoc!.x && tapLoc.y > selLoc!.y && tapLoc.x < swLimit.x && tapLoc.y > swLimit.y ||
                        tapLoc.x > selLoc!.x && tapLoc.y < selLoc!.y && tapLoc.x > neLimit.x && tapLoc.y < neLimit.y && selLoc != nil { return }
                    
                    if helpersOn == true {
                        
                        if rowCount == 1 && (boardArray[tapLoc.x][tapLoc.y] == .BluePiece || boardArray[tapLoc.x][tapLoc.y] == .BlueBean) {
                            posS!.runAction(getPosS1); posN!.runAction(getPosN1); posE!.runAction(getPosE1); posW!.runAction(getPosW1); posNE!.runAction(getPosNE1)
                            posNW!.runAction(getPosNW1); posSE!.runAction(getPosSE1); posSW!.runAction(getPosSW1); posW!.runAction(popPos); posE!.runAction(popPos)
                            if tapLoc.y - 1 > -1 && boardArray[tapLoc.x][tapLoc.y - 1] != .BluePiece && boardArray[tapLoc.x][tapLoc.y - 1] != .BlueBean { posN!.runAction(popPos) }
                            if tapLoc.y - 1 > -1 && tapLoc.x - 1 > -1 && boardArray[tapLoc.x - 1][tapLoc.y - 1] != .BluePiece && boardArray[tapLoc.x - 1][tapLoc.y - 1] != .BlueBean { posNW!.runAction(popPos) }
                            if boardNumber == 1 || boardNumber == 2 || boardNumber == 3 {
                                if tapLoc.y + 1 < 9 && boardArray[tapLoc.x][tapLoc.y + 1] != .BluePiece && boardArray[tapLoc.x][tapLoc.y + 1] != .BlueBean { posS!.runAction(popPos) }
                                if tapLoc.y + 1 < 9 && tapLoc.x + 1 < 5 && boardArray[tapLoc.x + 1][tapLoc.y + 1] != .BluePiece && boardArray[tapLoc.x + 1][tapLoc.y + 1] != .BlueBean { posSE!.runAction(popPos) }
                                if tapLoc.y + 1 < 9 && tapLoc.x - 1 > -1 && boardArray[tapLoc.x - 1][tapLoc.y + 1] != .BluePiece && boardArray[tapLoc.x - 1][tapLoc.y + 1] != .BlueBean { posSW!.runAction(popPos) }
                                if tapLoc.y - 1 > -1 && tapLoc.x + 1 < 5 && boardArray[tapLoc.x + 1][tapLoc.y - 1] != .BluePiece && boardArray[tapLoc.x + 1][tapLoc.y - 1] != .BlueBean { posNE!.runAction(popPos) } }
                            else if boardNumber == 4 || boardNumber == 5 || boardNumber == 6 || boardNumber == 7 {
                                if tapLoc.y + 1 < 13 && boardArray[tapLoc.x][tapLoc.y + 1] != .BluePiece && boardArray[tapLoc.x][tapLoc.y + 1] != .BlueBean { posS!.runAction(popPos) }
                                if tapLoc.y + 1 < 13 && tapLoc.x + 1 < 7 && boardArray[tapLoc.x + 1][tapLoc.y + 1] != .BluePiece && boardArray[tapLoc.x + 1][tapLoc.y + 1] != .BlueBean { posSE!.runAction(popPos) }
                                if tapLoc.y + 1 < 13 && tapLoc.x - 1 > -1 && boardArray[tapLoc.x - 1][tapLoc.y + 1] != .BluePiece && boardArray[tapLoc.x - 1][tapLoc.y + 1] != .BlueBean { posSW!.runAction(popPos) }
                                if tapLoc.y - 1 > -1 && tapLoc.x + 1 < 7 && boardArray[tapLoc.x + 1][tapLoc.y - 1] != .BluePiece && boardArray[tapLoc.x + 1][tapLoc.y - 1] != .BlueBean { posNE!.runAction(popPos) } }
                            else if boardNumber == 8 || boardNumber == 9 || boardNumber == 10 {
                                if tapLoc.y + 1 < 15 && boardArray[tapLoc.x][tapLoc.y + 1] != .BluePiece && boardArray[tapLoc.x][tapLoc.y + 1] != .BlueBean { posS!.runAction(popPos) }
                                if tapLoc.y + 1 < 15 && tapLoc.x + 1 < 9 && boardArray[tapLoc.x + 1][tapLoc.y + 1] != .BluePiece && boardArray[tapLoc.x + 1][tapLoc.y + 1] != .BlueBean { posSE!.runAction(popPos) }
                                if tapLoc.y + 1 < 15 && tapLoc.x - 1 > -1 && boardArray[tapLoc.x - 1][tapLoc.y + 1] != .BluePiece && boardArray[tapLoc.x - 1][tapLoc.y + 1] != .BlueBean { posSW!.runAction(popPos) }
                                if tapLoc.y - 1 > -1 && tapLoc.x + 1 < 9 && boardArray[tapLoc.x + 1][tapLoc.y - 1] != .BluePiece && boardArray[tapLoc.x + 1][tapLoc.y - 1] != .BlueBean { posNE!.runAction(popPos) } } }
                        if rowCount == 2 && (boardArray[tapLoc.x][tapLoc.y] == .BluePiece || boardArray[tapLoc.x][tapLoc.y] == .BlueBean) {
                            posN!.runAction(getPosN2); posS!.runAction(getPosS2); posE!.runAction(getPosE2); posW!.runAction(getPosW2)
                            posNE!.runAction(getPosNE2); posNW!.runAction(getPosNW2); posSE!.runAction(getPosSE2); posSW!.runAction(getPosSW2)
                            if tapLoc.y - 2 > -1 && (boardArray[tapLoc.x][tapLoc.y - 1] == .Empty || boardArray[tapLoc.x][tapLoc.y - 1] == .Bean) &&
                                boardArray[tapLoc.x][tapLoc.y - 2] != .BluePiece && boardArray[tapLoc.x][tapLoc.y - 2] != .BlueBean { posN!.runAction(popPos) }
                            if tapLoc.y - 2 > -1 && tapLoc.x - 2 > -1 && (boardArray[tapLoc.x - 1][tapLoc.y - 1] == .Empty || boardArray[tapLoc.x - 1][tapLoc.y - 1] == .Bean) &&
                                boardArray[tapLoc.x - 2][tapLoc.y - 2] != .BluePiece && boardArray[tapLoc.x - 2][tapLoc.y - 2] != .BlueBean { posNW!.runAction(popPos) }
                            if tapLoc.x - 2 > -1 && (boardArray[tapLoc.x - 1][tapLoc.y] == .Empty || boardArray[tapLoc.x - 1][tapLoc.y] == .Bean) &&
                                boardArray[tapLoc.x - 2][tapLoc.y] != .BluePiece && boardArray[tapLoc.x - 2][tapLoc.y] != .BlueBean { posW!.runAction(popPos) }
                            if boardNumber == 1 || boardNumber == 2 || boardNumber == 3 {
                                if tapLoc.y + 2 < 9 && (boardArray[tapLoc.x][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x][tapLoc.y + 1] == .Bean) &&
                                    boardArray[tapLoc.x][tapLoc.y + 2] != .BluePiece && boardArray[tapLoc.x][tapLoc.y + 2] != .BlueBean { posS!.runAction(popPos) }
                                if tapLoc.x + 2 < 5 && (boardArray[tapLoc.x + 1][tapLoc.y] == .Empty || boardArray[tapLoc.x + 1 ][tapLoc.y] == .Bean) &&
                                    boardArray[tapLoc.x + 2][tapLoc.y] != .BluePiece && boardArray[tapLoc.x + 2][tapLoc.y] != .BlueBean { posE!.runAction(popPos) }
                                if tapLoc.y - 2 > -1 && tapLoc.x + 2 < 5 && (boardArray[tapLoc.x + 1][tapLoc.y - 1] == .Empty || boardArray[tapLoc.x + 1 ][tapLoc.y - 1] == .Bean) &&
                                    boardArray[tapLoc.x + 2][tapLoc.y - 2] != .BluePiece && boardArray[tapLoc.x + 2][tapLoc.y - 2] != .BlueBean { posNE!.runAction(popPos) }
                                if tapLoc.y + 2 < 9 && tapLoc.x - 2 > -1 && (boardArray[tapLoc.x - 1][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x - 1 ][tapLoc.y + 1] == .Bean) &&
                                    boardArray[tapLoc.x - 2][tapLoc.y + 2] != .BluePiece && boardArray[tapLoc.x - 2][tapLoc.y + 2] != .BlueBean { posSW!.runAction(popPos) }
                                if tapLoc.y + 2 < 9 && tapLoc.x + 2 < 5 && (boardArray[tapLoc.x + 1][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x + 1 ][tapLoc.y + 1] == .Bean) &&
                                    boardArray[tapLoc.x + 2][tapLoc.y + 2] != .BluePiece && boardArray[tapLoc.x + 2][tapLoc.y + 2] != .BlueBean { posSE!.runAction(popPos) } }
                            else if boardNumber == 4 || boardNumber == 5 || boardNumber == 6 || boardNumber == 7 {
                                if tapLoc.y + 2 < 13 && (boardArray[tapLoc.x][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x][tapLoc.y + 1] == .Bean) &&
                                    boardArray[tapLoc.x][tapLoc.y + 2] != .BluePiece && boardArray[tapLoc.x][tapLoc.y + 2] != .BlueBean { posS!.runAction(popPos) }
                                if tapLoc.x + 2 < 7 && (boardArray[tapLoc.x + 1][tapLoc.y] == .Empty || boardArray[tapLoc.x + 1 ][tapLoc.y] == .Bean) &&
                                    boardArray[tapLoc.x + 2][tapLoc.y] != .BluePiece && boardArray[tapLoc.x + 2][tapLoc.y] != .BlueBean { posE!.runAction(popPos) }
                                if tapLoc.y - 2 > -1 && tapLoc.x + 2 < 7 && (boardArray[tapLoc.x + 1][tapLoc.y - 1] == .Empty || boardArray[tapLoc.x + 1 ][tapLoc.y - 1] == .Bean) &&
                                    boardArray[tapLoc.x + 2][tapLoc.y - 2] != .BluePiece && boardArray[tapLoc.x + 2][tapLoc.y - 2] != .BlueBean { posNE!.runAction(popPos) }
                                if tapLoc.y + 2 < 13 && tapLoc.x - 2 > -1 && (boardArray[tapLoc.x - 1][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x - 1 ][tapLoc.y + 1] == .Bean) &&
                                    boardArray[tapLoc.x - 2][tapLoc.y + 2] != .BluePiece && boardArray[tapLoc.x - 2][tapLoc.y + 2] != .BlueBean { posSW!.runAction(popPos) }
                                if tapLoc.y + 2 < 13 && tapLoc.x + 2 < 7 && (boardArray[tapLoc.x + 1][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x + 1 ][tapLoc.y + 1] == .Bean) &&
                                    boardArray[tapLoc.x + 2][tapLoc.y + 2] != .BluePiece && boardArray[tapLoc.x + 2][tapLoc.y + 2] != .BlueBean { posSE!.runAction(popPos) } }
                            else if boardNumber == 8 || boardNumber == 9 || boardNumber == 10 {
                                if tapLoc.y + 2 < 15 && (boardArray[tapLoc.x][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x][tapLoc.y + 1] == .Bean) &&
                                    boardArray[tapLoc.x][tapLoc.y + 2] != .BluePiece && boardArray[tapLoc.x][tapLoc.y + 2] != .BlueBean { posS!.runAction(popPos) }
                                if tapLoc.x + 2 < 9 && (boardArray[tapLoc.x + 1][tapLoc.y] == .Empty || boardArray[tapLoc.x + 1 ][tapLoc.y] == .Bean) &&
                                    boardArray[tapLoc.x + 2][tapLoc.y] != .BluePiece && boardArray[tapLoc.x + 2][tapLoc.y] != .BlueBean { posE!.runAction(popPos) }
                                if tapLoc.y - 2 > -1 && tapLoc.x + 2 < 9 && (boardArray[tapLoc.x + 1][tapLoc.y - 1] == .Empty || boardArray[tapLoc.x + 1 ][tapLoc.y - 1] == .Bean) &&
                                    boardArray[tapLoc.x + 2][tapLoc.y - 2] != .BluePiece && boardArray[tapLoc.x + 2][tapLoc.y - 2] != .BlueBean { posNE!.runAction(popPos) }
                                if tapLoc.y + 2 < 15 && tapLoc.x - 2 > -1 && (boardArray[tapLoc.x - 1][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x - 1 ][tapLoc.y + 1] == .Bean) &&
                                    boardArray[tapLoc.x - 2][tapLoc.y + 2] != .BluePiece && boardArray[tapLoc.x - 2][tapLoc.y + 2] != .BlueBean { posSW!.runAction(popPos) }
                                if tapLoc.y + 2 < 15 && tapLoc.x + 2 < 9 && (boardArray[tapLoc.x + 1][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x + 1 ][tapLoc.y + 1] == .Bean) &&
                                    boardArray[tapLoc.x + 2][tapLoc.y + 2] != .BluePiece && boardArray[tapLoc.x + 2][tapLoc.y + 2] != .BlueBean { posSE!.runAction(popPos) } } }
                        if rowCount == 3 && (boardArray[tapLoc.x][tapLoc.y] == .BluePiece || boardArray[tapLoc.x][tapLoc.y] == .BlueBean) {
                            posN!.runAction(getPosN3); posS!.runAction(getPosS3); posE!.runAction(getPosE3); posW!.runAction(getPosW3)
                            posNE!.runAction(getPosNE3); posNW!.runAction(getPosNW3); posSE!.runAction(getPosSE3); posSW!.runAction(getPosSW3)
                            if tapLoc.y - 3 > -1 && (boardArray[tapLoc.x][tapLoc.y - 1] == .Empty || boardArray[tapLoc.x][tapLoc.y - 1] == .Bean) &&
                                (boardArray[tapLoc.x][tapLoc.y - 2] == .Empty || boardArray[tapLoc.x][tapLoc.y - 2] == .Bean) &&
                                boardArray[tapLoc.x][tapLoc.y - 3] != .BluePiece && boardArray[tapLoc.x][tapLoc.y - 3] != .BlueBean { posN!.runAction(popPos) }
                            if tapLoc.y - 3 > -1 && tapLoc.x - 3 > -1 && (boardArray[tapLoc.x - 1][tapLoc.y - 1] == .Empty || boardArray[tapLoc.x - 1][tapLoc.y - 1] == .Bean) &&
                                (boardArray[tapLoc.x - 2][tapLoc.y - 2] == .Empty || boardArray[tapLoc.x - 2][tapLoc.y - 2] == .Bean) &&
                                boardArray[tapLoc.x - 3][tapLoc.y - 3] != .BluePiece && boardArray[tapLoc.x - 3][tapLoc.y - 3] != .BlueBean { posNW!.runAction(popPos) }
                            if tapLoc.x - 3 > -1 && (boardArray[tapLoc.x - 1][tapLoc.y] == .Empty || boardArray[tapLoc.x - 1][tapLoc.y] == .Bean) &&
                                (boardArray[tapLoc.x - 2][tapLoc.y] == .Empty || boardArray[tapLoc.x - 2][tapLoc.y] == .Bean) &&
                                boardArray[tapLoc.x - 3][tapLoc.y] != .BluePiece && boardArray[tapLoc.x - 3][tapLoc.y] != .BlueBean { posW!.runAction(popPos) }
                            if boardNumber == 1 || boardNumber == 2 || boardNumber == 3 {
                                if tapLoc.y + 3 < 9 && (boardArray[tapLoc.x][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x][tapLoc.y + 1] == .Bean) &&
                                    (boardArray[tapLoc.x][tapLoc.y + 2] == .Empty || boardArray[tapLoc.x][tapLoc.y + 2] == .Bean) &&
                                    boardArray[tapLoc.x][tapLoc.y + 3] != .BluePiece && boardArray[tapLoc.x][tapLoc.y + 3] != .BlueBean { posS!.runAction(popPos) }
                                if tapLoc.x + 3 < 5 && (boardArray[tapLoc.x + 1][tapLoc.y] == .Empty || boardArray[tapLoc.x + 1][tapLoc.y] == .Bean) &&
                                    (boardArray[tapLoc.x + 2][tapLoc.y] == .Empty || boardArray[tapLoc.x + 2][tapLoc.y] == .Bean) &&
                                    boardArray[tapLoc.x + 3][tapLoc.y] != .BluePiece && boardArray[tapLoc.x + 3][tapLoc.y] != .BlueBean { posE!.runAction(popPos) }
                                if tapLoc.y - 3 > -1 && tapLoc.x + 3 < 5 && (boardArray[tapLoc.x + 1][tapLoc.y - 1] == .Empty || boardArray[tapLoc.x + 1 ][tapLoc.y - 1] == .Bean) &&
                                    (boardArray[tapLoc.x + 2][tapLoc.y - 2] == .Empty || boardArray[tapLoc.x + 2][tapLoc.y - 2] == .Bean) &&
                                    boardArray[tapLoc.x + 3][tapLoc.y - 3] != .BluePiece && boardArray[tapLoc.x + 3][tapLoc.y - 3] != .BlueBean { posNE!.runAction(popPos) }
                                if tapLoc.y + 3 < 9 && tapLoc.x - 3 > -1 && (boardArray[tapLoc.x - 1][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x - 1 ][tapLoc.y + 1] == .Bean) &&
                                    (boardArray[tapLoc.x - 2][tapLoc.y + 2] == .Empty || boardArray[tapLoc.x - 2][tapLoc.y + 2] == .Bean) &&
                                    boardArray[tapLoc.x - 3][tapLoc.y + 3] != .BluePiece && boardArray[tapLoc.x - 3][tapLoc.y + 3] != .BlueBean { posSW!.runAction(popPos) }
                                if tapLoc.y + 3 < 9 && tapLoc.x + 3 < 5 && (boardArray[tapLoc.x + 1][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x + 1 ][tapLoc.y + 1] == .Bean) &&
                                    (boardArray[tapLoc.x + 2][tapLoc.y + 2] == .Empty || boardArray[tapLoc.x + 2][tapLoc.y + 2] == .Bean) &&
                                    boardArray[tapLoc.x + 3][tapLoc.y + 3] != .BluePiece && boardArray[tapLoc.x + 3][tapLoc.y + 3] != .BlueBean { posSE!.runAction(popPos) } }
                            else if boardNumber == 4 || boardNumber == 5 || boardNumber == 6 || boardNumber == 7 {
                                if tapLoc.y + 3 < 13 && (boardArray[tapLoc.x][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x][tapLoc.y + 1] == .Bean) &&
                                    (boardArray[tapLoc.x][tapLoc.y + 2] == .Empty || boardArray[tapLoc.x][tapLoc.y + 2] == .Bean) &&
                                    boardArray[tapLoc.x][tapLoc.y + 3] != .BluePiece && boardArray[tapLoc.x][tapLoc.y + 3] != .BlueBean { posS!.runAction(popPos) }
                                if tapLoc.x + 3 < 7 && (boardArray[tapLoc.x + 1][tapLoc.y] == .Empty || boardArray[tapLoc.x + 1][tapLoc.y] == .Bean) &&
                                    (boardArray[tapLoc.x + 2][tapLoc.y] == .Empty || boardArray[tapLoc.x + 2][tapLoc.y] == .Bean) &&
                                    boardArray[tapLoc.x + 3][tapLoc.y] != .BluePiece && boardArray[tapLoc.x + 3][tapLoc.y] != .BlueBean { posE!.runAction(popPos) }
                                if tapLoc.y - 3 > -1 && tapLoc.x + 3 < 7 && (boardArray[tapLoc.x + 1][tapLoc.y - 1] == .Empty || boardArray[tapLoc.x + 1 ][tapLoc.y - 1] == .Bean) &&
                                    (boardArray[tapLoc.x + 2][tapLoc.y - 2] == .Empty || boardArray[tapLoc.x + 2][tapLoc.y - 2] == .Bean) &&
                                    boardArray[tapLoc.x + 3][tapLoc.y - 3] != .BluePiece && boardArray[tapLoc.x + 3][tapLoc.y - 3] != .BlueBean { posNE!.runAction(popPos) }
                                if tapLoc.y + 3 < 13 && tapLoc.x - 3 > -1 && (boardArray[tapLoc.x - 1][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x - 1 ][tapLoc.y + 1] == .Bean) &&
                                    (boardArray[tapLoc.x - 2][tapLoc.y + 2] == .Empty || boardArray[tapLoc.x - 2][tapLoc.y + 2] == .Bean) &&
                                    boardArray[tapLoc.x - 3][tapLoc.y + 3] != .BluePiece && boardArray[tapLoc.x - 3][tapLoc.y + 3] != .BlueBean { posSW!.runAction(popPos) }
                                if tapLoc.y + 3 < 13 && tapLoc.x + 3 < 7 && (boardArray[tapLoc.x + 1][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x + 1 ][tapLoc.y + 1] == .Bean) &&
                                    (boardArray[tapLoc.x + 2][tapLoc.y + 2] == .Empty || boardArray[tapLoc.x + 2][tapLoc.y + 2] == .Bean) &&
                                    boardArray[tapLoc.x + 3][tapLoc.y + 3] != .BluePiece && boardArray[tapLoc.x + 3][tapLoc.y + 3] != .BlueBean { posSE!.runAction(popPos) } }
                            else if boardNumber == 8 || boardNumber == 9 || boardNumber == 10 {
                                if tapLoc.y + 3 < 15 && (boardArray[tapLoc.x][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x][tapLoc.y + 1] == .Bean) &&
                                    (boardArray[tapLoc.x][tapLoc.y + 2] == .Empty || boardArray[tapLoc.x][tapLoc.y + 2] == .Bean) &&
                                    boardArray[tapLoc.x][tapLoc.y + 3] != .BluePiece && boardArray[tapLoc.x][tapLoc.y + 3] != .BlueBean { posS!.runAction(popPos) }
                                if tapLoc.x + 3 < 9 && (boardArray[tapLoc.x + 1][tapLoc.y] == .Empty || boardArray[tapLoc.x + 1][tapLoc.y] == .Bean) &&
                                    (boardArray[tapLoc.x + 2][tapLoc.y] == .Empty || boardArray[tapLoc.x + 2][tapLoc.y] == .Bean) &&
                                    boardArray[tapLoc.x + 3][tapLoc.y] != .BluePiece && boardArray[tapLoc.x + 3][tapLoc.y] != .BlueBean { posE!.runAction(popPos) }
                                if tapLoc.y - 3 > -1 && tapLoc.x + 3 < 9 && (boardArray[tapLoc.x + 1][tapLoc.y - 1] == .Empty || boardArray[tapLoc.x + 1 ][tapLoc.y - 1] == .Bean) &&
                                    (boardArray[tapLoc.x + 2][tapLoc.y - 2] == .Empty || boardArray[tapLoc.x + 2][tapLoc.y - 2] == .Bean) &&
                                    boardArray[tapLoc.x + 3][tapLoc.y - 3] != .BluePiece && boardArray[tapLoc.x + 3][tapLoc.y - 3] != .BlueBean { posNE!.runAction(popPos) }
                                if tapLoc.y + 3 < 15 && tapLoc.x - 3 > -1 && (boardArray[tapLoc.x - 1][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x - 1 ][tapLoc.y + 1] == .Bean) &&
                                    (boardArray[tapLoc.x - 2][tapLoc.y + 2] == .Empty || boardArray[tapLoc.x - 2][tapLoc.y + 2] == .Bean) &&
                                    boardArray[tapLoc.x - 3][tapLoc.y + 3] != .BluePiece && boardArray[tapLoc.x - 3][tapLoc.y + 3] != .BlueBean { posSW!.runAction(popPos) }
                                if tapLoc.y + 3 < 15 && tapLoc.x + 3 < 9 && (boardArray[tapLoc.x + 1][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x + 1 ][tapLoc.y + 1] == .Bean) &&
                                    (boardArray[tapLoc.x + 2][tapLoc.y + 2] == .Empty || boardArray[tapLoc.x + 2][tapLoc.y + 2] == .Bean) &&
                                    boardArray[tapLoc.x + 3][tapLoc.y + 3] != .BluePiece && boardArray[tapLoc.x + 3][tapLoc.y + 3] != .BlueBean { posSE!.runAction(popPos) } } }
                        if rowCount >= 4 && (boardArray[tapLoc.x][tapLoc.y] == .BluePiece || boardArray[tapLoc.x][tapLoc.y] == .BlueBean) {
                            arrowposN!.runAction(getPosN3); arrowposS!.runAction(getPosS3); arrowposE!.runAction(getPosE3); arrowposW!.runAction(getPosW3)
                            arrowposNE!.runAction(getPosNE3); arrowposNW!.runAction(getPosNW3); arrowposSE!.runAction(getPosSE3); arrowposSW!.runAction(getPosSW3)
                            if tapLoc.y - 3 > -1 && (boardArray[tapLoc.x][tapLoc.y - 1] == .Empty || boardArray[tapLoc.x][tapLoc.y - 1] == .Bean) &&
                                (boardArray[tapLoc.x][tapLoc.y - 2] == .Empty || boardArray[tapLoc.x][tapLoc.y - 2] == .Bean) &&
                                boardArray[tapLoc.x][tapLoc.y - 3] != .BluePiece && boardArray[tapLoc.x][tapLoc.y - 3] != .BlueBean { posN!.runAction(popPos) }
                            if tapLoc.y - 3 > -1 && tapLoc.x - 3 > -1 && (boardArray[tapLoc.x - 1][tapLoc.y - 1] == .Empty || boardArray[tapLoc.x - 1][tapLoc.y - 1] == .Bean) &&
                                (boardArray[tapLoc.x - 2][tapLoc.y - 2] == .Empty || boardArray[tapLoc.x - 2][tapLoc.y - 2] == .Bean) &&
                                boardArray[tapLoc.x - 3][tapLoc.y - 3] != .BluePiece && boardArray[tapLoc.x - 3][tapLoc.y - 3] != .BlueBean { posNW!.runAction(popPos) }
                            if tapLoc.x - 3 > -1 && (boardArray[tapLoc.x - 1][tapLoc.y] == .Empty || boardArray[tapLoc.x - 1][tapLoc.y] == .Bean) &&
                                (boardArray[tapLoc.x - 2][tapLoc.y] == .Empty || boardArray[tapLoc.x - 2][tapLoc.y] == .Bean) &&
                                boardArray[tapLoc.x - 3][tapLoc.y] != .BluePiece && boardArray[tapLoc.x - 3][tapLoc.y] != .BlueBean { posW!.runAction(popPos) }
                            if boardNumber == 1 || boardNumber == 2 || boardNumber == 3 {
                                if tapLoc.y + 3 < 9 && (boardArray[tapLoc.x][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x][tapLoc.y + 1] == .Bean) &&
                                    (boardArray[tapLoc.x][tapLoc.y + 2] == .Empty || boardArray[tapLoc.x][tapLoc.y + 2] == .Bean) &&
                                    boardArray[tapLoc.x][tapLoc.y + 3] != .BluePiece && boardArray[tapLoc.x][tapLoc.y + 3] != .BlueBean { posS!.runAction(popPos) }
                                if tapLoc.x + 3 < 5 && (boardArray[tapLoc.x + 1][tapLoc.y] == .Empty || boardArray[tapLoc.x + 1][tapLoc.y] == .Bean) &&
                                    (boardArray[tapLoc.x + 2][tapLoc.y] == .Empty || boardArray[tapLoc.x + 2][tapLoc.y] == .Bean) &&
                                    boardArray[tapLoc.x + 3][tapLoc.y] != .BluePiece && boardArray[tapLoc.x + 3][tapLoc.y] != .BlueBean { posE!.runAction(popPos) }
                                if tapLoc.y - 3 > -1 && tapLoc.x + 3 < 5 && (boardArray[tapLoc.x + 1][tapLoc.y - 1] == .Empty || boardArray[tapLoc.x + 1 ][tapLoc.y - 1] == .Bean) &&
                                    (boardArray[tapLoc.x + 2][tapLoc.y - 2] == .Empty || boardArray[tapLoc.x + 2][tapLoc.y - 2] == .Bean) &&
                                    boardArray[tapLoc.x + 3][tapLoc.y - 3] != .BluePiece && boardArray[tapLoc.x + 3][tapLoc.y - 3] != .BlueBean { posNE!.runAction(popPos) }
                                if tapLoc.y + 3 < 9 && tapLoc.x - 3 > -1 && (boardArray[tapLoc.x - 1][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x - 1 ][tapLoc.y + 1] == .Bean) &&
                                    (boardArray[tapLoc.x - 2][tapLoc.y + 2] == .Empty || boardArray[tapLoc.x - 2][tapLoc.y + 2] == .Bean) &&
                                    boardArray[tapLoc.x - 3][tapLoc.y + 3] != .BluePiece && boardArray[tapLoc.x - 3][tapLoc.y + 3] != .BlueBean { posSW!.runAction(popPos) }
                                if tapLoc.y + 3 < 9 && tapLoc.x + 3 < 5 && (boardArray[tapLoc.x + 1][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x + 1 ][tapLoc.y + 1] == .Bean) &&
                                    (boardArray[tapLoc.x + 2][tapLoc.y + 2] == .Empty || boardArray[tapLoc.x + 2][tapLoc.y + 2] == .Bean) &&
                                    boardArray[tapLoc.x + 3][tapLoc.y + 3] != .BluePiece && boardArray[tapLoc.x + 3][tapLoc.y + 3] != .BlueBean { posSE!.runAction(popPos) } }
                            else if boardNumber == 4 || boardNumber == 5 || boardNumber == 6 || boardNumber == 7 {
                                if tapLoc.y + 3 < 13 && (boardArray[tapLoc.x][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x][tapLoc.y + 1] == .Bean) &&
                                    (boardArray[tapLoc.x][tapLoc.y + 2] == .Empty || boardArray[tapLoc.x][tapLoc.y + 2] == .Bean) &&
                                    boardArray[tapLoc.x][tapLoc.y + 3] != .BluePiece && boardArray[tapLoc.x][tapLoc.y + 3] != .BlueBean { posS!.runAction(popPos) }
                                if tapLoc.x + 3 < 7 && (boardArray[tapLoc.x + 1][tapLoc.y] == .Empty || boardArray[tapLoc.x + 1][tapLoc.y] == .Bean) &&
                                    (boardArray[tapLoc.x + 2][tapLoc.y] == .Empty || boardArray[tapLoc.x + 2][tapLoc.y] == .Bean) &&
                                    boardArray[tapLoc.x + 3][tapLoc.y] != .BluePiece && boardArray[tapLoc.x + 3][tapLoc.y] != .BlueBean { posE!.runAction(popPos) }
                                if tapLoc.y - 3 > -1 && tapLoc.x + 3 < 7 && (boardArray[tapLoc.x + 1][tapLoc.y - 1] == .Empty || boardArray[tapLoc.x + 1 ][tapLoc.y - 1] == .Bean) &&
                                    (boardArray[tapLoc.x + 2][tapLoc.y - 2] == .Empty || boardArray[tapLoc.x + 2][tapLoc.y - 2] == .Bean) &&
                                    boardArray[tapLoc.x + 3][tapLoc.y - 3] != .BluePiece && boardArray[tapLoc.x + 3][tapLoc.y - 3] != .BlueBean { posNE!.runAction(popPos) }
                                if tapLoc.y + 3 < 13 && tapLoc.x - 3 > -1 && (boardArray[tapLoc.x - 1][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x - 1 ][tapLoc.y + 1] == .Bean) &&
                                    (boardArray[tapLoc.x - 2][tapLoc.y + 2] == .Empty || boardArray[tapLoc.x - 2][tapLoc.y + 2] == .Bean) &&
                                    boardArray[tapLoc.x - 3][tapLoc.y + 3] != .BluePiece && boardArray[tapLoc.x - 3][tapLoc.y + 3] != .BlueBean { posSW!.runAction(popPos) }
                                if tapLoc.y + 3 < 13 && tapLoc.x + 3 < 7 && (boardArray[tapLoc.x + 1][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x + 1 ][tapLoc.y + 1] == .Bean) &&
                                    (boardArray[tapLoc.x + 2][tapLoc.y + 2] == .Empty || boardArray[tapLoc.x + 2][tapLoc.y + 2] == .Bean) &&
                                    boardArray[tapLoc.x + 3][tapLoc.y + 3] != .BluePiece && boardArray[tapLoc.x + 3][tapLoc.y + 3] != .BlueBean { posSE!.runAction(popPos) } }
                            else if boardNumber == 8 || boardNumber == 9  || boardNumber == 10 {
                                if tapLoc.y + 3 < 15 && (boardArray[tapLoc.x][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x][tapLoc.y + 1] == .Bean) &&
                                    (boardArray[tapLoc.x][tapLoc.y + 2] == .Empty || boardArray[tapLoc.x][tapLoc.y + 2] == .Bean) &&
                                    boardArray[tapLoc.x][tapLoc.y + 3] != .BluePiece && boardArray[tapLoc.x][tapLoc.y + 3] != .BlueBean { posS!.runAction(popPos) }
                                if tapLoc.x + 3 < 9 && (boardArray[tapLoc.x + 1][tapLoc.y] == .Empty || boardArray[tapLoc.x + 1][tapLoc.y] == .Bean) &&
                                    (boardArray[tapLoc.x + 2][tapLoc.y] == .Empty || boardArray[tapLoc.x + 2][tapLoc.y] == .Bean) &&
                                    boardArray[tapLoc.x + 3][tapLoc.y] != .BluePiece && boardArray[tapLoc.x + 3][tapLoc.y] != .BlueBean { posE!.runAction(popPos) }
                                if tapLoc.y - 3 > -1 && tapLoc.x + 3 < 9 && (boardArray[tapLoc.x + 1][tapLoc.y - 1] == .Empty || boardArray[tapLoc.x + 1 ][tapLoc.y - 1] == .Bean) &&
                                    (boardArray[tapLoc.x + 2][tapLoc.y - 2] == .Empty || boardArray[tapLoc.x + 2][tapLoc.y - 2] == .Bean) &&
                                    boardArray[tapLoc.x + 3][tapLoc.y - 3] != .BluePiece && boardArray[tapLoc.x + 3][tapLoc.y - 3] != .BlueBean { posNE!.runAction(popPos) }
                                if tapLoc.y + 3 < 15 && tapLoc.x - 3 > -1 && (boardArray[tapLoc.x - 1][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x - 1 ][tapLoc.y + 1] == .Bean) &&
                                    (boardArray[tapLoc.x - 2][tapLoc.y + 2] == .Empty || boardArray[tapLoc.x - 2][tapLoc.y + 2] == .Bean) &&
                                    boardArray[tapLoc.x - 3][tapLoc.y + 3] != .BluePiece && boardArray[tapLoc.x - 3][tapLoc.y + 3] != .BlueBean { posSW!.runAction(popPos) }
                                if tapLoc.y + 3 < 15 && tapLoc.x + 3 < 9 && (boardArray[tapLoc.x + 1][tapLoc.y + 1] == .Empty || boardArray[tapLoc.x + 1 ][tapLoc.y + 1] == .Bean) &&
                                    (boardArray[tapLoc.x + 2][tapLoc.y + 2] == .Empty || boardArray[tapLoc.x + 2][tapLoc.y + 2] == .Bean) &&
                                    boardArray[tapLoc.x + 3][tapLoc.y + 3] != .BluePiece && boardArray[tapLoc.x + 3][tapLoc.y + 3] != .BlueBean { posSE!.runAction(popPos) }
                            }
                        }
                    }
                    
                    let vert = abs(tapLoc.x - selLoc!.x)
                    let horiz = abs(tapLoc.y - selLoc!.y)
                    if vert == 0 && horiz == rowCount || vert == rowCount && horiz == 0 || vert == rowCount && horiz == rowCount {
                        
                        if getTile(tapLoc) == .Empty {
                            sound1()
                            movePiece(selLoc!, tapLoc)
                            switch selBall {
                            case 1: blue1!.runAction(movePlayer); blue1!.position.x = locX; blue1!.position.y = locY
                            case 2: blue2!.runAction(movePlayer); blue2!.position.x = locX; blue2!.position.y = locY
                            case 3: blue3!.runAction(movePlayer); blue3!.position.x = locX; blue3!.position.y = locY
                            case 4: blue4!.runAction(movePlayer); blue4!.position.x = locX; blue4!.position.y = locY
                            case 5: blue5!.runAction(movePlayer); blue5!.position.x = locX; blue5!.position.y = locY
                            case 6: blue6!.runAction(movePlayer); blue6!.position.x = locX; blue6!.position.y = locY
                            case 7: blue7!.runAction(movePlayer); blue7!.position.x = locX; blue7!.position.y = locY
                            case 10: blueBean!.runAction(movePlayer); blueBean!.position.x = locX; blueBean!.position.y = locY
                            default: print("default") }
                        }
                        
                        if getTile(tapLoc) == .Bean {
                            sound1()
                            blueBeanActive = true
                            getBlueBean(selLoc!, tapLoc)
                            newbean!.runAction(takeOff)
                            switch selBall {
                            case 1: blue1!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 2: blue2!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 3: blue3!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 4: blue4!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 5: blue5!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 6: blue6!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 7: blue7!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            default: print("default") }
                            
                            blueHome!.opacity = 1
                            blueHomeEffect!.runAction(popHome)
                        }
                        
                        if getTile(tapLoc) == .RedPiece {
                            sound1()
                            redCaptured -= 1
                            movePiece(selLoc!, tapLoc)
                            switch selBall {
                            case 1: blue1!.runAction(movePlayer)
                            case 2: blue2!.runAction(movePlayer)
                            case 3: blue3!.runAction(movePlayer)
                            case 4: blue4!.runAction(movePlayer)
                            case 5: blue5!.runAction(movePlayer)
                            case 6: blue6!.runAction(movePlayer)
                            case 7: blue7!.runAction(movePlayer)
                            case 10: blueBean!.runAction(movePlayer)
                            default: print("default") }
                            
                            if locX == red1!.position.x && locY == red1!.position.y { red1!.runAction(takeOff) }
                            else if locX == red2!.position.x && locY == red2!.position.y { red2!.runAction(takeOff) }
                            else if locX == red3!.position.x && locY == red3!.position.y { red3!.runAction(takeOff) }
                            else if locX == red4!.position.x && locY == red4!.position.y { red4!.runAction(takeOff) }
                            else if locX == red5!.position.x && locY == red5!.position.y { red5!.runAction(takeOff) }
                            else if locX == red6!.position.x && locY == red6!.position.y { red6!.runAction(takeOff) }
                            else if locX == red7!.position.x && locY == red7!.position.y { red7!.runAction(takeOff) }
                        }
                        
                        if getTile(tapLoc) == .RedBean {
                            sound1()
                            redCaptured -= 1
                            blueBeanActive = true
                            blueHomeEffect!.runAction(popHome)
                            redBeanActive = false
                            getBlueBean(selLoc!, tapLoc)
                            switch selBall {
                            case 1: blue1!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 2: blue2!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 3: blue3!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 4: blue4!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 5: blue5!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 6: blue6!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 7: blue7!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            default: print("default") }
                            
                            redBean!.runAction(takeOff)
                            blueBean!.opacity = 1.0
                            
                            if locX == red1!.position.x && locY == red1!.position.y { red1!.runAction(takeOff) }
                            else if locX == red2!.position.x && locY == red2!.position.y { red2!.runAction(takeOff) }
                            else if locX == red3!.position.x && locY == red3!.position.y { red3!.runAction(takeOff) }
                            else if locX == red4!.position.x && locY == red4!.position.y { red4!.runAction(takeOff) }
                            else if locX == red5!.position.x && locY == red5!.position.y { red5!.runAction(takeOff) }
                            else if locX == red6!.position.x && locY == red6!.position.y { red6!.runAction(takeOff) }
                            else if locX == red7!.position.x && locY == red7!.position.y { red7!.runAction(takeOff) }
                            
                            blueHome!.opacity = 1
                            redHome!.opacity = 0
                        }
                        
                        if teachingPart != 1 && teachingPart != 3 {
                            staticPlayer = true
                        }
                        
                        switch boardNumber {
                        case 0 :
                            if boardArray[2][8] == .BlueBean {
                                sound1()
                                if teachingPart == 3 {
                                    menuScene()
                                }
                                else {
                                    staticAI = true
                                    waitThenWin()
                                }
                            }
                        case 1, 2, 3:
                            if boardArray[2][7] == .BlueBean {
                                sound1()
                                if teachingPart == 3 {
                                    menuScene()
                                }
                                else {
                                    staticAI = true
                                    waitThenWin()
                                }
                            }
                        case 4, 5, 6, 7:
                            if boardArray[3][11] == .BlueBean {
                                sound1()
                                if teachingPart == 3 {
                                    menuScene()
                                }
                                else {
                                    staticAI = true
                                    waitThenWin()
                                }
                            }
                        case 8, 9, 10:
                            if boardArray[4][12] == .BlueBean {
                                sound1()
                                if teachingPart == 3 {
                                    menuScene()
                                }
                                else {
                                    staticAI = true
                                    waitThenWin()
                                }
                            }
                        default: print("boardNumber is not 1-10.")
                        }
                        
                        selLoc = nil
                        
                        yellow!.runAction(takeOff)
                        posN!.runAction(takeOff)
                        posS!.runAction(takeOff)
                        posE!.runAction(takeOff)
                        posW!.runAction(takeOff)
                        posNE!.runAction(takeOff)
                        posNW!.runAction(takeOff)
                        posSE!.runAction(takeOff)
                        posSW!.runAction(takeOff)
                        arrowposN!.runAction(takeOff)
                        arrowposS!.runAction(takeOff)
                        arrowposE!.runAction(takeOff)
                        arrowposW!.runAction(takeOff)
                        arrowposNE!.runAction(takeOff)
                        arrowposNW!.runAction(takeOff)
                        arrowposSE!.runAction(takeOff)
                        arrowposSW!.runAction(takeOff)

                        if redCaptured == 0 {
                            if teachingPart == 2 {
                                teachScene()
                            }
                            else {
                                staticAI = true
                                waitThenWin()
                            }
                        }
                        
                        if staticAI == false {
        
                            let randomWaitUntilMove = arc4random() % UInt32(3)
                            if randomWaitUntilMove == 0 {
                                waitThenMove()
                            } else if randomWaitUntilMove == 1 {
                                waitThenMoveShorter()
                            }
                            else if randomWaitUntilMove == 2 {
                                waitThenMoveLonger()
                            }
                            else if randomWaitUntilMove == 3 {
                                waitThenMoveShorter()
                            }
                            print("When back from moveAI, blueCaptured = \(blueCaptured)")
                            
                            if blueCaptured == 0 {
                                if teachingPart == 2 {
                                    teachScene()
                                }
                                else {
                                    gameOverYouLose()
                                }
                            }
                            
                            switch boardNumber {
                            case 1, 2, 3:
                                if boardArray[2][1] == .RedBean {
                                    sound1()
                                    if teachingPart == 3 {
                                        menuScene() }
                                    else { staticAI = true
                                        gameOverYouLose()
                                    }
                                }
                            case 4, 5, 6, 7:
                                if boardArray[3][1] == .RedBean {
                                    sound1()
                                    if teachingPart == 3 {
                                        menuScene() }
                                    else { staticAI = true
                                        gameOverYouLose()
                                    }
                                }
                            case 8, 9, 10:
                                if boardArray[4][2] == .RedBean {
                                    sound1()
                                    if teachingPart == 3 { menuScene() }
                                    else { staticAI = true; gameOverYouLose() }
                                }
                            default: print("boardNumber is not 1-10.")
                            }
                            
                        }
                    }
                }
            }
            
                
////////////////////
//  MULTI PLAYER  //
////////////////////
            
            else if multiPlayerRulesOn == true {
                print(currentPlayer)
                if currentPlayer == "x" {
                    sound1()
                    if getTile(tapLoc) == .BluePiece || getTile(tapLoc) == .BlueBean {
                        selLoc = tapLoc
                        if result.node!.name!.hasPrefix("Blue01") { selBall = 1 }
                        if result.node!.name!.hasPrefix("Blue02") { selBall = 2 }
                        if result.node!.name!.hasPrefix("Blue03") { selBall = 3 }
                        if result.node!.name!.hasPrefix("Blue04") { selBall = 4 }
                        if result.node!.name!.hasPrefix("Blue05") { selBall = 5 }
                        if result.node!.name!.hasPrefix("Blue06") { selBall = 6 }
                        if result.node!.name!.hasPrefix("Blue07") { selBall = 7 }
                        if result.node!.name!.hasPrefix("BlueBeanObject") { selBall = 10 }
                    }
                    
                    if getTile(tapLoc) != .BluePiece && getTile(tapLoc) != .BlueBean && selLoc == nil { return }
                    
                    // find possible moves
                    let rowCount = getRowCount(selLoc!)
                    let nLimit = getNLimit(selLoc!)
                    let sLimit = getSLimit(selLoc!)
                    let wLimit = getWLimit(selLoc!)
                    let eLimit = getELimit(selLoc!)
                    let nwLimit = getNWLimit(selLoc!)
                    let swLimit = getSWLimit(selLoc!)
                    let seLimit = getSELimit(selLoc!)
                    let neLimit = getNELimit(selLoc!)
                    if tapLoc.y < selLoc!.y && tapLoc.x == selLoc!.x && selLoc!.x == nLimit.x && tapLoc.y < nLimit.y ||
                        tapLoc.y > selLoc!.y && tapLoc.x == selLoc!.x && selLoc!.x == sLimit.x && tapLoc.y > sLimit.y ||
                        tapLoc.y == selLoc!.y && tapLoc.x < selLoc!.x && tapLoc.x < wLimit.x && selLoc!.y == wLimit.y ||
                        tapLoc.y == selLoc!.y && tapLoc.x > selLoc!.x && tapLoc.x > eLimit.x && selLoc!.y == eLimit.y && selLoc != nil { return }
                    if tapLoc.x < selLoc!.x && tapLoc.y < selLoc!.y && tapLoc.x < nwLimit.x && tapLoc.y < nwLimit.y ||
                        tapLoc.x > selLoc!.x && tapLoc.y > selLoc!.y && tapLoc.x > seLimit.x && tapLoc.y > seLimit.y ||
                        tapLoc.x < selLoc!.x && tapLoc.y > selLoc!.y && tapLoc.x < swLimit.x && tapLoc.y > swLimit.y ||
                        tapLoc.x > selLoc!.x && tapLoc.y < selLoc!.y && tapLoc.x > neLimit.x && tapLoc.y < neLimit.y && selLoc != nil { return }
                    
                    let vert = abs(tapLoc.x - selLoc!.x)
                    let horiz = abs(tapLoc.y - selLoc!.y)
                    if vert == 0 && horiz == rowCount || vert == rowCount && horiz == 0 || vert == rowCount && horiz == rowCount {
                        
                        if getTile(tapLoc) == .Empty {
                            movePiece(selLoc!, tapLoc)
                            switch selBall {
                            case 1: blue1!.runAction(movePlayer)
                            case 2: blue2!.runAction(movePlayer)
                            case 3: blue3!.runAction(movePlayer)
                            case 4: blue4!.runAction(movePlayer)
                            case 5: blue5!.runAction(movePlayer)
                            case 6: blue6!.runAction(movePlayer)
                            case 7: blue7!.runAction(movePlayer)
                            case 10: blueBean!.runAction(movePlayer)
                            default: print("default") }
                        }
                        
                        if getTile(tapLoc) == .RedPiece {
                            sound1()
                            redCaptured -= 1
                            movePiece(selLoc!, tapLoc)
                            
                            switch selBall {
                            case 1: blue1!.runAction(movePlayer); blue1!.position.x = locX; blue1!.position.y = locY
                            case 2: blue2!.runAction(movePlayer); blue2!.position.x = locX; blue2!.position.y = locY
                            case 3: blue3!.runAction(movePlayer); blue3!.position.x = locX; blue3!.position.y = locY
                            case 4: blue4!.runAction(movePlayer); blue4!.position.x = locX; blue4!.position.y = locY
                            case 5: blue5!.runAction(movePlayer); blue5!.position.x = locX; blue5!.position.y = locY
                            case 6: blue6!.runAction(movePlayer); blue6!.position.x = locX; blue6!.position.y = locY
                            case 7: blue7!.runAction(movePlayer); blue7!.position.x = locX; blue7!.position.y = locY
                            case 10: blueBean!.runAction(movePlayer); blueBean!.position.x = locX; blueBean!.position.y = locY
                            default: print("default") }

                            if locX == red1!.position.x && locY == red1!.position.y { red1!.runAction(takeOff) }
                            if locX == red2!.position.x && locY == red2!.position.y { red2!.runAction(takeOff) }
                            if locX == red3!.position.x && locY == red3!.position.y { red3!.runAction(takeOff) }
                            if locX == red4!.position.x && locY == red4!.position.y { red4!.runAction(takeOff) }
                            if locX == red5!.position.x && locY == red5!.position.y { red5!.runAction(takeOff) }
                            if locX == red6!.position.x && locY == red6!.position.y { red6!.runAction(takeOff) }
                            if locX == red7!.position.x && locY == red7!.position.y { red7!.runAction(takeOff) }
                            if locX == redBean!.position.x && locY == redBean!.position.y { redBean!.runAction(takeOff) }
                        }
                        
                        if getTile(tapLoc) == .RedBean {
                            sound1()
                            redCaptured -= 1
                            redBeanActive = false
                            blueBeanActive = true
                            getBlueBean(selLoc!, tapLoc)
                            
                            switch selBall {
                            case 1: blue1!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 2: blue2!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 3: blue3!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 4: blue4!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 5: blue5!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 6: blue6!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 7: blue7!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            default: print("default") }

                            blueBean!.opacity = 1
                            redBean!.runAction(takeOff)
                            blueHome!.opacity = 1
                            redHome!.opacity = 0
                            blueHomeEffect!.runAction(popHome)
                        }
                        
                        if getTile(tapLoc) == .Bean {
                            sound1()
                            blueBeanActive = true
                            getBlueBean(selLoc!, tapLoc)
                            newbean!.runAction(takeOff)
                            
                            switch selBall {
                            case 1: blue1!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 2: blue2!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 3: blue3!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 4: blue4!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 5: blue5!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 6: blue6!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            case 7: blue7!.runAction(takeOff); blueBean!.runAction(movePlayer)
                            default: print("default") }
                            
                            blueHome!.opacity = 1
                            blueHomeEffect!.runAction(popHome)
                        }
                        
                        
                        
                        switch multiNumber {
                        case 1:
                            if boardArray[2][7] == .BlueBean {
                                sound1()
                                if teachingPart == 3 {
                                    menuScene()
                                }
                                else {
                                    staticAI = true
                                    winLoseMarker = "blueWinner"
                                    multiplayerBlueWinsScene()
                                }
                            }
                        case 2, 3:
                            if boardArray[3][11] == .BlueBean {
                                sound1()
                                if teachingPart == 3 {
                                    menuScene()
                                }
                                else {
                                    staticAI = true
                                    winLoseMarker = "blueWinner"
                                    multiplayerBlueWinsScene()
                                }
                            }
                        case 4:
                            if boardArray[4][12] == .BlueBean {
                                sound1()
                                if teachingPart == 3 {
                                    menuScene()
                                }
                                else {
                                    staticAI = true
                                    winLoseMarker = "blueWinner"
                                    multiplayerBlueWinsScene()
                                }
                            }
                        default: print("default")
                        }

                        if redCaptured == 0 {
                            sound1()
                            winLoseMarker = "blueWinner"
                            multiplayerBlueWinsScene()
                            
                        }

                        currentPlayer = "o"
                        let sX = selLoc!.x
                        let sY = selLoc!.y
                        selLoc = nil
                        print("final look at selBall before sending data: \(selBall)")
                        let messageDict = ["selBallSent":selBall, "player":currentPlayer, "locationX":locX,  "locationY":locY, "tapX":tapLoc.x, "tapY":tapLoc.y, "selX":sX, "selY":sY, "winnerIs":winLoseMarker]
                        let messageData = try? NSJSONSerialization.dataWithJSONObject(messageDict, options: NSJSONWritingOptions.PrettyPrinted)
                        var error:NSError?
                        do {
                            try appDelegate.mpcHandler.session.sendData(messageData!, toPeers: appDelegate.mpcHandler.session.connectedPeers, withMode: MCSessionSendDataMode.Reliable)
                        } catch let error1 as NSError {
                            error = error1
                        }
                        if error != nil { /*print("error: \(error?.localizedDescription)")*/ }
                    }
                    
                } else if currentPlayer == "o" {
                    if getTile(tapLoc) == .RedPiece || getTile(tapLoc) == .RedBean {
                        sound1()
                        selLoc = tapLoc
                        if result.node!.name!.hasPrefix("Red01") { selBall = 11 }
                        if result.node!.name!.hasPrefix("Red02") { selBall = 12 }
                        if result.node!.name!.hasPrefix("Red03") { selBall = 13 }
                        if result.node!.name!.hasPrefix("Red04") { selBall = 14 }
                        if result.node!.name!.hasPrefix("Red05") { selBall = 15 }
                        if result.node!.name!.hasPrefix("Red06") { selBall = 16 }
                        if result.node!.name!.hasPrefix("Red07") { selBall = 17 }
                        if result.node!.name!.hasPrefix("RedBeanObject") { selBall = 20 }
                    }
                    
                    if getTile(tapLoc) != .RedPiece && getTile(tapLoc) != .RedBean && selLoc == nil { return }
                    
                    // find possible moves
                    let rowCount = getRowCount(selLoc!)
                    let nLimit = getNLimit(selLoc!)
                    let sLimit = getSLimit(selLoc!)
                    let wLimit = getWLimit(selLoc!)
                    let eLimit = getELimit(selLoc!)
                    let nwLimit = getNWLimit(selLoc!)
                    let swLimit = getSWLimit(selLoc!)
                    let seLimit = getSELimit(selLoc!)
                    let neLimit = getNELimit(selLoc!)
                    if tapLoc.y < selLoc!.y && tapLoc.x == selLoc!.x && selLoc!.x == nLimit.x && tapLoc.y < nLimit.y ||
                        tapLoc.y > selLoc!.y && tapLoc.x == selLoc!.x && selLoc!.x == sLimit.x && tapLoc.y > sLimit.y ||
                        tapLoc.y == selLoc!.y && tapLoc.x < selLoc!.x && tapLoc.x < wLimit.x && selLoc!.y == wLimit.y ||
                        tapLoc.y == selLoc!.y && tapLoc.x > selLoc!.x && tapLoc.x > eLimit.x && selLoc!.y == eLimit.y && selLoc != nil { return }
                    if tapLoc.x < selLoc!.x && tapLoc.y < selLoc!.y && tapLoc.x < nwLimit.x && tapLoc.y < nwLimit.y ||
                        tapLoc.x > selLoc!.x && tapLoc.y > selLoc!.y && tapLoc.x > seLimit.x && tapLoc.y > seLimit.y ||
                        tapLoc.x < selLoc!.x && tapLoc.y > selLoc!.y && tapLoc.x < swLimit.x && tapLoc.y > swLimit.y ||
                        tapLoc.x > selLoc!.x && tapLoc.y < selLoc!.y && tapLoc.x > neLimit.x && tapLoc.y < neLimit.y && selLoc != nil { return }
                    
                    let vert = abs(tapLoc.x - selLoc!.x)
                    let horiz = abs(tapLoc.y - selLoc!.y)
                    if vert == 0 && horiz == rowCount || vert == rowCount && horiz == 0 || vert == rowCount && horiz == rowCount {
                        
                        if getTile(tapLoc) == .Empty { sound1()
                            movePiece(selLoc!, tapLoc)
                            
                            switch selBall {
                            case 11: red1!.runAction(movePlayer); red1!.position.x = locX; red1!.position.y = locY
                            case 12: red2!.runAction(movePlayer); red2!.position.x = locX; red2!.position.y = locY
                            case 13: red3!.runAction(movePlayer); red3!.position.x = locX; red3!.position.y = locY
                            case 14: red4!.runAction(movePlayer); red4!.position.x = locX; red4!.position.y = locY
                            case 15: red5!.runAction(movePlayer); red5!.position.x = locX; red5!.position.y = locY
                            case 16: red6!.runAction(movePlayer); red6!.position.x = locX; red6!.position.y = locY
                            case 17: red7!.runAction(movePlayer); red7!.position.x = locX; red7!.position.y = locY
                            case 20: redBean!.runAction(movePlayer); redBean!.position.x = locX; redBean!.position.y = locY
                            default: print("default") }
                        }
                        
                        if getTile(tapLoc) == .BluePiece { sound1()
                            movePiece(selLoc!, tapLoc)
                            blueCaptured -= 1
                            switch selBall {
                            case 11: red1!.runAction(movePlayer); red1!.position.x = locX; red1!.position.y = locY
                            case 12: red2!.runAction(movePlayer); red2!.position.x = locX; red2!.position.y = locY
                            case 13: red3!.runAction(movePlayer); red3!.position.x = locX; red3!.position.y = locY
                            case 14: red4!.runAction(movePlayer); red4!.position.x = locX; red4!.position.y = locY
                            case 15: red5!.runAction(movePlayer); red5!.position.x = locX; red5!.position.y = locY
                            case 16: red6!.runAction(movePlayer); red6!.position.x = locX; red6!.position.y = locY
                            case 17: red7!.runAction(movePlayer); red7!.position.x = locX; red7!.position.y = locY
                            case 20: redBean!.runAction(movePlayer); redBean!.position.x = locX; redBean!.position.y = locY
                            default: print("default") }
                            
                            if locX == blue1!.position.x && locY == blue1!.position.y { blue1!.runAction(takeOff) }
                            if locX == blue2!.position.x && locY == blue2!.position.y { blue2!.runAction(takeOff) }
                            if locX == blue3!.position.x && locY == blue3!.position.y { blue3!.runAction(takeOff) }
                            if locX == blue4!.position.x && locY == blue4!.position.y { blue4!.runAction(takeOff) }
                            if locX == blue5!.position.x && locY == blue5!.position.y { blue5!.runAction(takeOff) }
                            if locX == blue6!.position.x && locY == blue6!.position.y { blue6!.runAction(takeOff) }
                            if locX == blue7!.position.x && locY == blue7!.position.y { blue7!.runAction(takeOff) }
                            if locX == blueBean!.position.x && locY == blueBean!.position.y { blueBean!.runAction(takeOff) }
                        }

                        if getTile(tapLoc) == .BlueBean {
                            sound1()
                            blueCaptured -= 1
                            redBeanActive = true
                            blueBeanActive = false
                            getRedBean(selLoc!, tapLoc)
                            
                            switch selBall {
                            case 11: red1!.runAction(takeOff); redBean!.runAction(movePlayer)
                            case 12: red2!.runAction(takeOff); redBean!.runAction(movePlayer)
                            case 13: red3!.runAction(takeOff); redBean!.runAction(movePlayer)
                            case 14: red4!.runAction(takeOff); redBean!.runAction(movePlayer)
                            case 15: red5!.runAction(takeOff); redBean!.runAction(movePlayer)
                            case 16: red6!.runAction(takeOff); redBean!.runAction(movePlayer)
                            case 17: red7!.runAction(takeOff); redBean!.runAction(movePlayer)
                            default: print("default") }
                            
                            redBean!.opacity = 1
                            blueBean!.runAction(takeOff)
                            redHome!.opacity = 1
                            blueHome!.opacity = 0
                            redHomeEffect!.runAction(popHome)
                        }
                        
                        if getTile(tapLoc) == .Bean {
                            sound1()
                            redBeanActive = true
                            getRedBean(selLoc!, tapLoc)
                            newbean!.runAction(takeOff)
                            
                            switch selBall {
                            case 11: red1!.runAction(takeOff); redBean!.runAction(movePlayer)
                            case 12: red2!.runAction(takeOff); redBean!.runAction(movePlayer)
                            case 13: red3!.runAction(takeOff); redBean!.runAction(movePlayer)
                            case 14: red4!.runAction(takeOff); redBean!.runAction(movePlayer)
                            case 15: red5!.runAction(takeOff); redBean!.runAction(movePlayer)
                            case 16: red6!.runAction(takeOff); redBean!.runAction(movePlayer)
                            case 17: red7!.runAction(takeOff); redBean!.runAction(movePlayer)
                            default: print("default") }
                            
                            redHome!.opacity = 1
                            redHomeEffect!.runAction(popHome)
                        }
                        
                        
                        
                        switch multiNumber {
                        case 1:
                            if boardArray[2][1] == .RedBean {
                                sound1()
                                if teachingPart == 3 {
                                    menuScene()
                                }
                                else {
                                    staticAI = true
                                    winLoseMarker = "redWinner"
                                    multiplayerRedWinsScene()
                                }
                            }
                        case 2, 3:
                            if boardArray[3][1] == .RedBean {
                                sound1()
                                if teachingPart == 3 {
                                    menuScene()
                                }
                                else {
                                    staticAI = true
                                    winLoseMarker = "redWinner"
                                    multiplayerRedWinsScene()
                                }
                            }
                        case 4:
                            if boardArray[4][2] == .RedBean {
                                sound1()
                                if teachingPart == 3 {
                                    menuScene()
                                }
                                else {
                                    staticAI = true
                                    winLoseMarker = "redWinner"
                                    multiplayerRedWinsScene()
                                }
                            }
                        default: print("default")
                        }
                        
                        if blueCaptured == 0 {
                            sound1()
                            winLoseMarker = "redWinner"
                            multiplayerRedWinsScene()
                        }
                        
                        currentPlayer = "x"
                        let sX = selLoc!.x
                        let sY = selLoc!.y
                        selLoc = nil
                        
                        let messageDict = ["selBallSent":selBall, "player":currentPlayer, "locationX":locX,  "locationY":locY, "tapX":tapLoc.x, "tapY":tapLoc.y, "selX":sX, "selY":sY, "winnerIs":winLoseMarker]
                        let messageData = try? NSJSONSerialization.dataWithJSONObject(messageDict, options: NSJSONWritingOptions.PrettyPrinted)
                        var error:NSError?
                        do {
                            try appDelegate.mpcHandler.session.sendData(messageData!, toPeers: appDelegate.mpcHandler.session.connectedPeers, withMode: MCSessionSendDataMode.Reliable)
                        } catch let error1 as NSError {
                            error = error1
                        }
                        if error != nil { /*print("error: \(error?.localizedDescription)")*/ }
                    }
                }
            }
        }
    }
    
    
////////////////////
//  RECEIVE DATA  //
////////////////////
    
    func handleReceivedDataWithNotification(notification:NSNotification) {
        let userInfo = notification.userInfo! as Dictionary
        let receivedData:NSData = userInfo["data"] as! NSData
        let message = try? NSJSONSerialization.JSONObjectWithData(receivedData, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
        let senderPeerID:MCPeerID = userInfo["peerID"] as! MCPeerID
        let senderDisplayName = senderPeerID.displayName
        
        if message!.objectForKey("string")?.isEqualToString("New Game") == true {
            let alert = UIAlertController(title: "Beans", message: "\(senderDisplayName) has started a new game", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            boardMultiPlayer1Scene()
        } else {
            let selBallSent:Int! = message!.objectForKey("selBallSent")!.integerValue
            let player:String! = message!.objectForKey("player") as! String
            let tapX:Int! = message!.objectForKey("tapX")!.integerValue
            let tapY:Int! = message!.objectForKey("tapY")!.integerValue
            let selX:Int! = message!.objectForKey("selX")!.integerValue
            let selY:Int! = message!.objectForKey("selY")!.integerValue
            let locationX:Int! = message!.objectForKey("locationX")!.integerValue
            let locationY:Int! = message!.objectForKey("locationY")!.integerValue
            let winnerIs:String! = message!.objectForKey("winnerIs") as! String
            
            if selBallSent != nil && player != nil && tapX != nil && tapY != nil && locationX != nil && locationY != nil && winnerIs != nil {
                
                if winnerIs == "blueWinner" {
                    multiplayerBlueWinsScene()
                } else if winnerIs == "redWinner" {
                    multiplayerRedWinsScene()
                } else {
                    let scnView = self.view as! SCNView
                    let blue1 = scnView.scene!.rootNode.childNodeWithName("Blue01", recursively: true)
                    let blue2 = scnView.scene!.rootNode.childNodeWithName("Blue02", recursively: true)
                    let blue3 = scnView.scene!.rootNode.childNodeWithName("Blue03", recursively: true)
                    let blue4 = scnView.scene!.rootNode.childNodeWithName("Blue04", recursively: true)
                    let blue5 = scnView.scene!.rootNode.childNodeWithName("Blue05", recursively: true)
                    let blue6 = scnView.scene!.rootNode.childNodeWithName("Blue06", recursively: true)
                    let blue7 = scnView.scene!.rootNode.childNodeWithName("Blue07", recursively: true)
                    let blueBean = scnView.scene!.rootNode.childNodeWithName("BlueBeanObject", recursively: true)
                    let red1 = scnView.scene!.rootNode.childNodeWithName("Red01", recursively: true)
                    let red2 = scnView.scene!.rootNode.childNodeWithName("Red02", recursively: true)
                    let red3 = scnView.scene!.rootNode.childNodeWithName("Red03", recursively: true)
                    let red4 = scnView.scene!.rootNode.childNodeWithName("Red04", recursively: true)
                    let red5 = scnView.scene!.rootNode.childNodeWithName("Red05", recursively: true)
                    let red6 = scnView.scene!.rootNode.childNodeWithName("Red06", recursively: true)
                    let red7 = scnView.scene!.rootNode.childNodeWithName("Red07", recursively: true)
                    let redBean = scnView.scene!.rootNode.childNodeWithName("RedBeanObject", recursively: true)
                    let newbean = scnView.scene!.rootNode.childNodeWithName("NewBean", recursively: true)
                    let blueHome = scnView.scene!.rootNode.childNodeWithName("BlueHome", recursively: true)
                    let redHome = scnView.scene!.rootNode.childNodeWithName("RedHome", recursively: true)
                    let blueHomeEffect = scnView.scene!.rootNode.childNodeWithName("BlueHomeEffect", recursively: true)
                    let redHomeEffect = scnView.scene!.rootNode.childNodeWithName("RedHomeEffect", recursively: true)
                    
                    //effect actions
                    let effectA = SCNAction.scaleBy(1000, duration: 0.1)
                    let effectB = SCNAction.scaleBy(2, duration: 0.1)
                    let effectC = SCNAction.scaleBy(0.5, duration: 0.1)
                    let effectD = SCNAction.scaleBy(0.001, duration: 0.1)
                    let show = SCNAction.fadeInWithDuration(0.001)
                    let hide = SCNAction.fadeOutWithDuration(0.4)
                    let pause = SCNAction.waitForDuration(0.4)
                    let popHome = SCNAction.sequence([pause, show, effectA, effectB, effectC, pause, effectD, hide])
                    
                    let movePlayer = SCNAction.moveTo(SCNVector3(x: Float(locationX), y: Float(locationY), z: -1.5), duration: 0.5)
                    let takeOff = SCNAction.moveTo(SCNVector3(x: 17, y: -100, z: -100), duration: 0.01)
                    let selected = BoardLoc(x: Int(selX), y: Int(selY))
                    let tapped = BoardLoc(x: Int(tapX), y: Int(tapY))
                    
                    
                    print("selBallSent = \(selBallSent)")
                    
                    switch selBallSent {
                    case 1: if boardArray[tapX][tapY] == .Bean {
                        blue1!.runAction(takeOff)
                        blueBean!.runAction(movePlayer)
                        getBlueBean(selected, tapped)
                        blueHome!.opacity = 1
                        blueHomeEffect!.runAction(popHome)
                    } else if boardArray[tapX][tapY] == .RedBean {
                        blueBean!.runAction(movePlayer)
                        redBean!.runAction(takeOff)
                        blue1!.runAction(takeOff)
                        getBlueBean(selected, tapped)
                        blueHome!.opacity = 1
                        blueHomeEffect!.runAction(popHome)
                        redHome!.opacity = 0
                    } else {
                        blue1!.runAction(movePlayer)
                        movePiece(selected, tapped)
                        }
                    case 2: if boardArray[tapX][tapY] == .Bean {
                        blue2!.runAction(takeOff)
                        blueBean!.runAction(movePlayer)
                        getBlueBean(selected, tapped)
                        blueHome!.opacity = 1
                        blueHomeEffect!.runAction(popHome)
                    } else if boardArray[tapX][tapY] == .RedBean {
                        blueBean!.runAction(movePlayer)
                        redBean!.runAction(takeOff)
                        blue2!.runAction(takeOff)
                        getBlueBean(selected, tapped)
                        blueHome!.opacity = 1
                        blueHomeEffect!.runAction(popHome)
                        redHome!.opacity = 0
                    } else { blue2!.runAction(movePlayer)
                        movePiece(selected, tapped)
                        }
                    case 3: if boardArray[tapX][tapY] == .Bean {
                        blue3!.runAction(takeOff)
                        blueBean!.runAction(movePlayer)
                        getBlueBean(selected, tapped)
                        blueHome!.opacity = 1
                        blueHomeEffect!.runAction(popHome)
                    } else if boardArray[tapX][tapY] == .RedBean {
                        blueBean!.runAction(movePlayer)
                        redBean!.runAction(takeOff)
                        blue3!.runAction(takeOff)
                        getBlueBean(selected, tapped)
                        blueHome!.opacity = 1
                        blueHomeEffect!.runAction(popHome)
                        redHome!.opacity = 0
                    } else { blue3!.runAction(movePlayer)
                        movePiece(selected, tapped) }
                    case 4: if boardArray[tapX][tapY] == .Bean {
                        blue4!.runAction(takeOff)
                        blueBean!.runAction(movePlayer)
                        getBlueBean(selected, tapped)
                        blueHome!.opacity = 1
                        blueHomeEffect!.runAction(popHome)
                    } else if boardArray[tapX][tapY] == .RedBean {
                        blueBean!.runAction(movePlayer)
                        redBean!.runAction(takeOff)
                        blue4!.runAction(takeOff)
                        getBlueBean(selected, tapped)
                        blueHome!.opacity = 1
                        blueHomeEffect!.runAction(popHome)
                        redHome!.opacity = 0
                    } else { blue4!.runAction(movePlayer)
                        movePiece(selected, tapped)
                        }
                    case 5: if boardArray[tapX][tapY] == .Bean {
                        blue5!.runAction(takeOff)
                        blueBean!.runAction(movePlayer)
                        getBlueBean(selected, tapped)
                        blueHome!.opacity = 1
                        blueHomeEffect!.runAction(popHome)
                    } else if boardArray[tapX][tapY] == .RedBean {
                        blueBean!.runAction(movePlayer)
                        redBean!.runAction(takeOff)
                        blue5!.runAction(takeOff)
                        getBlueBean(selected, tapped)
                        blueHome!.opacity = 1
                        blueHomeEffect!.runAction(popHome)
                        redHome!.opacity = 0
                    } else { blue5!.runAction(movePlayer)
                        movePiece(selected, tapped)
                        }
                    case 6: if boardArray[tapX][tapY] == .Bean {
                        blue6!.runAction(takeOff)
                        blueBean!.runAction(movePlayer)
                        getBlueBean(selected, tapped)
                        blueHome!.opacity = 1
                        blueHomeEffect!.runAction(popHome)
                    } else if boardArray[tapX][tapY] == .RedBean {
                        blueBean!.runAction(movePlayer)
                        redBean!.runAction(takeOff)
                        blue6!.runAction(takeOff)
                        getBlueBean(selected, tapped)
                        blueHome!.opacity = 1
                        blueHomeEffect!.runAction(popHome)
                        redHome!.opacity = 0
                    } else { blue6!.runAction(movePlayer)
                        movePiece(selected, tapped)
                        }
                    case 7: if boardArray[tapX][tapY] == .Bean {
                        blue7!.runAction(takeOff)
                        blueBean!.runAction(movePlayer)
                        getBlueBean(selected, tapped)
                        blueHome!.opacity = 1
                        blueHomeEffect!.runAction(popHome)
                    } else if boardArray[tapX][tapY] == .RedBean {
                        blueBean!.runAction(movePlayer)
                        redBean!.runAction(takeOff)
                        blue7!.runAction(takeOff)
                        getBlueBean(selected, tapped)
                        blueHome!.opacity = 1
                        blueHomeEffect!.runAction(popHome)
                        redHome!.opacity = 0
                    } else {
                        blue7!.runAction(movePlayer)
                        movePiece(selected, tapped)
                        }
                    case 10: if boardArray[tapX][tapY] == .Bean {
                        blueBean!.runAction(takeOff)
                        blueBean!.runAction(movePlayer)
                        getBlueBean(selected, tapped)
                    } else {
                        blueBean!.runAction(movePlayer)
                        movePiece(selected, tapped)
                        }
                    case 11: if boardArray[tapX][tapY] == .Bean {
                        red1!.runAction(takeOff)
                        redBean!.runAction(movePlayer)
                        getRedBean(selected, tapped)
                        redHome!.opacity = 1
                        redHomeEffect!.runAction(popHome)
                    } else if boardArray[tapX][tapY] == .BlueBean {
                        redBean!.runAction(movePlayer)
                        blueBean!.runAction(takeOff)
                        red1!.runAction(takeOff)
                        getRedBean(selected, tapped)
                        redHome!.opacity = 1
                        redHomeEffect!.runAction(popHome)
                        blueHome!.opacity = 0
                    } else { red1!.runAction(movePlayer)
                        movePiece(selected, tapped)
                        }
                    case 12: if boardArray[tapX][tapY] == .Bean {
                        red2!.runAction(takeOff)
                        redBean!.runAction(movePlayer)
                        getRedBean(selected, tapped)
                        redHome!.opacity = 1
                        redHomeEffect!.runAction(popHome)
                    } else if boardArray[tapX][tapY] == .BlueBean {
                        redBean!.runAction(movePlayer)
                        blueBean!.runAction(takeOff)
                        red2!.runAction(takeOff)
                        getRedBean(selected, tapped)
                        redHome!.opacity = 1
                        redHomeEffect!.runAction(popHome)
                        blueHome!.opacity = 0
                    } else { red2!.runAction(movePlayer)
                        movePiece(selected, tapped)
                        }
                    case 13: if boardArray[tapX][tapY] == .Bean {
                        red3!.runAction(takeOff)
                        redBean!.runAction(movePlayer)
                        getRedBean(selected, tapped)
                        redHome!.opacity = 1
                        redHomeEffect!.runAction(popHome)
                    } else if boardArray[tapX][tapY] == .BlueBean {
                        redBean!.runAction(movePlayer)
                        blueBean!.runAction(takeOff)
                        red3!.runAction(takeOff)
                        getRedBean(selected, tapped)
                        redHome!.opacity = 1
                        redHomeEffect!.runAction(popHome)
                        blueHome!.opacity = 0
                    } else { red3!.runAction(movePlayer)
                        movePiece(selected, tapped)
                        }
                    case 14: if boardArray[tapX][tapY] == .Bean {
                        red4!.runAction(takeOff)
                        redBean!.runAction(movePlayer)
                        getRedBean(selected, tapped)
                        redHome!.opacity = 1
                        redHomeEffect!.runAction(popHome)
                    }
                    else if boardArray[tapX][tapY] == .BlueBean {
                        redBean!.runAction(movePlayer)
                        blueBean!.runAction(takeOff)
                        red4!.runAction(takeOff)
                        getRedBean(selected, tapped)
                        redHome!.opacity = 1
                        redHomeEffect!.runAction(popHome)
                        blueHome!.opacity = 0
                    }
                    else { red4!.runAction(movePlayer)
                        movePiece(selected, tapped)
                        }
                    case 15: if boardArray[tapX][tapY] == .Bean {
                        red5!.runAction(takeOff)
                        redBean!.runAction(movePlayer)
                        getRedBean(selected, tapped)
                        redHome!.opacity = 1
                        redHomeEffect!.runAction(popHome)
                    }
                    else if boardArray[tapX][tapY] == .BlueBean {
                        redBean!.runAction(movePlayer)
                        blueBean!.runAction(takeOff)
                        red5!.runAction(takeOff)
                        getRedBean(selected, tapped)
                        redHome!.opacity = 1
                        redHomeEffect!.runAction(popHome)
                        blueHome!.opacity = 0
                    } else {
                        red5!.runAction(movePlayer)
                        movePiece(selected, tapped)
                        }
                    case 16: if boardArray[tapX][tapY] == .Bean {
                        red6!.runAction(takeOff)
                        redBean!.runAction(movePlayer)
                        getRedBean(selected, tapped)
                        redHome!.opacity = 1
                        redHomeEffect!.runAction(popHome)
                    } else if boardArray[tapX][tapY] == .BlueBean {
                        redBean!.runAction(movePlayer)
                        blueBean!.runAction(takeOff)
                        red6!.runAction(takeOff)
                        getRedBean(selected, tapped)
                        redHome!.opacity = 1
                        redHomeEffect!.runAction(popHome)
                        blueHome!.opacity = 0
                    } else {
                        red6!.runAction(movePlayer)
                        movePiece(selected, tapped)
                        }
                    case 17: if boardArray[tapX][tapY] == .Bean {
                        red7!.runAction(takeOff)
                        redBean!.runAction(movePlayer)
                        getRedBean(selected, tapped)
                        redHome!.opacity = 1
                        redHomeEffect!.runAction(popHome)
                    } else if boardArray[tapX][tapY] == .BlueBean {
                        redBean!.runAction(movePlayer)
                        blueBean!.runAction(takeOff)
                        red7!.runAction(takeOff)
                        getRedBean(selected, tapped)
                        redHome!.opacity = 1
                        redHomeEffect!.runAction(popHome)
                        blueHome!.opacity = 0
                    } else {
                        red7!.runAction(movePlayer)
                        movePiece(selected, tapped)
                        }
                    case 20: if boardArray[tapX][tapY] == .Bean {
                        redBean!.runAction(takeOff)
                        redBean!.runAction(movePlayer)
                        getRedBean(selected, tapped)
                        redHome!.opacity = 1
                        redHomeEffect!.runAction(popHome)
                    } else {
                        redBean!.runAction(movePlayer)
                        movePiece(selected, tapped)
                        }
                    default: print("default")
                    }
                    if locationX == Int(red1!.position.x) && locationY == Int(red1!.position.y) { red1!.runAction(takeOff) }
                    if locationX == Int(red2!.position.x) && locationY == Int(red2!.position.y) { red2!.runAction(takeOff) }
                    if locationX == Int(red3!.position.x) && locationY == Int(red3!.position.y) { red3!.runAction(takeOff) }
                    if locationX == Int(red4!.position.x) && locationY == Int(red4!.position.y) { red4!.runAction(takeOff) }
                    if locationX == Int(red5!.position.x) && locationY == Int(red5!.position.y) { red5!.runAction(takeOff) }
                    if locationX == Int(red6!.position.x) && locationY == Int(red6!.position.y) { red6!.runAction(takeOff) }
                    if locationX == Int(red7!.position.x) && locationY == Int(red7!.position.y) { red7!.runAction(takeOff) }
                    if locationX == Int(redBean!.position.x) && locationY == Int(redBean!.position.y) { redBean!.runAction(takeOff); redHome! }
                    if locationX == Int(blue1!.position.x) && locationY == Int(blue1!.position.y) { blue1!.runAction(takeOff) }
                    if locationX == Int(blue2!.position.x) && locationY == Int(blue2!.position.y) { blue2!.runAction(takeOff) }
                    if locationX == Int(blue3!.position.x) && locationY == Int(blue3!.position.y) { blue3!.runAction(takeOff) }
                    if locationX == Int(blue4!.position.x) && locationY == Int(blue4!.position.y) { blue4!.runAction(takeOff) }
                    if locationX == Int(blue5!.position.x) && locationY == Int(blue5!.position.y) { blue5!.runAction(takeOff) }
                    if locationX == Int(blue6!.position.x) && locationY == Int(blue6!.position.y) { blue6!.runAction(takeOff) }
                    if locationX == Int(blue7!.position.x) && locationY == Int(blue7!.position.y) { blue7!.runAction(takeOff) }
                    if locationX == Int(blueBean!.position.x) && locationY == Int(blueBean!.position.y) { blueBean!.runAction(takeOff) }
                    if locationX == Int(newbean!.position.x) && locationY == Int(newbean!.position.y) { newbean!.runAction(takeOff) }
                    
                    if player == "o" {
                        currentPlayer = "o"
                    } else {
                        currentPlayer = "x"
                    }
                }
            }
        }
    }
    
    
/////////////////
//   MOVE AI   //
/////////////////
    
    func moveAI() {
        
        if currentPlayer == "x" {
            pauseCount = 0
            timer3.invalidate()
            currentPlayer = "o"
            
            let scnView = view as! SCNView
            
            let blue1 = scnView.scene!.rootNode.childNodeWithName("Blue01", recursively: true)
            let blue2 = scnView.scene!.rootNode.childNodeWithName("Blue02", recursively: true)
            let blue3 = scnView.scene!.rootNode.childNodeWithName("Blue03", recursively: true)
            let blue4 = scnView.scene!.rootNode.childNodeWithName("Blue04", recursively: true)
            let blue5 = scnView.scene!.rootNode.childNodeWithName("Blue05", recursively: true)
            let blue6 = scnView.scene!.rootNode.childNodeWithName("Blue06", recursively: true)
            let blue7 = scnView.scene!.rootNode.childNodeWithName("Blue07", recursively: true)
            let blueBean = scnView.scene!.rootNode.childNodeWithName("BlueBeanObject", recursively: true)
            let red1 = scnView.scene!.rootNode.childNodeWithName("Red01", recursively: true)
            let red2 = scnView.scene!.rootNode.childNodeWithName("Red02", recursively: true)
            let red3 = scnView.scene!.rootNode.childNodeWithName("Red03", recursively: true)
            let red4 = scnView.scene!.rootNode.childNodeWithName("Red04", recursively: true)
            let red5 = scnView.scene!.rootNode.childNodeWithName("Red05", recursively: true)
            let red6 = scnView.scene!.rootNode.childNodeWithName("Red06", recursively: true)
            let red7 = scnView.scene!.rootNode.childNodeWithName("Red07", recursively: true)
            let redBean = scnView.scene!.rootNode.childNodeWithName("RedBeanObject", recursively: true)
            let newbean = scnView.scene!.rootNode.childNodeWithName("NewBean", recursively: true)
            let blueHome = scnView.scene!.rootNode.childNodeWithName("BlueHome", recursively: true)
            let redHome = scnView.scene!.rootNode.childNodeWithName("RedHome", recursively: true)
            let redHomeEffect = scnView.scene!.rootNode.childNodeWithName("RedHomeEffect", recursively: true)
            
            //effect actions
            let effectA = SCNAction.scaleBy(1000, duration: 0.1)
            let effectB = SCNAction.scaleBy(2, duration: 0.1)
            let effectC = SCNAction.scaleBy(0.5, duration: 0.1)
            let effectD = SCNAction.scaleBy(0.001, duration: 0.1)
            let show = SCNAction.fadeInWithDuration(0.001)
            let hide = SCNAction.fadeOutWithDuration(0.4)
            let pause = SCNAction.waitForDuration(0.4)
            let popHome = SCNAction.sequence([pause, show, effectA, effectB, effectC, pause, effectD, hide])
            
            let takeOff = SCNAction.moveTo(SCNVector3(x: 30, y: -100, z: -35), duration: 0.001)

            var someMoves = getAllMoves(currentPlayer)
            

            if boardNumber == 0 {
                someMoves = getDownMoves(currentPlayer)
            } else if boardNumber == 1 || boardNumber == 2 || boardNumber == 3 {
                if redBeanActive == false || blueBeanActive == true {
                    if aiStall == 0 {
                        aiStall += 1
                        someMoves = getAllMoves(currentPlayer)
                    } else if aiStall == 1 {
                        aiStall += 1
                        someMoves = getEastWestMoves(currentPlayer)
                    } else if aiStall >= 2 {
                        aiStall += 1
                        someMoves = getDownMoves(currentPlayer)
                    }
                    
                } else if redBeanActive == true {
                    if aiDirection == 1 || aiDirection == 4 || aiDirection == 8 || aiDirection == 13 {
                        someMoves = getUpMoves(currentPlayer)
                        aiDirection += 1
                    } else if aiDirection == 0  || aiDirection == 12 || aiDirection >= 14 {
                        someMoves = getAllMoves(currentPlayer)
                        aiDirection += 1
                    } else if aiDirection == 3 || aiDirection == 7 || aiDirection == 9 || aiDirection == 11 {
                        someMoves = getPrepareForHomingMoves(currentPlayer)
                        aiDirection += 1
                    } else if aiDirection == 2 || aiDirection == 5 || aiDirection == 6 || aiDirection == 10 {
                        aiDirection += 1
                        someMoves = getHomingMoves(currentPlayer)
                    }
                } else {
                    someMoves = getUpMoves(currentPlayer)
                }
            } else if boardNumber == 4 || boardNumber == 5 || boardNumber == 6 || boardNumber == 7  {
                if redBeanActive == false || blueBeanActive == true {
                    if aiStall == 0 || aiStall == 1 {
                        aiStall += 1
                        someMoves = getLimitedSouthMoves1(currentPlayer)
                    } else if aiStall == 2 || aiStall == 3 || aiStall == 5  {
                        aiStall += 1
                        someMoves = getLimitedSouthMoves3(currentPlayer)
                    } else if aiStall == 4 || aiStall == 6 {
                        aiStall += 1
                        someMoves = getEastWestMoves(currentPlayer)
                    } else if aiStall <= 7 {
                        someMoves = getDownMoves(currentPlayer)
                    }
                   
                } else if redBeanActive == true {
                    if aiDirection == 0 || aiDirection == 5 || aiDirection == 8 {
                        someMoves = getDownMoves(currentPlayer)
                        aiDirection += 1
                    } else if aiDirection == 1 || aiDirection == 2 || aiDirection == 3 {
                        someMoves = getLimitedSouthMoves1(currentPlayer)
                        aiDirection += 1
                    } else if aiDirection == 4 || aiDirection == 12 || aiDirection == 16 {
                        someMoves = getHomingMoves(currentPlayer)
                        aiDirection += 1
                    } else if aiDirection == 14 || aiDirection == 17 {
                        someMoves = getAllMoves(currentPlayer)
                        aiDirection += 1
                    } else if aiDirection == 6 || aiDirection == 7 || aiDirection == 9 {
                        aiDirection += 1
                        someMoves = getDirectUpMoves(currentPlayer)
                    } else if aiDirection == 15 || aiDirection >= 18 {
                        aiDirection += 1
                        someMoves = getUpMoves(currentPlayer)
                    } else if aiDirection == 10 || aiDirection == 11 || aiDirection == 13 {
                        someMoves = getDirectUpMoves(currentPlayer)
                    }
                } else {
                    someMoves = getUpMoves(currentPlayer)
                }
            } else if boardNumber == 8 || boardNumber == 9 || boardNumber == 10 {
                if redBeanActive == false || blueBeanActive == true {
                    if aiStall == 0 || aiStall == 1 || aiStall == 2 || aiStall == 5 || aiStall == 7 || aiStall <= 9 {
                        aiStall += 1
                        someMoves = getLimitedSouthMoves2(currentPlayer)
                    } else if aiStall == 3 || aiStall == 4 || aiStall == 6 || aiStall == 8 {
                        aiStall += 1
                        someMoves = getUpMoves(currentPlayer)
                    } else if aiStall == 4 || aiStall == 6 {
                        aiStall += 1
                        someMoves = getEastWestMoves(currentPlayer)
                    }
                    
                } else if redBeanActive == true {
                    if aiDirection == 0 ||  aiDirection == 3 || aiDirection == 5 || aiDirection == 8 {
                        someMoves = getUpMoves(currentPlayer)
                        aiDirection += 1
                    } else if aiDirection == 1 || aiDirection == 2 || aiDirection == 4 || aiDirection == 12 || aiDirection == 16 {
                        someMoves = getHomingMoves(currentPlayer)
                        aiDirection += 1
                    } else if  aiDirection == 10 || aiDirection == 14 || aiDirection == 17 {
                        someMoves = getAllMoves(currentPlayer)
                        aiDirection += 1
                    } else if aiDirection == 6 || aiDirection == 7 || aiDirection == 9 {
                        aiDirection += 1
                        someMoves = getDirectUpMoves(currentPlayer)
                    } else if aiDirection == 13 || aiDirection == 15 || aiDirection >= 18 {
                        aiDirection += 1
                        someMoves = getUpMoves(currentPlayer)
                    } else if aiDirection == 11 {
                        aiDirection += 1
                        someMoves = getEastWestMoves(currentPlayer)
                    }
                } else {
                    someMoves = getUpMoves(currentPlayer)
                }
            }

            if someMoves.moveArray.count == 0 {
                someMoves = getAllMoves(currentPlayer)
            }
            
            let randoms = arc4random() % UInt32(someMoves.moveArray.count)
            let picked = someMoves.moveArray[Int(randoms)]
            
            let hitFromX = Float(picked.fromLoc.x) * Float(pSizeW)
            let hitFromY = Float(picked.fromLoc.y) * -Float(pSizeH)
            let hitToX = Float(picked.toLoc.x) * Float(pSizeW)
            let hitToY = Float(picked.toLoc.y) * -Float(pSizeH)
            
            let itemOne = someMoves.moveArray[0]
            let firstItemToTile = getTile(itemOne.toLoc)
            let niceHitFromX = Float(itemOne.fromLoc.x) * Float(pSizeW)
            let niceHitFromY = Float(itemOne.fromLoc.y) * -Float(pSizeH)
            let niceHitToX = Float(itemOne.toLoc.x) * Float(pSizeW)
            let niceHitToY = Float(itemOne.toLoc.y) * -Float(pSizeH)
            
            let movePlayerNiceHit = SCNAction.moveTo(SCNVector3(x: niceHitToX, y: niceHitToY, z: -1.5), duration: 0.1)
            print("movePlayerNiceHit setup")
            let movePlayer = SCNAction.moveTo(SCNVector3(x: hitToX, y: hitToY, z: -1.5), duration: 0.1)
            print("movePlayer setup")
            if firstItemToTile == .BluePiece {
                print("7a")
                blueCaptured -= 1
                print("During the get, blueCaptured = \(blueCaptured)")
                movePiece(itemOne.fromLoc, itemOne.toLoc)
                
                if red1!.position.x == niceHitFromX && red1!.position.y == niceHitFromY { red1!.runAction(movePlayerNiceHit) }
                else if red2!.position.x == niceHitFromX && red2!.position.y == niceHitFromY { red2!.runAction(movePlayerNiceHit) }
                else if red3!.position.x == niceHitFromX && red3!.position.y == niceHitFromY { red3!.runAction(movePlayerNiceHit) }
                else if red4!.position.x == niceHitFromX && red4!.position.y == niceHitFromY { red4!.runAction(movePlayerNiceHit) }
                else if red5!.position.x == niceHitFromX && red5!.position.y == niceHitFromY { red5!.runAction(movePlayerNiceHit) }
                else if red6!.position.x == niceHitFromX && red6!.position.y == niceHitFromY { red6!.runAction(movePlayerNiceHit) }
                else if red7!.position.x == niceHitFromX && red7!.position.y == niceHitFromY { red7!.runAction(movePlayerNiceHit) }
                else if redBean!.position.x == niceHitFromX && redBean!.position.y == niceHitFromY { redBean!.runAction(movePlayerNiceHit) }
                
                if niceHitToX == blue1!.position.x && niceHitToY == blue1!.position.y { blue1!.opacity = 0; blue1!.runAction(takeOff) }
                else if niceHitToX == blue2!.position.x && niceHitToY == blue2!.position.y { blue2!.opacity = 0; blue2!.runAction(takeOff) }
                else if niceHitToX == blue3!.position.x && niceHitToY == blue3!.position.y { blue3!.opacity = 0; blue3!.runAction(takeOff) }
                else if niceHitToX == blue4!.position.x && niceHitToY == blue4!.position.y { blue4!.opacity = 0; blue4!.runAction(takeOff) }
                else if niceHitToX == blue5!.position.x && niceHitToY == blue5!.position.y { blue5!.opacity = 0; blue5!.runAction(takeOff) }
                else if niceHitToX == blue6!.position.x && niceHitToY == blue6!.position.y { blue6!.opacity = 0; blue6!.runAction(takeOff) }
                else if niceHitToX == blue7!.position.x && niceHitToY == blue7!.position.y { blue7!.opacity = 0; blue7!.runAction(takeOff) }
            }
                
            else if firstItemToTile == .BlueBean {
                blueCaptured -= 1
                print("During the bluebean capture, blueCaptured = \(blueCaptured)")
                blueBeanActive = false
                blueBean!.opacity = 0
                blueHome!.opacity = 0
                redBeanActive = true
                redHomeEffect!.runAction(popHome)
                redHome!.opacity = 1
                redBean!.opacity = 1
                getRedBean(itemOne.fromLoc, itemOne.toLoc)
                
                if red1!.position.x == niceHitFromX && red1!.position.y == niceHitFromY { red1!.runAction(takeOff) }
                else if red2!.position.x == niceHitFromX && red2!.position.y == niceHitFromY { red2!.runAction(takeOff) }
                else if red3!.position.x == niceHitFromX && red3!.position.y == niceHitFromY { red3!.runAction(takeOff) }
                else if red4!.position.x == niceHitFromX && red4!.position.y == niceHitFromY { red4!.runAction(takeOff) }
                else if red5!.position.x == niceHitFromX && red5!.position.y == niceHitFromY { red5!.runAction(takeOff) }
                else if red6!.position.x == niceHitFromX && red6!.position.y == niceHitFromY { red6!.runAction(takeOff) }
                else if red7!.position.x == niceHitFromX && red7!.position.y == niceHitFromY { red7!.runAction(takeOff) }
                
                redBean!.position.x = niceHitToX
                redBean!.position.y = niceHitToY
                redBean!.position.z = -1.5
            }
                
            else if firstItemToTile == .Bean {
                print("getting the bean")
                redBeanActive = true
                redHomeEffect!.runAction(popHome)
                redHome!.opacity = 1
                blueHome!.opacity = 0
                getRedBean(itemOne.fromLoc, itemOne.toLoc)
                
                if red1!.position.x == niceHitFromX && red1!.position.y == niceHitFromY { red1!.runAction(takeOff) }
                else if red2!.position.x == niceHitFromX && red2!.position.y == niceHitFromY { red2!.runAction(takeOff) }
                else if red3!.position.x == niceHitFromX && red3!.position.y == niceHitFromY { red3!.runAction(takeOff) }
                else if red4!.position.x == niceHitFromX && red4!.position.y == niceHitFromY { red4!.runAction(takeOff) }
                else if red5!.position.x == niceHitFromX && red5!.position.y == niceHitFromY { red5!.runAction(takeOff) }
                else if red6!.position.x == niceHitFromX && red6!.position.y == niceHitFromY { red6!.runAction(takeOff) }
                else if red7!.position.x == niceHitFromX && red7!.position.y == niceHitFromY { red7!.runAction(takeOff) }
                
                redBean!.position.x = niceHitToX
                redBean!.position.y = niceHitToY
                redBean!.position.z = -1.5
                newbean!.runAction(takeOff)
            }
                
            else if firstItemToTile == .Empty {
                print("going to an empty space")
                movePiece(picked.fromLoc, picked.toLoc)
                
                if red1!.position.x == hitFromX && red1!.position.y == hitFromY { red1!.runAction(movePlayer) }
                else if red2!.position.x == hitFromX && red2!.position.y == hitFromY { red2!.runAction(movePlayer) }
                else if red3!.position.x == hitFromX && red3!.position.y == hitFromY { red3!.runAction(movePlayer) }
                else if red4!.position.x == hitFromX && red4!.position.y == hitFromY { red4!.runAction(movePlayer) }
                else if red5!.position.x == hitFromX && red5!.position.y == hitFromY { red5!.runAction(movePlayer) }
                else if red6!.position.x == hitFromX && red6!.position.y == hitFromY { red6!.runAction(movePlayer) }
                else if red7!.position.x == hitFromX && red7!.position.y == hitFromY { red7!.runAction(movePlayer) }
                else if redBean!.position.x == hitFromX && redBean!.position.y == hitFromY { redBean!.runAction(movePlayer) }
            }
            
            
            if blueCaptured == 0 {
                if teachingPart == 2 {
                    teachScene() }
                else {
                    waitThenLose()
                }
            }
            print("checking if you lost")
            switch boardNumber {
            case 1, 2, 3 :
                if boardArray[2][1] == .RedBean {
                    sound1()
                    if teachingPart == 3 { menuScene() }
                    else { staticAI = true; waitThenLose() }
                }
            case 4, 5, 6, 7:
                if boardArray[3][1] == .RedBean {
                    sound1()
                    if teachingPart == 3 { menuScene() }
                    else { print("about to waitThenLose"); staticAI = true; waitThenLose() }
                }
            case 8, 9, 10:
                if boardArray[4][2] == .RedBean {
                    sound1()
                    if teachingPart == 3 { menuScene() }
                    else { staticAI = true; waitThenLose() }
                }
            default: print("default")
            }
            
            print("************************")
            print("**   end of move ai   **")
            print("************************")
            
            moveAI()
            
        } else {
            currentPlayer = "x"
            staticPlayer = false
        }
    }

    
    func getLimitedSouthMoves1(_: String) -> MoveList {
        var movePlans = Array<Move>()
        for x in 1..<cols {
            for y in 0..<rows {
                if boardArray[x][y] == .RedPiece || boardArray[x][y] == .RedBean {
                    let fromLoc = BoardLoc(x: x, y: y)
                    let rowCount = getRowCount(fromLoc)
                    
                    // south
                    if y + rowCount < rows {
                        let toLoc = BoardLoc(x: x, y: y + rowCount)
                        let toTile = boardArray[x][y + rowCount]
                        let nLimit = getNLimit(toLoc)
                        let sLimit = getSLimit(toLoc)
                        let wLimit = getWLimit(toLoc)
                        let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc)
                        let swLimit = getSWLimit(toLoc)
                        let seLimit = getSELimit(toLoc)
                        let neLimit = getNELimit(toLoc)
                        
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                }
            }
        }
        
        return MoveList(total: movePlans.count, moveArray: movePlans)
    }
    
    func getLimitedSouthMoves2(_: String) -> MoveList {
        var movePlans = Array<Move>()
        for x in 0..<cols {
            for y in 0..<6 {
                if boardArray[x][y] == .RedPiece || boardArray[x][y] == .RedBean {
                    let fromLoc = BoardLoc(x: x, y: y)
                    let rowCount = getRowCount(fromLoc)
                    
                    // south
                    if y + rowCount < rows {
                        let toLoc = BoardLoc(x: x, y: y + rowCount)
                        let toTile = boardArray[x][y + rowCount]
                        let nLimit = getNLimit(toLoc)
                        let sLimit = getSLimit(toLoc)
                        let wLimit = getWLimit(toLoc)
                        let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc)
                        let swLimit = getSWLimit(toLoc)
                        let seLimit = getSELimit(toLoc)
                        let neLimit = getNELimit(toLoc)
                        
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                }
            }
        }
        
        return MoveList(total: movePlans.count, moveArray: movePlans)
    }
    

    
    func getLimitedSouthMoves3(_: String) -> MoveList {
        print("************************* start getLimitedSouthMoves3 ************************")
        var movePlans = Array<Move>()
        for x in 0..<cols {
            for y in 0..<4 {
                if boardArray[x][y] == .RedPiece || boardArray[x][y] == .RedBean {
                    print("found a red")
                    let fromLoc = BoardLoc(x: x, y: y)
                    let rowCount = getRowCount(fromLoc)
                    
                    // south
                    if y + rowCount < rows {
                        let toLoc = BoardLoc(x: x, y: y + rowCount)
                        let toTile = boardArray[x][y + rowCount]
                        print("Looking south, toLoc = \(toLoc) and toTile = \(toTile)")
                        let nLimit = getNLimit(toLoc)
                        let sLimit = getSLimit(toLoc)
                        let wLimit = getWLimit(toLoc)
                        let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc)
                        let swLimit = getSWLimit(toLoc)
                        let seLimit = getSELimit(toLoc)
                        let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                }
            }
        }
        print("Inside the getAllMoves function, movePlans.count will be \(movePlans.count)")
        print("************************* end getSouthlMoves ************************")
        return MoveList(total: movePlans.count, moveArray: movePlans)
    }

    func getAllMoves(_: String) -> MoveList {
        print("***********************************")
        print("********* begin getAllMoves *******")
        print("***********************************")
        var movePlans = Array<Move>()
        for x in 0..<cols {
            for y in 0..<rows {
                if boardArray[x][y] == .RedPiece || boardArray[x][y] == .RedBean {
                    print("found a red")
                    let fromLoc = BoardLoc(x: x, y: y)
                    let rowCount = getRowCount(fromLoc)
                    print("fromLoc = \(fromLoc) and rowCount = \(rowCount)")
                    
                    // north
                    if y - rowCount >= 0 {
                        let toLoc = BoardLoc(x: x, y: y - rowCount)
                        let toTile = boardArray[x][y - rowCount]
                        print("Looking north, toLoc = \(toLoc) and toTile = \(toTile)")
                        
                        let nLimit = getNLimit(toLoc)
                        let sLimit = getSLimit(toLoc)
                        let wLimit = getWLimit(toLoc)
                        let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc)
                        let swLimit = getSWLimit(toLoc)
                        let seLimit = getSELimit(toLoc)
                        let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        } else { }
                    }
                    
                    // northwest
                    if x - rowCount >= 0 && y - rowCount >= 0 {
                        let toLoc = BoardLoc(x: x - rowCount, y: y - rowCount)
                        let toTile = boardArray[x - rowCount][y - rowCount]
                        print("Looking northwest, toLoc = \(toLoc) and toTile = \(toTile)")
                        
                        let nLimit = getNLimit(toLoc)
                        let sLimit = getSLimit(toLoc)
                        let wLimit = getWLimit(toLoc)
                        let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc)
                        let swLimit = getSWLimit(toLoc)
                        let seLimit = getSELimit(toLoc)
                        let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        } else { }
                    }
                    
                    // northeast
                    if x + rowCount < cols && y - rowCount >= 0 {
                        let toLoc = BoardLoc(x: x + rowCount, y: y - rowCount)
                        let toTile = boardArray[x + rowCount][y - rowCount]
                        print("Looking northeast, toLoc = \(toLoc) and toTile = \(toTile)")
                        let nLimit = getNLimit(toLoc)
                        let sLimit = getSLimit(toLoc)
                        let wLimit = getWLimit(toLoc)
                        let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc)
                        let swLimit = getSWLimit(toLoc)
                        let seLimit = getSELimit(toLoc)
                        let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        } else { }
                    }
                    
                    // south
                    if y + rowCount < rows {
                        let toLoc = BoardLoc(x: x, y: y + rowCount)
                        let toTile = boardArray[x][y + rowCount]
                        print("Looking south, toLoc = \(toLoc) and toTile = \(toTile)")
                        let nLimit = getNLimit(toLoc)
                        let sLimit = getSLimit(toLoc)
                        let wLimit = getWLimit(toLoc)
                        let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc)
                        let swLimit = getSWLimit(toLoc)
                        let seLimit = getSELimit(toLoc)
                        let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            print("and it should be blue")
                            print("so sending fromLoc = \(fromLoc) and toLoc = \(toLoc) as item 1 in the Move array.")
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            print("and it should be blueBean")
                            boardArray[x][y] = .RedBean
                            print("just set board\(x), \(y) as redBean")
                            print("so sending fromLoc = \(fromLoc) and toLoc = \(toLoc) as item 1 in the Move array.")
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            print("and it should be bean and blueBeanActive needs to be false for some reason.")
                            boardArray[x][y] = .RedBean
                            print("just set board\(x), \(y) as redBean")
                            print("so sending fromLoc = \(fromLoc) and toLoc = \(toLoc) as item 1 in the Move array.")
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            print("and it should be empty. Place fromLoc = \(fromLoc) and toLoc = \(toLoc) at the end of the Move array.")
                            movePlans.append(Move(fromLoc, toLoc))
                        } else { }
                    }
                    
                    // east
                    if x + rowCount < cols {
                        let toLoc = BoardLoc(x: x + rowCount, y: y)
                        let toTile = boardArray[x + rowCount][y]
                        print("Looking east, toLoc = \(toLoc) and toTile = \(toTile)")
                        let nLimit = getNLimit(toLoc)
                        let sLimit = getSLimit(toLoc)
                        let wLimit = getWLimit(toLoc)
                        let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc)
                        let swLimit = getSWLimit(toLoc)
                        let seLimit = getSELimit(toLoc)
                        let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        } else { }
                    }
                    
                    // west
                    if x - rowCount >= 0 {
                        let toLoc = BoardLoc(x: x - rowCount, y: y)
                        let toTile = boardArray[x - rowCount][y]
                        print("Looking west, toLoc = \(toLoc) and toTile = \(toTile)")
                        let nLimit = getNLimit(toLoc)
                        let sLimit = getSLimit(toLoc)
                        let wLimit = getWLimit(toLoc)
                        let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc)
                        let swLimit = getSWLimit(toLoc)
                        let seLimit = getSELimit(toLoc)
                        let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        } else { }
                    }
                    
                    // southwest
                    if x - rowCount >= 0 && y + rowCount < rows {
                        let toLoc = BoardLoc(x: x - rowCount, y: y + rowCount)
                        let toTile = boardArray[x - rowCount][y + rowCount]
                        print("Looking southwest, toLoc = \(toLoc) and toTile = \(toTile)")
                        let nLimit = getNLimit(toLoc)
                        let sLimit = getSLimit(toLoc)
                        let wLimit = getWLimit(toLoc)
                        let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc)
                        let swLimit = getSWLimit(toLoc)
                        let seLimit = getSELimit(toLoc)
                        let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        } else { }
                    }
                    
                    // southeast
                    if x + rowCount < cols && y + rowCount < rows {
                        let toLoc = BoardLoc(x: x + rowCount, y: y + rowCount)
                        let toTile = boardArray[x + rowCount][y + rowCount]
                        print("Looking southeast, toLoc = \(toLoc) and toTile = \(toTile)")
                        let nLimit = getNLimit(toLoc)
                        let sLimit = getSLimit(toLoc)
                        let wLimit = getWLimit(toLoc)
                        let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc)
                        let swLimit = getSWLimit(toLoc)
                        let seLimit = getSELimit(toLoc)
                        let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        } else { }
                    }
                }
            }
        }
        return MoveList(total: movePlans.count, moveArray: movePlans)
    }
    
    func getEastWestMoves(_: String) -> MoveList {
        var movePlans = Array<Move>()
        for x in 0..<cols {
            for y in 0..<rows {
                
                if boardArray[x][y] == .RedPiece {
                    let fromLoc = BoardLoc(x: x, y: y)
                    let rowCount = getRowCount(fromLoc)
                    
                    // east
                    if x + rowCount < cols {
                        let toLoc = BoardLoc(x: x + rowCount, y: y)
                        let toTile = boardArray[x + rowCount][y]
                        
                        let nLimit = getNLimit(toLoc); let sLimit = getSLimit(toLoc); let wLimit = getWLimit(toLoc); let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc); let swLimit = getSWLimit(toLoc); let seLimit = getSELimit(toLoc); let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                    
                    // west
                    if x - rowCount >= 0 {
                        let toLoc = BoardLoc(x: x - rowCount, y: y)
                        let toTile = boardArray[x - rowCount][y]
                        
                        let nLimit = getNLimit(toLoc); let sLimit = getSLimit(toLoc); let wLimit = getWLimit(toLoc); let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc); let swLimit = getSWLimit(toLoc); let seLimit = getSELimit(toLoc); let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                    
                    // northeast
                    if x + rowCount < cols && y - rowCount >= 0 {
                        let toLoc = BoardLoc(x: x + rowCount, y: y - rowCount)
                        let toTile = boardArray[x + rowCount][y - rowCount]
                        print("Looking northeast, toLoc = \(toLoc) and toTile = \(toTile)")
                        let nLimit = getNLimit(toLoc)
                        let sLimit = getSLimit(toLoc)
                        let wLimit = getWLimit(toLoc)
                        let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc)
                        let swLimit = getSWLimit(toLoc)
                        let seLimit = getSELimit(toLoc)
                        let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        } else { }
                    }
                }
            }
        }
        return MoveList(total: movePlans.count, moveArray: movePlans)
    }
    
    func getDownMoves(_: String) -> MoveList {
        var movePlans = Array<Move>()
        for x in 0..<cols {
            for y in 0..<rows {
                
                // if .Red
                if boardArray[x][y] == .RedPiece || boardArray[x][y] == .RedBean {
                    
                    // fromLoc is the location
                    let fromLoc = BoardLoc(x: x, y: y)
                    let rowCount = getRowCount(fromLoc)
                    
                    // south
                    if y + rowCount < rows {
                        let toLoc = BoardLoc(x: x, y: y + rowCount)
                        let toTile = boardArray[x][y + rowCount]
                        
                        let nLimit = getNLimit(toLoc)
                        let sLimit = getSLimit(toLoc)
                        let wLimit = getWLimit(toLoc)
                        let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc)
                        let swLimit = getSWLimit(toLoc)
                        let seLimit = getSELimit(toLoc)
                        let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                    
                    // southwest
                    if x - rowCount >= 0 && y + rowCount < rows {
                        let toLoc = BoardLoc(x: x - rowCount, y: y + rowCount)
                        let toTile = boardArray[x - rowCount][y + rowCount]
                        
                        let nLimit = getNLimit(toLoc)
                        let sLimit = getSLimit(toLoc)
                        let wLimit = getWLimit(toLoc)
                        let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc)
                        let swLimit = getSWLimit(toLoc)
                        let seLimit = getSELimit(toLoc)
                        let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                    
                    // southeast
                    if x + rowCount < cols && y + rowCount < rows {
                        let toLoc = BoardLoc(x: x + rowCount, y: y + rowCount)
                        let toTile = boardArray[x + rowCount][y + rowCount]
                        
                        let nLimit = getNLimit(toLoc)
                        let sLimit = getSLimit(toLoc)
                        let wLimit = getWLimit(toLoc)
                        let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc)
                        let swLimit = getSWLimit(toLoc)
                        let seLimit = getSELimit(toLoc)
                        let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                }
            }
        }
        return MoveList(total: movePlans.count, moveArray: movePlans)
    }
    
    func getLimitedDownMoves(_: String) -> MoveList {
        var movePlans = Array<Move>()
        for x in 0..<cols {
            for y in 0..<rows {
                
                // if .Red
                if boardArray[x][y] == .RedPiece || boardArray[x][y] == .RedBean {
                    
                    // fromLoc is the location
                    let fromLoc = BoardLoc(x: x, y: y)
                    let rowCount = getRowCount(fromLoc)
                    
                    // south
                    if y + rowCount < rows {
                        let toLoc = BoardLoc(x: x, y: y + rowCount)
                        let toTile = boardArray[x][y + rowCount]
                        
                        let nLimit = getNLimit(toLoc)
                        let sLimit = getSLimit(toLoc)
                        let wLimit = getWLimit(toLoc)
                        let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc)
                        let swLimit = getSWLimit(toLoc)
                        let seLimit = getSELimit(toLoc)
                        let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                    
                    // southwest
                    if x - rowCount >= 0 && y + rowCount < rows {
                        let toLoc = BoardLoc(x: x - rowCount, y: y + rowCount)
                        let toTile = boardArray[x - rowCount][y + rowCount]
                        
                        let nLimit = getNLimit(toLoc)
                        let sLimit = getSLimit(toLoc)
                        let wLimit = getWLimit(toLoc)
                        let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc)
                        let swLimit = getSWLimit(toLoc)
                        let seLimit = getSELimit(toLoc)
                        let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                    
                    // southeast
                    if x + rowCount < cols && y + rowCount < rows {
                        let toLoc = BoardLoc(x: x + rowCount, y: y + rowCount)
                        let toTile = boardArray[x + rowCount][y + rowCount]
                        
                        let nLimit = getNLimit(toLoc)
                        let sLimit = getSLimit(toLoc)
                        let wLimit = getWLimit(toLoc)
                        let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc)
                        let swLimit = getSWLimit(toLoc)
                        let seLimit = getSELimit(toLoc)
                        let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                }
            }
        }
        return MoveList(total: movePlans.count, moveArray: movePlans)
    }
    
    func getPrepareForHomingMoves(_: String) -> MoveList {
        var movePlans = Array<Move>()
        for x in 0..<cols {
            for y in 0..<rows {
                
                // if .Red
                if boardArray[x][y] == .RedPiece {
                    
                    // fromLoc is the location
                    let fromLoc = BoardLoc(x: x, y: y)
                    let rowCount = getRowCount(fromLoc)
                    
                    // south
                    if y + rowCount < rows {
                        let toLoc = BoardLoc(x: x, y: y + rowCount)
                        let toTile = boardArray[x][y + rowCount]
                        
                        let nLimit = getNLimit(toLoc)
                        let sLimit = getSLimit(toLoc)
                        let wLimit = getWLimit(toLoc)
                        let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc)
                        let swLimit = getSWLimit(toLoc)
                        let seLimit = getSELimit(toLoc)
                        let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                    
                    // southwest
                    if x - rowCount >= 0 && y + rowCount < rows {
                        let toLoc = BoardLoc(x: x - rowCount, y: y + rowCount)
                        let toTile = boardArray[x - rowCount][y + rowCount]
                        
                        let nLimit = getNLimit(toLoc)
                        let sLimit = getSLimit(toLoc)
                        let wLimit = getWLimit(toLoc)
                        let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc)
                        let swLimit = getSWLimit(toLoc)
                        let seLimit = getSELimit(toLoc)
                        let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                    
                    // southeast
                    if x + rowCount < cols && y + rowCount < rows {
                        let toLoc = BoardLoc(x: x + rowCount, y: y + rowCount)
                        let toTile = boardArray[x + rowCount][y + rowCount]
                        
                        let nLimit = getNLimit(toLoc)
                        let sLimit = getSLimit(toLoc)
                        let wLimit = getWLimit(toLoc)
                        let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc)
                        let swLimit = getSWLimit(toLoc)
                        let seLimit = getSELimit(toLoc)
                        let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                }
            }
        }
        return MoveList(total: movePlans.count, moveArray: movePlans)
    }
    
    func getHomingMoves(_: String) -> MoveList {
        print("Homing begin")
        var movePlans = Array<Move>()
        for x in 0..<cols {
            for y in 0..<rows {
                print("Homing2")
                if boardArray[x][y] == .RedBean {
                    print("Homing3")
                    let fromLoc = BoardLoc(x: x, y: y)
                    let rowCount = getRowCount(fromLoc)
                    print("Homing4")
                    // north
                    if y - rowCount >= 0 {
                        print("Homing5")
                        let toLoc = BoardLoc(x: x, y: y - rowCount)
                        let toTile = boardArray[x][y - rowCount]
                        let nLimit = getNLimit(toLoc); let sLimit = getSLimit(toLoc); let wLimit = getWLimit(toLoc); let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc); let swLimit = getSWLimit(toLoc); let seLimit = getSELimit(toLoc); let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                    
                    // northeast
                    if x + rowCount < cols && y - rowCount >= 0 {
                        print("Homing7")
                        let toLoc = BoardLoc(x: x + rowCount, y: y - rowCount)
                        let toTile = boardArray[x + rowCount][y - rowCount]
                        
                        let nLimit = getNLimit(toLoc); let sLimit = getSLimit(toLoc); let wLimit = getWLimit(toLoc); let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc); let swLimit = getSWLimit(toLoc); let seLimit = getSELimit(toLoc); let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                    
                    // northwest
                    if x - rowCount >= 0 && y - rowCount >= 0 {
                        print("Homing8")
                        let toLoc = BoardLoc(x: x - rowCount, y: y - rowCount)
                        let toTile = boardArray[x - rowCount][y - rowCount]
                        
                        let nLimit = getNLimit(toLoc); let sLimit = getSLimit(toLoc); let wLimit = getWLimit(toLoc); let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc); let swLimit = getSWLimit(toLoc); let seLimit = getSELimit(toLoc); let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                }
            }
        }
        return MoveList(total: movePlans.count, moveArray: movePlans)
    }
    
    func getUpMoves(_: String) -> MoveList {
        var movePlans = Array<Move>()
        for x in 0..<cols {
            for y in 0..<(rows - 2) {
                
                if boardArray[x][y] == .RedPiece || boardArray[x][y] == .RedBean {
                    let fromLoc = BoardLoc(x: x, y: y)
                    let rowCount = getRowCount(fromLoc)
                    
                    // north
                    if y - rowCount >= 0 {
                        let toLoc = BoardLoc(x: x, y: y - rowCount)
                        let toTile = boardArray[x][y - rowCount]
                        let nLimit = getNLimit(toLoc); let sLimit = getSLimit(toLoc); let wLimit = getWLimit(toLoc); let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc); let swLimit = getSWLimit(toLoc); let seLimit = getSELimit(toLoc); let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                    
                    // northwest
                    if x - rowCount >= 0 && y - rowCount >= 0 {
                        let toLoc = BoardLoc(x: x - rowCount, y: y - rowCount)
                        let toTile = boardArray[x - rowCount][y - rowCount]
                        
                        let nLimit = getNLimit(toLoc); let sLimit = getSLimit(toLoc); let wLimit = getWLimit(toLoc); let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc); let swLimit = getSWLimit(toLoc); let seLimit = getSELimit(toLoc); let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                    
                    // northeast
                    if x + rowCount < cols && y - rowCount >= 0 {
                        let toLoc = BoardLoc(x: x + rowCount, y: y - rowCount)
                        let toTile = boardArray[x + rowCount][y - rowCount]
                        
                        let nLimit = getNLimit(toLoc); let sLimit = getSLimit(toLoc); let wLimit = getWLimit(toLoc); let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc); let swLimit = getSWLimit(toLoc); let seLimit = getSELimit(toLoc); let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                    
                    // east
                    if x + rowCount < cols {
                        let toLoc = BoardLoc(x: x + rowCount, y: y)
                        let toTile = boardArray[x + rowCount][y]
                        
                        let nLimit = getNLimit(toLoc); let sLimit = getSLimit(toLoc); let wLimit = getWLimit(toLoc); let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc); let swLimit = getSWLimit(toLoc); let seLimit = getSELimit(toLoc); let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                    
                    // west
                    if x - rowCount >= 0 {
                        let toLoc = BoardLoc(x: x - rowCount, y: y)
                        let toTile = boardArray[x - rowCount][y]
                        
                        let nLimit = getNLimit(toLoc); let sLimit = getSLimit(toLoc); let wLimit = getWLimit(toLoc); let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc); let swLimit = getSWLimit(toLoc); let seLimit = getSELimit(toLoc); let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                }
            }
        }
        return MoveList(total: movePlans.count, moveArray: movePlans)
    }
    
    func getDirectUpMoves(_: String) -> MoveList {
        var movePlans = Array<Move>()
        for x in 0..<cols {
            for y in 0..<(rows - 2) {
                
                if boardArray[x][y] == .RedPiece || boardArray[x][y] == .RedBean {
                    let fromLoc = BoardLoc(x: x, y: y)
                    let rowCount = getRowCount(fromLoc)
                    
                    // north
                    if y - rowCount >= 0 {
                        let toLoc = BoardLoc(x: x, y: y - rowCount)
                        let toTile = boardArray[x][y - rowCount]
                        let nLimit = getNLimit(toLoc); let sLimit = getSLimit(toLoc); let wLimit = getWLimit(toLoc); let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc); let swLimit = getSWLimit(toLoc); let seLimit = getSELimit(toLoc); let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                    
                    // northwest
                    if x - rowCount >= 0 && y - rowCount >= 0 {
                        let toLoc = BoardLoc(x: x - rowCount, y: y - rowCount)
                        let toTile = boardArray[x - rowCount][y - rowCount]
                        
                        let nLimit = getNLimit(toLoc); let sLimit = getSLimit(toLoc); let wLimit = getWLimit(toLoc); let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc); let swLimit = getSWLimit(toLoc); let seLimit = getSELimit(toLoc); let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                    
                    // northeast
                    if x + rowCount < cols && y - rowCount >= 0 {
                        let toLoc = BoardLoc(x: x + rowCount, y: y - rowCount)
                        let toTile = boardArray[x + rowCount][y - rowCount]
                        
                        let nLimit = getNLimit(toLoc); let sLimit = getSLimit(toLoc); let wLimit = getWLimit(toLoc); let eLimit = getELimit(toLoc)
                        let nwLimit = getNWLimit(toLoc); let swLimit = getSWLimit(toLoc); let seLimit = getSELimit(toLoc); let neLimit = getNELimit(toLoc)
                        if fromLoc.y < toLoc.y && fromLoc.x == toLoc.x && toLoc.x == nLimit.x && fromLoc.y < nLimit.y ||
                            fromLoc.y > toLoc.y && fromLoc.x == toLoc.x && toLoc.x == sLimit.x && fromLoc.y > sLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x < toLoc.x && fromLoc.x < wLimit.x && toLoc.y == wLimit.y ||
                            fromLoc.y == toLoc.y && fromLoc.x > toLoc.x && fromLoc.x > eLimit.x && toLoc.y == eLimit.y { break }
                        if fromLoc.x < toLoc.x && fromLoc.y < toLoc.y && fromLoc.x < nwLimit.x && fromLoc.y < nwLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y > toLoc.y && fromLoc.x > seLimit.x && fromLoc.y > seLimit.y ||
                            fromLoc.x < toLoc.x && fromLoc.y > toLoc.y && fromLoc.x < swLimit.x && fromLoc.y > swLimit.y ||
                            fromLoc.x > toLoc.x && fromLoc.y < toLoc.y && fromLoc.x > neLimit.x && fromLoc.y < neLimit.y { break }
                        
                        if toTile == .BluePiece {
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .BlueBean {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Bean && blueBeanActive == false {
                            boardArray[x][y] = .RedBean
                            movePlans.insert(Move(fromLoc, toLoc), atIndex:0)
                        } else if toTile == .Empty {
                            movePlans.append(Move(fromLoc, toLoc))
                        }
                    }
                }
            }
        }
        return MoveList(total: movePlans.count, moveArray: movePlans)
    }
    
    func getRowCount(selLoc:BoardLoc) -> Int {
        var rowCount = 0
        var sameRow = selLoc
        for i in 0..<cols {
            sameRow.x = i
            let sameRowTile = getTile(sameRow)
            if sameRowTile == .BluePiece || sameRowTile == .BlueBean || sameRowTile == .RedPiece || sameRowTile == .RedBean {
                rowCount += 1
            }
        }
        return (rowCount)
    }
    
    func getNLimit(selLoc:BoardLoc) -> BoardLoc {
        var nLimit = selLoc
        nLimit.y = selLoc.y - 1
        if nLimit.y == -1 { nLimit.y = 0 }
        while nLimit.y >= 0 {
            if getTile(nLimit) == .RedPiece || getTile(nLimit) == .BluePiece || getTile(nLimit) == .BlueBean || getTile(nLimit) == .RedBean { break }
            nLimit.y -= 1
        }
        return (nLimit)
    }
    
    func getSLimit(selLoc:BoardLoc) -> BoardLoc {
        var sLimit = selLoc
        sLimit.y = selLoc.y + 1
        if sLimit.y == rows { sLimit.y = rows - 1 }
        while sLimit.y < rows - 1 {
            if getTile(sLimit) == .RedPiece || getTile(sLimit) == .BluePiece || getTile(sLimit) == .BlueBean || getTile(sLimit) == .RedBean { break }
            sLimit.y += 1
        }
        return (sLimit)
    }
    
    func getWLimit(selLoc:BoardLoc) -> BoardLoc {
        var wLimit = selLoc
        wLimit.x = selLoc.x - 1
        if wLimit.x == -1 { wLimit.x = 0 }
        while wLimit.x > 0 {
            if getTile(wLimit) == .RedPiece || getTile(wLimit) == .BluePiece || getTile(wLimit) == .BlueBean || getTile(wLimit) == .RedBean { break }
            wLimit.x -= 1
        }
        return (wLimit)
    }
    
    func getELimit(selLoc:BoardLoc) -> BoardLoc {
        var eLimit = selLoc
        eLimit.x = selLoc.x + 1
        if eLimit.x == cols { eLimit.x = cols - 1 }
        while eLimit.x < cols - 1 {
            if getTile(eLimit) == .RedPiece || getTile(eLimit) == .BluePiece || getTile(eLimit) == .BlueBean || getTile(eLimit) == .RedBean { break }
            eLimit.x += 1
        }
        return (eLimit)
    }
    
    func getNWLimit(selLoc:BoardLoc) -> BoardLoc {
        var nwLimit = selLoc
        nwLimit.x = selLoc.x - 1
        nwLimit.y = selLoc.y - 1
        if nwLimit.y == -1 {  nwLimit.y = 0; nwLimit.x += 1 }
        while nwLimit.x > 0 && nwLimit.y > 0 {
            if getTile(nwLimit) == .RedPiece || getTile(nwLimit) == .BluePiece || getTile(nwLimit) == .BlueBean || getTile(nwLimit) == .RedBean { break }
            nwLimit.x -= 1; nwLimit.y -= 1
        }
        return (nwLimit)
    }
    
    func getSWLimit(selLoc:BoardLoc) -> BoardLoc {
        var swLimit = selLoc
        swLimit.x = selLoc.x - 1
        swLimit.y = selLoc.y + 1
        if swLimit.x == -1 { swLimit.x = 0
            swLimit.y -= 1 }
        while swLimit.x > 0 && swLimit.y < rows - 1 {
            if getTile(swLimit) == .RedPiece || getTile(swLimit) == .BluePiece || getTile(swLimit) == .BlueBean || getTile(swLimit) == .RedBean { break }
            swLimit.x -= 1; swLimit.y += 1
        }
        return (swLimit)
    }
    
    func getSELimit(selLoc:BoardLoc) -> BoardLoc {
        var seLimit = selLoc
        seLimit.x = selLoc.x + 1
        seLimit.y = selLoc.y + 1
        if seLimit.x == cols { seLimit.x = cols - 1
            seLimit.y -= 1 }
        while seLimit.x < cols - 1 && seLimit.y < rows - 1 {
            if getTile(seLimit) == .RedPiece || getTile(seLimit) == .BluePiece || getTile(seLimit) == .BlueBean || getTile(seLimit) == .RedBean { break }
            seLimit.x += 1; seLimit.y += 1
        }
        return (seLimit)
    }
    
    func getNELimit(selLoc:BoardLoc) -> BoardLoc {
        var neLimit = selLoc
        neLimit.x = selLoc.x + 1
        neLimit.y = selLoc.y - 1
        if neLimit.y == -1 { neLimit.y = 0; neLimit.x -= 1 }
        while (neLimit.x < cols - 1 && neLimit.y > 0) {
            if getTile(neLimit) == .RedPiece || getTile(neLimit) == .BluePiece || getTile(neLimit) == .BlueBean || getTile(neLimit) == .RedBean { break }
            neLimit.x += 1; neLimit.y -= 1
        }
        return (neLimit)
    }
    
    func getTile(tap: BoardLoc) -> PieceType {
        return boardArray[tap.x][tap.y]
    }
    
    func movePiece(fromLoc: BoardLoc, _ toLoc: BoardLoc) {
        boardArray[toLoc.x][toLoc.y] = boardArray[fromLoc.x][fromLoc.y]
        boardArray[fromLoc.x][fromLoc.y] = .Empty
    }
    
    func getBlueBean(fromLoc: BoardLoc, _ toLoc: BoardLoc) {
        boardArray[toLoc.x][toLoc.y] = .BlueBean
        boardArray[fromLoc.x][fromLoc.y] = .Empty
    }
    
    func getRedBean(fromLoc: BoardLoc, _ toLoc: BoardLoc) {
        boardArray[toLoc.x][toLoc.y] = .RedBean
        boardArray[fromLoc.x][fromLoc.y] = .Empty
    }
    
    func sound1() {
        if sfxVol == 1 { fingerTap!.volume = 0.00001; fingerTap!.play() }
        if sfxVol == 2 { fingerTap!.volume = 0.1; fingerTap!.play() }
        if sfxVol == 3 { fingerTap!.volume = 0.5; fingerTap!.play() }
        if sfxVol == 4 { fingerTap!.volume = 1.0; fingerTap!.play() }
    }
    
    func balalaikaSound() { ibalalaika!.currentTime = 0
        if sfxVol == 1 { ibalalaika!.volume = 0.00001; ibalalaika!.play() }
        if sfxVol == 2 { ibalalaika!.volume = 0.1; ibalalaika!.play() }
        if sfxVol == 3 { ibalalaika!.volume = 0.5; ibalalaika!.play() }
        if sfxVol == 4 { ibalalaika!.volume = 1.0; ibalalaika!.play() }
    }
    
    func didgeridooSound() { ididgeridoo!.currentTime = 0
        if sfxVol == 1 { ididgeridoo!.volume = 0.00001; ididgeridoo!.play() }
        if sfxVol == 2 { ididgeridoo!.volume = 0.1; ididgeridoo!.play() }
        if sfxVol == 3 { ididgeridoo!.volume = 0.5; ididgeridoo!.play() }
        if sfxVol == 4 { ididgeridoo!.volume = 1.0; ididgeridoo!.play() }
    }
    
    func xylophoneSound() { ixylophone!.currentTime = 0
        if sfxVol == 1 { ixylophone!.volume = 0.00001; ixylophone!.play() }
        if sfxVol == 2 { ixylophone!.volume = 0.1; ixylophone!.play() }
        if sfxVol == 3 { ixylophone!.volume = 0.5; ixylophone!.play() }
        if sfxVol == 4 { ixylophone!.volume = 1.0; ixylophone!.play() }
    }
    
    func moogSound() { imoog!.currentTime = 0
        if sfxVol == 1 { imoog!.volume = 0.00001; imoog!.play() }
        if sfxVol == 2 { imoog!.volume = 0.1; imoog!.play() }
        if sfxVol == 3 { imoog!.volume = 0.5; imoog!.play() }
        if sfxVol == 4 { imoog!.volume = 1.0; imoog!.play() }
    }
    
    func accordianSound() { iaccordian!.currentTime = 0
        if sfxVol == 1 { iaccordian!.volume = 0.00001; iaccordian!.play() }
        if sfxVol == 2 { iaccordian!.volume = 0.1; iaccordian!.play() }
        if sfxVol == 3 { iaccordian!.volume = 0.5; iaccordian!.play() }
        if sfxVol == 4 { iaccordian!.volume = 1.0; iaccordian!.play() }
    }
    
    func glassharmonicaSound() { iglassharmonica!.currentTime = 0
        if sfxVol == 1 { iglassharmonica!.volume = 0.00001; iglassharmonica!.play() }
        if sfxVol == 2 { iglassharmonica!.volume = 0.1; iglassharmonica!.play() }
        if sfxVol == 3 { iglassharmonica!.volume = 0.5; iglassharmonica!.play() }
        if sfxVol == 4 { iglassharmonica!.volume = 1.0; iglassharmonica!.play() }
    }
    
    func zuesophoneSound() { izuesophone!.currentTime = 0
        if sfxVol == 1 { izuesophone!.volume = 0.00001; izuesophone!.play() }
        if sfxVol == 2 { izuesophone!.volume = 0.1; izuesophone!.play() }
        if sfxVol == 3 { izuesophone!.volume = 0.5; izuesophone!.play() }
        if sfxVol == 4 { izuesophone!.volume = 1.0; izuesophone!.play() }
    }
    
    func trumpetSound() { itrumpet!.currentTime = 0
        if sfxVol == 1 { itrumpet!.volume = 0.00001; itrumpet!.play() }
        if sfxVol == 2 { itrumpet!.volume = 0.1; itrumpet!.play() }
        if sfxVol == 3 { itrumpet!.volume = 0.5; itrumpet!.play() }
        if sfxVol == 4 { itrumpet!.volume = 1.0; itrumpet!.play() }
    }
    
    func organSound() { iorgan!.currentTime = 0
        if sfxVol == 1 { iorgan!.volume = 0.00001; iorgan!.play() }
        if sfxVol == 2 { iorgan!.volume = 0.1; iorgan!.play() }
        if sfxVol == 3 { iorgan!.volume = 0.5; iorgan!.play() }
        if sfxVol == 4 { iorgan!.volume = 1.0; iorgan!.play() }
    }
    
    func cowbellSound() { icowbell!.currentTime = 0
        if sfxVol == 1 { icowbell!.volume = 0.00001; icowbell!.play() }
        if sfxVol == 2 { icowbell!.volume = 0.1; icowbell!.play() }
        if sfxVol == 3 { icowbell!.volume = 0.5; icowbell!.play() }
        if sfxVol == 4 { icowbell!.volume = 1.0; icowbell!.play() }
    }
    
    func browserViewControllerDidFinish(browserViewController: MCBrowserViewController) {
        appDelegate.mpcHandler.browser.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController) {
        appDelegate.mpcHandler.browser.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func shouldAutorotate() -> Bool { return true }
    
    override func prefersStatusBarHidden() -> Bool { return true  }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown }
        else { return .All }
    }
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
}
