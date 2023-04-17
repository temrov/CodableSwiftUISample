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
        if let colorName = model.name {
            return Self.namedColors?.color(name: colorName) ?? .clear
        }
        if colorScheme == .dark, let darkRGB = model.dark {
            return Color(rgb: darkRGB, alpha: model.alpha ?? 1)
        }
        if let lightRGB = model.light {
            return Color(rgb: lightRGB, alpha: model.alpha ?? 1)
        }
        return Color.clear
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

struct ColorModel {
    
    let name: String?
    let light: UInt32?
    let dark: UInt32?
    let alpha: Double?
    
}

extension ColorModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case name, light, dark, alpha
    }
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            let value = try container.decode(String.self)
            guard !value.isEmpty else {
                throw NSError()
            }
            if let hexValue = UInt32(hexColor: value) {
                self.init(name: nil, light: hexValue, dark: nil, alpha: nil)
                return
            }
            self.init(name: value, light: nil, dark: nil, alpha: nil)
            
        }
        catch {
            throw error
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
