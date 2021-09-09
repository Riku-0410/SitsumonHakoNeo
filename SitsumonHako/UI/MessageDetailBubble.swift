//
//  MessageDetailBubble.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/03.
//

import SwiftUI

struct MessageDetailBubble: Shape {
    func path(in rect: CGRect) -> Path{
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners:[.topLeft, .topRight, .bottomLeft,.bottomRight], cornerRadii: CGSize(width: 10, height:10))
        
        return Path(path.cgPath)
    }
}

