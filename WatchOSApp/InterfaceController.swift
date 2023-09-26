import WatchKit
import Foundation
import AVFoundation
import Speech

class InterfaceController: WKInterfaceController {
    static let shared = InterfaceController()  // Singleton instance
    var audioEngine: AVAudioEngine!
    var speechRecognizer: SFSpeechRecognizer!
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest!
    var recognitionTask: SFSpeechRecognitionTask!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setupSpeech()
    }
    
    func setupSpeech() {
        audioEngine = AVAudioEngine()
        speechRecognizer = SFSpeechRecognizer()
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    }
    
    func startRecording() throws {
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            if let result = result {
                // Handle the speech recognition result
            }
        })
        
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
    }
    
    func stopRecording() {
        audioEngine.stop()
        recognitionRequest.endAudio()
        recognitionTask?.cancel()
    }
}
