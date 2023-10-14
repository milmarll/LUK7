//
//  SplashScreenView.swift
//  LUK7
//
//  Created by Marlon De Jesus Milanes Rivero on 6/4/23.
//

import SwiftUI

struct SplashScreenContent: View {

    @Environment(\.managedObjectContext) private var viewContext
    @State private var isActive: Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    var body: some View {
        Group {
            if !isActive {
                VStack {
                    Image("luk7")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .cornerRadius(100)
                        .clipShape(Circle())

                    Text("LUK7")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                .scaleEffect(0.9)
                .opacity(1.00)
            } else {
                ContentView()
                    .environment(\.managedObjectContext, viewContext)
            }
        }.onAppear(perform: {
            startSplashAnimation()
        })
    }

    private func startSplashAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeIn(duration: 1.2)) {
                self.size = 0.9
                self.opacity = 1.00
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}
