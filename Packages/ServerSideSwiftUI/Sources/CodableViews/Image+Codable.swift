//
//  Image+Codable.swift
//  My360iDevApp
//
//  Created by Florian Harr on 8/21/21.
//

import Foundation
import SDWebImageSwiftUI
import SwiftUI

public struct CodableImage: View, CodableViewVariant {
    public var id: UUID = UUID()
    var url: String
    let aspectRatio: CGFloat?
    let contentMode: ContentMode?

    enum CodingKeys: String, CodingKey {
        case id
        case url
        case aspectRatio
        case contentMode
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.url = try container.decode(String.self, forKey: .url)
        self.aspectRatio = try container.decodeIfPresent(CGFloat.self, forKey: .aspectRatio)
        self.contentMode = try container.decodeIfPresent(ContentMode.self, forKey: .contentMode)
    }
    
    public var body: some View {
        WebImage(url: URL(string: url)!)
            .resizable(resizingMode: .stretch)
            .aspectRatio(aspectRatio, contentMode: contentMode ?? .fit)
    }
}

extension ContentMode: Decodable {
    public init(from decoder: Decoder) throws {
        self = .fit
    }
    
    
}
