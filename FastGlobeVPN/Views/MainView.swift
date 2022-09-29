//
//  ContentView.swift
//  FastGlobeVPN
//
//  Created by Artyom Beldeiko on 27.09.22.
//

import SwiftUI

struct MainView: View {
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
