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
        self = .leading
    }
}
