import SwiftUI

struct LoginView: View {
    @State private var mail: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 20) {
                LHeaderView()
                VStack(spacing: -10) {
                    LoginEmail(mail: self.$mail)
                    LoginPassword(password: self.$password)
                }
            }
            Spacer()
            VStack(spacing: 0) {
                LFooterView()
                guestActionTextButton()
            }
        }
        .padding(.horizontal, 40.0)
    }
}

//MARK: - Header Views
struct LHeaderView: View {
    let biggerText = Font.system(size: 37.5)
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "building.2.fill")
                .resizable()
                .foregroundColor(Color("MainColor"))
                .frame(width: 80, height: 80)
                .scaledToFit()
            VStack(alignment: .leading, spacing: 10.0) {
                VStack(alignment: .leading, spacing: -5.0) {
                    HStack(spacing: 3) {
                        Text("Journet")
                            .font(.Hanbit37)
                            .foregroundColor(Color("MainColor"))
                        Text("에")
                            .font(.Hanbit37)
                    }
                    Text("로그인 하기.")
                        .font(.Hanbit37)
                }
                Text("로그인 하고 Journet의 일기 세상으로 떠나기.")
                    .font(.Hanbit23)
            }
        }
    }
}

//MARK: - Footer Views
struct LFooterView: View {
    @State private var showTabbarView: Bool = false
    
    var body: some View {
        if showTabbarView {
            LoginView()
                .fullScreenCover(isPresented: $showTabbarView, content: {
                    //
                })
        }
        
        Button("로그인하기", systemImage: "arrow.right") {
            showTabbarView = true
        }
        
        .frame(maxWidth: .infinity)
        .buttonStyle(ButtonPrimaryStyle.init(isLoading: .constant(false)))
        .padding(.vertical, 20.0)
        .transition(.LmoveAndFade)
        .font(.Hanbit17)
    }
}

//MARK: - Button Style
struct LButtonPrimaryStyle: ButtonStyle {
    @Binding var isLoading: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(isLoading ? Color.accentColor.opacity(0.4) : configuration.isPressed ? Color.accentColor.opacity(1) : Color.accentColor.opacity(0.95))
            .cornerRadius(5)
            .scaleEffect(configuration.isPressed ? 0.99 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

//MARK: - Guest Action Text Button
struct guestActionTextButton: View {
    @State private var showTabbarViews: Bool = false
    
    var body: some View {
        if showTabbarViews {
            LoginView()
                .fullScreenCover(isPresented: $showTabbarViews, content: {
                    //
                })
        }
        
        Button("게스트로 계속하기") {
            showTabbarViews = true
        }
        .foregroundColor(Color("MainColor"))
        .font(.Hanbit17)
    }
}

//MARK: - Custom Transition
extension AnyTransition {
    static var LmoveAndFade: AnyTransition {
        .asymmetric(
            insertion: .offset(y: 70)
                .combined(with: opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
}

#Preview {
    LoginView()
}

