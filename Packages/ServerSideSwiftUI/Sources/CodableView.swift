import Foundation
import SwiftUI

public protocol CodableViewVariant: Decodable {
}

public enum CodableView {
    case list(CodableList, [CodableViewModifier])
    case text(CodableText, [CodableViewModifier])
    case button(CodableButton, [CodableViewModifier])
    case image(CodableImage, [CodableViewModifier])
    case vStack(CodableVStack, [CodableViewModifier])
    case hStack(CodableHStack, [CodableViewModifier])
    case color(CodableColor, [CodableViewModifier])
}

extension CodableView: Decodable {
    enum CodingKeys: CodingKey {
        case type, modifiers
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        let modifiers = try container.decodeIfPresent([CodableViewModifier].self, forKey: .modifiers) ?? []
        switch type {
        case "list":
            self = .list(try CodableList(from: decoder), modifiers)
        case "text":
            self = .text(try CodableText(from: decoder), modifiers)
        case "button":
            self = .button(try CodableButton(from: decoder), modifiers)
        case "image":
            self = .image(try CodableImage(from: decoder), modifiers)
        case "vStack":
            self = .vStack(try CodableVStack(from: decoder), modifiers)
        case "hStack":
            self = .hStack(try CodableHStack(from: decoder), modifiers)
        case "color":
            self = .color(try CodableColor(from: decoder), modifiers)
        default:
            fatalError("Unknown Type received")
        }
    }
}
