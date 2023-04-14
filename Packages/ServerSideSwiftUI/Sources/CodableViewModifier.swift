//
//  CodableViewModifier.swift
//  
//
//  Created by Vadim Temnogrudov on 14.04.2023.
//

import Foundation
import SwiftUI

public enum CodableViewModifier {
    case padding(CodablePadding)
    case background(CodableBackground)
    
    @ViewBuilder
    func applyModifier<Content: View>(content: Content) -> some View {
        switch self {
        case .padding(let codablePadding):
            content.modifier(codablePadding)
        case .background(let background):
            content.modifier(background)
        }
    }
}


extension CodableViewModifier: Decodable {
    enum CodingKeys: CodingKey {
        case type
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
        case "padding":
            self = .padding(try CodablePadding(from: decoder))
        case "background":
            self = .background(try CodableBackground(from: decoder))
        default:
            fatalError("Unknown Type received")
        }
    }
}

