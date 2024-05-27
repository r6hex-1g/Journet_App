import SwiftUI

struct TabbarView: View {
    //MARK: - View Properties
    @State private var activeTab: Tab = .Home
    
    //MARK: - All Tab's
    @State private var allTabs: [AnimatedTab] = Tab.allCases.compactMap { tab -> AnimatedTab? in
        return .init(tab: tab)
    }
    
    //MARK: - Bounce Property
    @State private var bouncesDown: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activeTab) {
                MapView()
                    .setUpTab(.anotherDiaries)
                
                HomeView()
                    .setUpTab(.Home)
                
                ProfileView()
                    .setUpTab(.profiles)
            }
            CustomTabBar()
        }
    }
    
    //MARK: - Custom Tab Bar
    func CustomTabBar() -> some View {
        HStack(spacing: -30) {
            ForEach($allTabs) { $animatedTab in
                let tab = animatedTab.tab
                
                VStack(spacing: 4) {
                    Image(systemName: tab.rawValue)
                        .font(.title2)
                        .symbolEffect(.bounce.up.byLayer, value: animatedTab.isAnimateing)
                    
                    Text(tab.title)
                        .font(.callout)
                        .textScale(.secondary)
                }
                
                .frame(maxWidth: .infinity)
                .foregroundStyle(activeTab == tab ? Color("MainColor") : Color.gray.opacity(0.8))
                .padding(.top, 20)
                .padding(.bottom, 10)
                .contentShape(.rect)
                
                //MARK: - use Button
                .onTapGesture {
                    withAnimation(.bouncy, completionCriteria: .logicallyComplete, {
                        activeTab = tab
                        animatedTab.isAnimateing = true
                    }, completion: {
                        var trasnaction = Transaction()
                        trasnaction.disablesAnimations = true
                        withTransaction(trasnaction) {
                            animatedTab.isAnimateing = nil
                        }
                    })
                }
            }
        }
        .background(.bar)
    }
}

extension View {
    @ViewBuilder
    func setUpTab(_ tab: Tab) -> some View {
        self
            .frame(maxWidth: .infinity)
            .tag(tab)
            .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    ContentView()
}
