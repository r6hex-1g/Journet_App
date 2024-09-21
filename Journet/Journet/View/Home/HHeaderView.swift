import SwiftUI

struct HHeaderView: View {
    var size: CGSize
    var safeArea: EdgeInsets
    @Environment(SharedData.self) private var sharedData
    @State private var scrollPosition: ScrollPosition = .init()
    
    var body: some View {
        let screenHeight = size.height + safeArea.top + safeArea.bottom
        let minimisedHeight = screenHeight * 0.4
        
        ScrollView(.horizontal) {
            LazyHStack(alignment: .bottom, spacing: 0) {
                // MARK: - Grid MapView
                GridMapView()
                    .frame(width: size.width)
                    .id(1)
                
                Group {
                    StrechableView(.blue)
                        .id(2)
                    StrechableView(.yellow)
                        .id(3)
                    StrechableView(.cyan)
                        .id(4)
                }
                .frame(height: screenHeight - minimisedHeight)
            }
            .padding(.bottom, safeArea.bottom + 20)
            .scrollTargetLayout()
            .offset(y: sharedData.canPullUp ? sharedData.gridScrollOffset : 0)
        }
        .scrollClipDisabled()
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .scrollPosition(id: .init(get: {
            return sharedData.activePage
        }, set: {
            if let newwValue = $0 {
                sharedData.activePage = newwValue
            }
        }))
        
        .scrollDisabled(sharedData.isExpanded)
        .frame(height: screenHeight)
        .frame(height: screenHeight - (minimisedHeight - (minimisedHeight * sharedData.progress)), alignment: .bottom)
        .overlay(alignment: .bottom) {
            CustomPagingIndicatorView {
                Task {
                    if sharedData.gridScrollOffset != 0 {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            scrollPosition.scrollTo(edge: .bottom)
                        }
                        try? await Task.sleep(for: .seconds(0.13))
                    }
                    withAnimation(.easeInOut(duration: 0.25)) {
                        sharedData.progress = 0
                        sharedData.isExpanded = false
                    }
                }
            }
        }
    }
    
    //MARK: - Grid Views
    @ViewBuilder
    func GridMapView() -> some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 4), count: 3), spacing: 4) {
                ForEach(0...300, id:\.self) { _ in
                    Rectangle()
                        .fill(.red)
                        .frame(height: 120)
                }
            }
            .scrollTargetLayout()
            .offset(y: sharedData.progress * -(safeArea.bottom + 20))
        }
        .defaultScrollAnchor(.bottom)
        .scrollDisabled(!sharedData.isExpanded)
        .scrollPosition($scrollPosition)
        .scrollClipDisabled()
        .onScrollGeometryChange(for: CGFloat.self, of: {
            $0.contentOffset.y - $0.contentSize.height + $0.containerSize.height
        }, action: { oldValue, newValue in
            sharedData.gridScrollOffset = newValue
        })
    }
    
    //MARK: - Paging Views
    func StrechableView(_ color: Color) -> some View {
        GeometryReader {
            let minY = $0.frame(in: .scrollView(axis: .vertical)).minY
            let size = $0.size
            
            Rectangle()
                .fill(color)
                .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0))
                .offset(y: (minY > 0 ? -minY : 0))
        }
        .frame(width: size.width)
    }
}

#Preview {
    ContentView()
}
