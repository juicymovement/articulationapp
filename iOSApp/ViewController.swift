import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    static let shared = ViewController()  // Singleton instance
    var audioBuffer: [(Date, Data)] = []
    var bufferCleanupTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWatchConnectivity()
        setupBufferCleanupTimer()
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
        while audioBuffer.count > 5 {
            audioBuffer.removeFirst()
        }
    }
    
    func setupBufferCleanupTimer() {
        bufferCleanupTimer = Timer.scheduledTimer(timeInterval: 300, target: self, selector: #selector(clearBuffer), userInfo: nil, repeats: true)
    }
    
    @objc func clearBuffer() {
        audioBuffer.removeAll()
    }
}
