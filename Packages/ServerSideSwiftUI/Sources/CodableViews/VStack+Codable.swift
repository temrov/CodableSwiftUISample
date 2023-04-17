//
//  VStack+Codable.swift
//  My360iDevApp
//
//  Created by Florian Harr on 8/21/21.
//

import Foundation
import SwiftUI

public struct CodableVStack: View, CodableViewVariant {
    
    var alignment: HorizontalAlignment
    var spacing: CGFloat?
    var views: [CodableView]

    public var body: some View {
        
        VStack(alignment: alignment, spacing: spacing) {
            ForEach(views.indices, id: \.self) { ViewFactory.view(for: views[$0]) }
        }
    }
}

extension HorizontalAlignment: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawAlignment = try container.decode(String.self)
        switch rawAlignment {
        case "center":
            self = .center
        case "leading":
            self = .leading
        case "trailing":
            self = .trailing
        case "listRowSeparatorLeading":
            if #available(iOS 16.0, *) {
                self = .listRowSeparatorLeading
            } else {
                // Fallback on earlier versions
                self = .leading
            }
        case "listRowSeparatorTrailing":
            if #available(iOS 16.0, *) {
                self = .listRowSeparatorTrailing
            } else {
                // Fallback on earlier versions
                self = .trailing
            }
        default:
            self = .center
        }
    }
}
