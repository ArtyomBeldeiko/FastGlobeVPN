//
//  ConnectedView.swift
//  FastGlobeVPN
//
//  Created by Artyom Beldeiko on 30.09.22.
//

import SwiftUI

struct ConnectedView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Image("connectedLabel")
                .resizable()
                .scaledToFit()
                .frame(width: 230)
            
            Image("connectButton")
                .resizable()
                .scaledToFit()
                .frame(width: 250)
            
            Spacer()
                .frame(height: 70)
            
            Button {
                dismiss()
            } label: {
                Text("Disconnect")
                    .font(.title)
                    .fontWeight(.regular)
                    .frame(width: 200, height: 42)
                    .foregroundColor(.black)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 1.5))
                    .shadow(color: .black.opacity(0.4), radius: 4, x: -2 ,y: 1)
            }
        }
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
      }
}

struct ConnectedView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectedView()
    }
}
