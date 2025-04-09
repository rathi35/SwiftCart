//
//  SplashScreenView.swift
//  SwiftCart
//
//  Created by Rathi Shetty on 09/04/25.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive: Bool = false
    @State private var scale: CGFloat = 0.6
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                LinearGradient(
                    gradient: Gradient(
                        colors: [.pink.opacity(0.5), .purple.opacity(0.5)]
                    ),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ).ignoresSafeArea()
                
                Image( uiImage: UIImage(named: "logo")!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .scaleEffect(scale)
                    .onAppear {
                        withAnimation(.easeOut(duration: 1.2)) {
                            self.scale = 1.0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isActive = true
                            }
                        }
                    }
            }
        }
    }
}
