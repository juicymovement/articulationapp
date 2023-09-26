import Foundation

class AudioBufferManager {
    var audioBuffer: [(Date, Data)] = []
    let bufferLength = 5 * 60 // 5 minutes * 60 seconds
    
    func storeAudio(audioData: Data) {
        let currentTime = Date()
        audioBuffer.append((currentTime, audioData))
        
        // Remove old data if buffer exceeds length
        while audioBuffer.count > bufferLength {
            audioBuffer.removeFirst()
        }
    }
}
