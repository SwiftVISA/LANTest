//
//  MultimeterController.swift
//  LANTest
//
//  Created by Owen Hildreth on 7/21/22.
//

import Foundation
import SwiftVISASwift


class MultimeterController: ObservableObject {
    
    private var instrumentManager: InstrumentManager?
    
    private var instrument: MessageBasedInstrument?
    
    @Published var IPaddress = "169.254.10.1"
    @Published var port = 5025
    
    @Published var measuredVoltage: Double? = nil
    @Published var setVoltage = 0.0
    
    @Published var details: String = ""
    
    @Published var connectionStatus: ConnectionStatus = .disconnected
    
    @Published var continuouslyMeasure = false
    
    init() {
        //connect()
    }
    
    private func makeInstrument() throws {
        
        if instrumentManager == nil {
            instrumentManager = InstrumentManager.shared
        }
        
        instrument = try instrumentManager?.instrumentAt(address: IPaddress, port: port)
        
    }
    
    func updateMeasuredVoltage() {
        do {
            measuredVoltage = try instrument?.query("SOURCE:VOLTAGE?", as: Double.self)
            print("Measured voltage = \(String(describing: measuredVoltage))")
        } catch {
            print("Could not measure voltage")
            print(error)
        }
    }
    
    private func updateSetVoltage() {
        do {
            try instrument?.write("SOURCE:VOLTAGE: \(setVoltage)")
        } catch {
            
            print("Could not update the voltage")
            print(error)
        }
    }
    
    func getInfo() {
        do {
            let localDetails = try instrument?.query("*IDN?") ?? ""
            details = localDetails.replacingOccurrences(of: ",", with: "\n")
        } catch  {
            print("Could not get instrument information")
            print(error)
        }
    }
    
    func connect() {
        do {
            connectionStatus = .connecting
            try makeInstrument()
        } catch  {
            connectionStatus = .disconnected
            print("Could not connect to instrument at: \(IPaddress) on port: \(port)")
            print(error)
        }
        
        print("instrument connected: \(String(describing: instrument))")
        connectionStatus = .connected
        updateMeasuredVoltage()
        getInfo()
    }
    
    func continuousUpdate() {
        
    }
    
    
    
}

enum ConnectionStatus: Identifiable, CaseIterable {
    var id: Self { self }
    
    case disconnected
    case connecting
    case connected
}
