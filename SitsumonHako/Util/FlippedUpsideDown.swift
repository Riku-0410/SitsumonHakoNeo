//
//  FlippedUpsideDown.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/03.
//


import SwiftUI

struct FlippedUpsideDown: ViewModifier {
   func body(content: Content) -> some View {
    content
        .rotationEffect(.radians(.pi))
      .scaleEffect(x: -1, y: 1, anchor: .center)
   }
}
extension View{
   func flippedUpsideDown() -> some View{
     self.modifier(FlippedUpsideDown())
   }
}
