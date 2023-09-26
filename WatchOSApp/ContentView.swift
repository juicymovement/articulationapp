import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Start") {
                InterfaceController.shared.startRecording()  // Call startRecording from InterfaceController
            }
            Button("Stop") {
                InterfaceController.shared.stopRecording()  // Call stopRecording from InterfaceController
            }
        }
    }
}
