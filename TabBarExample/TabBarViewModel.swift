import Foundation

final class TabBarViewModel: ObservableObject {

    @Published private(set) var items: [BarItem]
    @Published private(set) var indexOfSelectedItem: Int

    init(items: [BarItem] = [], indexOfSelectedItem: Int = 0) {
        self.items = items
        self.indexOfSelectedItem = indexOfSelectedItem
    }

    func select(_ item: BarItem) {
        self.indexOfSelectedItem = item.tag
    }

    var selectedItem: BarItem {
        items[indexOfSelectedItem]
    }

}
