import SwiftUI

//MARK: - Tab's
enum Tab: String, CaseIterable {
    case anotherDiaries = "book.pages.fill"
    case Home = "map.fill"
    case profiles = "person.crop.circle"
    
    var title: String {
           switch self {
           case .anotherDiaries:
               return "핫플레이스"
           case .Home:
               return "홈"
           case .profiles:
               return "내 정보"
           }
       }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}


//MARK: - Animated SF Tab Model
struct AnimatedTab: Identifiable {
    var id: UUID = .init()
    var tab: Tab
    var isAnimateing: Bool?
}
