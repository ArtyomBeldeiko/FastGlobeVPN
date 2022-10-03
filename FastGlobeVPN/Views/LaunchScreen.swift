//
//  LaunchScreen.swift
//  FastGlobeVPN
//
//  Created by Artyom Beldeiko on 29.09.22.
//

import SwiftUI

struct LaunchScreen: View {
    
    @State private var isShowingMainView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("lauchScreenBackgroundImage")
                    .resizable()
                    .frame(width: 300, height: 400, alignment: .center)
                    .scaledToFit()
                
                Spacer()
                    .frame(height: 70)
                
                Text("RELIABLE, FAST AND SECURE")
                    .font(.title3)
                    .fontWeight(.heavy)
                
                Spacer()
                    .frame(height: 10)
                
                Group {
                    Text("You are using FastGlobeVPN.\nTo proceed please press")
                        .font(.callout) +
                    Text(" Continue")
                        .font(.callout)
                        .fontWeight(.bold) +
                    Text(" button.")
                }
                .multilineTextAlignment(.center)
                
                Spacer()
                    .frame(height: 30)
                
                Button {
                    isShowingMainView = true
                } label: {
                    Text("Continue")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(Color(.white))
                        .padding()
                        .frame(width: 300)
                }
                
                .background(RoundedRectangle(cornerRadius: 26, style: .circular))
                .navigationDestination(isPresented: $isShowingMainView) {
                    MainView()
                        .navigationBarBackButtonHidden()
                }
            }
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
