//
//  SwiftUIView.swift
//  
//
//  Created by Vadim Temnogrudov on 14.04.2023.
//

import SwiftUI

public protocol ColorFactory {
    func color(name: String) -> Color?
}

public struct CodableColor: View, CodableViewVariant {
    public static var namedColors: ColorFactory?

    @Environment(\.colorScheme) var colorScheme

    let model: ColorModel
    
    enum CodingKeys: String, CodingKey {
        case model
    }
    
    public var body: Color {
        resultColor()
    }
    
    private func resultColor() -> Color {
        switch model {
        case .name(let colorName):
            return Self.namedColors?.color(name: colorName) ?? .clear
        case .hex(let light, let dark, let alpha, let darkAlpha):
            if let dark, colorScheme == .dark {
                return Color(rgb: dark, alpha: darkAlpha)
            }
            return Color(rgb: light, alpha: alpha)
        }
    }
}

extension Color {
    init(rgb: UInt32, alpha: Double = 1) {
        let maxColor: Double = 255
        let blue = rgb & 0xFF
        let green =  (rgb >> 8) & 0xFF
        let red =  (rgb >> 16) & 0xFF
        
        self.init(red: Double(red) / maxColor,
                  green: Double(green) / maxColor,
                  blue: Double(blue) / maxColor,
                  opacity: alpha)
    }
}

public enum ColorModel {
    case name(String)
    case hex(light: UInt32, dark: UInt32?, alpha: Double = 1, darkAlpha: Double = 1)
}

extension ColorModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case name, light, dark, alpha, darkAlpha
    }
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            let value = try container.decode(String.self)
            guard !value.isEmpty else {
                throw NSError()
            }
            if let hexValue = UInt32(hexColor: value) {
                self = .hex(light: hexValue, dark: nil)
                return
            }
            self = .name(value)
        }
        catch {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            if let name = try container.decodeIfPresent(String.self, forKey: .name) {
                self = .name(name)
                return
            }
            let light = try container.decode(String.self, forKey: .light)
            let dark = try container.decodeIfPresent(String.self, forKey: .dark)
            let alpha = try container.decodeIfPresent(Double.self, forKey: .alpha)
            let darkAlpha = try container.decodeIfPresent(Double.self, forKey: .darkAlpha)
            self = .hex(light: UInt32(hexColor: light) ?? 0, dark: UInt32(hexColor: dark ?? ""), alpha: alpha ?? 1, darkAlpha: darkAlpha ?? alpha ?? 1)
        }
    }
}

extension UInt32 {
    init?(hexColor: String) {
        var cString:String = hexColor.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        guard cString.hasPrefix("#") else {
            return nil
        }
        cString.remove(at: cString.startIndex)

        guard cString.count == 6 else {
            return nil
        }
        self.init(cString, radix: 16)
    }
}
