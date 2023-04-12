import Foundation
import SwiftUI

public struct CodableList: View, CodableViewVariant {
    public var id: UUID
    var views: [CodableView]
    
    enum CodingKeys: String, CodingKey {
        case id
        case views = "components"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.views = try container.decode([CodableView].self, forKey: .views)
    }
    
    public var body: some View {
        List {
            ForEach(views, id: \.id) {
                ViewFactory.view(for: $0)
            }
        }
    }
}
