import SwiftUI

struct TabBarView: View {

    @ObservedObject private var viewModel: TabBarViewModel

    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            HStack(alignment: .lastTextBaseline) {
                Spacer()
                ForEach(self.viewModel.items) { item in
                    Button(action: { self.viewModel.select(item) }) {
                        VStack {
                            if item.image != nil {
                                Image(uiImage: item.image!)
                                    .renderingMode(.template)
                            }
                            if item.title != nil {
                                Text(item.title!)
                            }
                        }
                    }
                    .padding(.horizontal, self.buttonHorizPadding)
                    .frame(height: self.buttonHeight)
                    Spacer()
                }
            }
        }
        .frame(height: barHeight)
    }

    private let barHeight: CGFloat = 60
    private let buttonHeight: CGFloat = 70
    private let buttonHorizPadding: CGFloat = 7

}

extension TabBarView {

    private func itemIsSelected(_ item: BarItem) -> Bool {
        viewModel.indexOfSelectedItem == item.tag
    }

}
