//
//  ContentView.swift
//  LANTest
//
//  Created by Owen Hildreth on 7/21/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var controller: MultimeterController
    
    var body: some View {
        VStack(alignment: .leading) {
            connectView()
            measureView()
            Divider()
            Text(controller.details).textSelection(.enabled)
                .frame(minHeight: 100, alignment: .top)
        }.padding()
    }
    
    // MARK: - Measaure View
    @ViewBuilder
    func measureView() -> some View {
        HStack {
            Text("Current Voltage = \(controller.measuredVoltage ?? Double.nan)")
            Button(action: controller.updateMeasuredVoltage) {
                Image(systemName: "arrow.clockwise")
            }
        }
    }
    
    
    // MARK: - Connect View
    @ViewBuilder
    func connectView() -> some View {
        HStack {
            Text("IP Address")
            TextField("IP Address", text: $controller.IPaddress, prompt: Text(controller.IPaddress))
                .frame(width: 100)
            Text("Port")
            TextField("Port", value: $controller.port, format: numberFormat).frame(width: 100)
            Button(action: controller.connect) {
                Image(systemName: "arrow.clockwise").foregroundColor(colorForStatus(controller.connectionStatus))
            }
            Spacer()
        }
    }
    
    var numberFormat: IntegerFormatStyle<Int> {
        IntegerFormatStyle.number.grouping(.never)
        
    }
    
    // MARK: - Connection Status View
    func colorForStatus(_ status: ConnectionStatus) -> Color {
        var baseColor: Color = .red
        
        switch status {
        case .disconnected:
            baseColor = .red
        case .connecting:
            baseColor = .yellow
        case .connected:
            baseColor = .green
        }
        
        
        return baseColor
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let controller = MultimeterController()
        ContentView(controller: controller)
    }
}
