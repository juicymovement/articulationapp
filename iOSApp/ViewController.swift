import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    var audioBuffer: [(Date, Data)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWatchConnectivity()
    }
    
    func setupWatchConnectivity() {
        if WCSession.default.isReachable {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        updateAudioBuffer(with: messageData)
    }
    
    func updateAudioBuffer(with newData: Data) {
        let currentTime = Date()
        audioBuffer.append((currentTime, newData))
        
        // Remove old data if buffer exceeds length
        while audioBuffer.count > bufferLength {
            audioBuffer.removeFirst()
        }
    }
}
