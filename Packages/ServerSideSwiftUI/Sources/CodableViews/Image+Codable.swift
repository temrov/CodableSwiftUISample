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
    
    var url: String
    let aspectRatio: CGFloat?
    let contentMode: ContentMode?
    
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
