import SwiftUI

struct OtherContentsView: View {
    var body: some View {
        VStack(spacing: 10) {
            DummyView("Albums", .yellow)
            DummyView("Peoples", .blue)
            DummyView("Memories", .cyan)
            DummyView("Location", .purple)
            DummyView("Screenshot", .pink)
        }
        .safeAreaPadding(.horizontal, 10)
        .background(.gray.opacity(0.2))
    }
    
    //MARK: - Title and Horizontal ScrollView
    @ViewBuilder
    func DummyView(_ title: String, _ color: Color) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                
            } label: {
                HStack(spacing: 6) {
                    Text(title)
                        .font(.title3.bold())
                        .foregroundStyle(Color.primary)
                    
                    Image(systemName: "chevron.right")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                }
            }
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 10) {
                    ForEach(1...10, id:\.self) { _ in
                        RoundedRectangle(cornerRadius: 15)
                            .fill(color)
                            .frame(width: 220, height: 120)
                    }
                }
                .padding(.vertical, 10)
            }
        }
        .scrollIndicators(.hidden)
        .safeAreaPadding(.horizontal, 15)
        .padding(.top, 15)
    }
}

#Preview {
    ContentView()
}
