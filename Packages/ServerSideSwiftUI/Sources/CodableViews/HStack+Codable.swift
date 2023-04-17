//
//  CodableHStack.swift
//  
//
//  Created by Vadim Temnogrudov on 17.04.2023.
//

import SwiftUI

public struct CodableHStack: View, CodableViewVariant {
    
    var alignment: VerticalAlignment
    var spacing: CGFloat?
    var views: [CodableView]

    public var body: some View {
        HStack(alignment: alignment, spacing: spacing) {
            ForEach(views.indices, id: \.self) { ViewFactory.view(for: views[$0]) }
        }
    }
}

extension VerticalAlignment: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawAlignment = try container.decode(String.self)
        switch rawAlignment {
        case "center":
            self = .center
        case "top":
            self = .top
        case "bottom":
            self = .bottom
        case "firstTextBaseline":
            self = .firstTextBaseline
        case "lastTextBaseline":
            self = .lastTextBaseline
        default:
            self = .center
        }
    }
}
