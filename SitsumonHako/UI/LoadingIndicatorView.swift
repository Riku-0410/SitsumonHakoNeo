//
//  LoadingIndicatorView.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/15.
//

import Foundation
import SwiftUI

struct LoadingIndicatorView: View {
    @State private var isAnimating = false
    private let animation = Animation.linear(duration: 1).repeatForever(autoreverses: false)

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.black)
                    .opacity(0.01)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .edgesIgnoringSafeArea(.all)
//                    .disabled(self.isLoading)
                Circle()
                    .trim(from: 0, to: 0.6)
                    .stroke(AngularGradient(gradient: Gradient(colors: [.gray, .white]), center: .center),
                            style: StrokeStyle(
                                lineWidth: 8,
                                lineCap: .round,
                                dash: [0.1, 16],
                                dashPhase: 8))
                    .frame(width: 48, height: 48)
                    .rotationEffect(.degrees(self.isAnimating ? 360 : 0))
                    // ②アニメーションの実装
                    .onAppear() {
                        print("LoadingIndicatorAppear")
                        withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                            self.isAnimating = true
                        }
                    }
                    .onDisappear() {
                        print("Disappear")
                        self.isAnimating = false
                    }
            }
        }
    }
}
