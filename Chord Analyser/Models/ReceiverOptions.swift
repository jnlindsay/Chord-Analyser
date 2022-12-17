/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A model describing the MIDI output destination.
*/

import Foundation
import SwiftUI

class ReceiverOptions: Identifiable, ObservableObject {
    
    let id = UUID()

    @Published var destinationName: String = "Test Destination"
    @Published var protocolID: Int32 = MIDIProtocolID._1_0.rawValue
    var createMIDIInputPort: (() -> Void)? = nil
    
}
