import Foundation
import SwiftUI

public struct CodableButton: View, CodableViewVariant {
    public var id: UUID = UUID()
    var content: String
    
    enum CodingKeys: CodingKey {
        case id
        case content
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.content = try container.decode(String.self, forKey: .content)
    }
    public var body: some View {
        Button(content) {
            print("\(content) pressed")
        }
    }
}
