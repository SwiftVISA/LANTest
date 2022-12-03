//
//  MultimeterController_ActorVersion.swift
//  LANTest
//
//  Created by Owen Hildreth on 7/29/22.
//

import Foundation
import CoreSwiftVISA

public actor MultimeterController_Actor {
    var IPaddress = "169.254.10.1"
    var port = 5025
    

    private var instrumentManager: InstrumentManager?
    
    private var instrument: MessageBasedInstrument?
    
    private func makeInstrument() throws {
        
        if instrumentManager == nil {
            instrumentManager = InstrumentManager.shared
        }
        
        instrument = try instrumentManager?.instrumentAt(address: IPaddress, port: port)
        
    }
    
    
}

protocol MultimeterControllerDelegate {
    @MainActor
    func updateDetail(_ value: Int)
}
