import SwiftUI

@Observable
class SharedData {
    var activePage: Int = 1
    var isExpanded: Bool = false
    var mainOffset: CGFloat = 0
    var gridScrollOffset: CGFloat = 0
    var selectedCategory: String = "Years"
    var canPullUp: Bool = false
    var canPullDown: Bool = false
    var progress: CGFloat = 0
}
