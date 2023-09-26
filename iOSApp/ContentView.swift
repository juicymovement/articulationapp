import SwiftUI

struct ContentView: View {
    @State private var bufferLength: Int = 0
    
    var body: some View {
        Text("Buffer Length: \(bufferLength)")
            .onAppear {
                self.bufferLength = ViewController.shared.fetchBufferLength()  // Fetch from ViewController
            }
    }
}
