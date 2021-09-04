//
//  Extension.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/04.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(
            red: Double(CGFloat(r)) / 0xff,
            green: Double(CGFloat(g)) / 0xff,
            blue: Double(CGFloat(b)) / 0xff
        )
    }
}
