import SwiftUI

struct TabBarView: View {

    @ObservedObject private var viewModel: TabBarViewModel

    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack(alignment: .animatedCenterAlignment) {
            Rectangle()
                .fill(Color.green)
                .frame(width: buttonWidth)
                .animatedCenterAlignment()
                .animation(.spring(dampingFraction: animatedCenterAlignmentSpringDampingFraction))
            HStack(alignment: .lastTextBaseline) {
                Spacer()
                ForEach(viewModel.items) { item in
                    if self.itemIsSelected(item) {
                        self.button(for: item)
                            .animatedCenterAlignment()
                    } else {
                        self.button(for: item)
                    }
                    Spacer()
                }
                Spacer()
            }
        }
        .frame(height: barHeight)
    }

    private let barHeight: CGFloat = 60
    private let buttonWidth: CGFloat = 70
    private let buttonHeight: CGFloat = 60
    private let buttonHorizPadding: CGFloat = 7
    private let animatedCenterAlignmentSpringDampingFraction: Double = 0.6

}

extension TabBarView {

    private func itemIsSelected(_ item: BarItem) -> Bool {
        viewModel.indexOfSelectedItem == item.tag
    }

    private func button(for item: BarItem) -> some View {
        Button(action: {
            if self.itemIsSelected(item) == false {
                self.viewModel.select(item)
            }
        }) {
            VStack {
                if item.image != nil {
                    Image(uiImage: item.image!)
                }
                if item.title != nil {
                    Text(item.title!)
                }
            }
        }
        .frame(width: buttonWidth, height: buttonHeight)
    }

}

// MARK: - Animated alignment support

extension HorizontalAlignment {
    private enum HA: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[HorizontalAlignment.center]
        }
    }
    fileprivate static let ha = HorizontalAlignment(HA.self)
}

extension Alignment {
    fileprivate static let animatedCenterAlignment = Alignment(horizontal: .ha, vertical: .center)
}

private struct AlignmentModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.alignmentGuide(.ha, computeValue: { viewDims in
            viewDims[HorizontalAlignment.center]
        })
    }
}

extension View {
    fileprivate func animatedCenterAlignment() -> some View {
        self.modifier(AlignmentModifier())
    }
}
