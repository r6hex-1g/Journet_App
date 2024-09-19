import SwiftUI

struct HHeaderView: View {
    var size: CGSize
    var safeArea: EdgeInsets
    
    var body: some View {
        let screenHeight = size.height + safeArea.top + safeArea.bottom
        let minimisedHeight = screenHeight * 0.4
        
        ScrollView(.horizontal) {
            LazyHStack(alignment: .bottom, spacing: 0) {
                // MARK: - Grid MapView
                GridMapView()
                    .frame(width: size.width)
                
                Group {
                    StrechableView(.blue)
                    StrechableView(.yellow)
                    StrechableView(.cyan)
                }
                .frame(height: screenHeight - minimisedHeight)
            }
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .frame(height: screenHeight)
        .frame(height: screenHeight - minimisedHeight, alignment: .bottom)
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
        }
        .defaultScrollAnchor(.bottom)
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
