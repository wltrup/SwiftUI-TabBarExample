import SwiftUI

struct BarItem: Identifiable {

    let id = UUID()
    var title: String?
    var image: UIImage?
    var tag: Int = 0

    init(
        title: String? = nil,
        image: UIImage?,
        tag: Int = 0
    ) {
        self.title = title
        self.image = image
        self.tag = tag
    }

}
