import SwiftUI

//MARK: - Views setup
struct HomeView: View {
    var size: CGSize
    var safeArea: EdgeInsets
    var sharedData = SharedData()
    
    var body: some View {
        let minimisedHeight = (size.height + safeArea.top + safeArea.bottom) * 0.4
        let mainOffset = sharedData.mainOffset
        
        ScrollView(.vertical) {
            VStack(spacing: 10) {
                HHeaderView(size: size, safeArea: safeArea)
                OtherContentsView()
                    .padding(.top, -30)
                    .offset(y: sharedData.progress * 30)
            }
            .offset(y: sharedData.canPullDown ? 0 : mainOffset < 0 ? -mainOffset : 0)
            .offset(y: mainOffset < 0 ? mainOffset : 0)
        }
        .onScrollGeometryChange(for: CGFloat.self, of: {
            $0.contentOffset.y
        }, action: { oldValue, newValue in
            sharedData.mainOffset = newValue
        })
        .scrollDisabled(sharedData.isExpanded)
        .environment(sharedData)
        .gesture(
            CustomGestue(isEnabled: sharedData.activePage == 1) { gesture in
                let state = gesture.state
                let translation = gesture.translation(in: gesture.view).y
                let isScrolling = state == .began || state == .changed
                
                if state == .began {
                    sharedData.canPullDown = translation > 0 && sharedData.mainOffset == 0
                    sharedData.canPullUp = translation < 0 && sharedData.gridScrollOffset == 0
                }
                
                if isScrolling {
                    if sharedData.canPullDown && sharedData.isExpanded {
                        let progress = max(min(translation / minimisedHeight, 1), 0)
                        sharedData.progress = progress
                    }
                    
                    if sharedData.canPullUp && sharedData.isExpanded {
                        let progress = max(min(-translation / minimisedHeight, 1), 0)
                        sharedData.progress = 1 - progress
                    }
                } else {
                    withAnimation(.smooth(duration: 0.35, extraBounce: 0)) {
                        if sharedData.canPullDown && !sharedData.isExpanded {
                            if translation > 0 {
                                sharedData.isExpanded = true
                                sharedData.progress = 1
                            }
                        }
                        
                        if sharedData.canPullUp && sharedData.isExpanded {
                            if translation < 0 {
                                sharedData.isExpanded = false
                                sharedData.progress = 0
                            }
                        }
                    }
                }
            }
        )
        .background(.gray.opacity(0.05))
    }
}

//MARK: - Previews
#Preview {
    ContentView()
}
