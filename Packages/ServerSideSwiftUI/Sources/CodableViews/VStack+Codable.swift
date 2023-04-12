//
//  VStack+Codable.swift
//  My360iDevApp
//
//  Created by Florian Harr on 8/21/21.
//

import Foundation
import SwiftUI

public struct CodableVStack: View, CodableViewVariant {
    public var id: UUID = UUID()
    var alignment: HorizontalAlignment
    var spacing: CGFloat?
    var views: [CodableView]
    
    enum CodingKeys: String, CodingKey {
        case id
        case alignment
        case spacing
        case views = "components"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.alignment = try container.decode(HorizontalAlignment.self, forKey: .alignment)
        self.spacing = try container.decodeIfPresent(CGFloat.self, forKey: .spacing)
        self.views = try container.decode([CodableView].self, forKey: .views)
    }
    
    public var body: some View {
        
        VStack(alignment: alignment, spacing: spacing) {
            ForEach(views, id: \.id) { ViewFactory.view(for: $0) }
        }
    }
}

extension HorizontalAlignment: Decodable {
    public init(from decoder: Decoder) throws {
        self = .leading
    }
}
