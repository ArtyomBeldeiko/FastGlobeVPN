//
//  ContentView.swift
//  FastGlobeVPN
//
//  Created by Artyom Beldeiko on 27.09.22.
//

import SwiftUI
import NetworkExtension

struct MainView: View {
    
    @State var isConnected = false
    
    var body: some View {
        VStack {
            Image("disconnectedLabel")
                .resizable()
                .scaledToFit()
                .frame(width: 230)
            
            Image("disconnectButton")
                .resizable()
                .scaledToFit()
                .frame(width: 250)
            
            Spacer()
                .frame(height: 70)
            
            Button {
                isConnected.toggle()
                VPNHandler.connectVPN()
            } label: {
                Text("Connect now")
                    .font(.title)
                    .fontWeight(.regular)
                    .frame(width: 200, height: 42)
                    .foregroundColor(.white)
            }
            .tint(Color(uiColor: UIColor(red: 0/255, green: 148/255, blue: 252/255, alpha: 1)))
            .buttonStyle(.borderedProminent)
            .cornerRadius(40)
            .shadow(color: .black.opacity(0.8), radius: 4, x: -2 ,y: 1)
            .fullScreenCover(isPresented: $isConnected) {
                ConnectedView()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
