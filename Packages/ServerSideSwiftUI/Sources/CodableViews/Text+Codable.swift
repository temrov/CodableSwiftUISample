import Foundation
import SwiftUI

public struct CodableText: View, CodableViewVariant {
    public var id: UUID = UUID()
    var alignment: TextAlignment
    var content: String
    var lineLimit: Int?
    var fontSize: CGFloat?
    enum CodingKeys: String, CodingKey {
        case id
        case alignment
        case content
        case lineLimit
        case fontSize
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.alignment = try container.decode(TextAlignment.self, forKey: .alignment)
        self.content = try container.decode(String.self, forKey: .content)
        self.lineLimit = try container.decodeIfPresent(Int.self, forKey: .lineLimit)
        self.fontSize = try container.decodeIfPresent(CGFloat.self, forKey: .fontSize)
    }
    
    public var body: some View {
        Text(content)
            .lineLimit(lineLimit)
            .multilineTextAlignment(alignment)
            .font(.system(size: fontSize ?? 14))
    }
}
