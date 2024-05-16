import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage("isLogin") var isLogin: Bool = false
    @AppStorage("selectedTab") var selectedTab : Tab = .home
    @Environment(\.colorScheme) private var scheme
    @EnvironmentObject var vm: TableListViewModel
   
    
    @State private var showSignup: Bool = false
    
    var body: some View {
        
        
        if isLogin && vm.user.id != 0 {
                TabView (selection: $selectedTab){
                    NavigationStack{
                        HomeView()
                    }.tabItem {
                        Label("Home", systemImage: "house")
                    }.tag(Tab.home)
                    
                    NavigationStack{
                        MyBookingView()
                    }.tabItem {
                        Label("Table Reservation", systemImage: "calendar.badge.clock")
                    }.tag(Tab.task)
                }
            }else{
                NavigationStack {
                    LoginView(showSignup: $showSignup)
                        .navigationDestination(isPresented: $showSignup) {
                            SignupView(showSignup: $showSignup)
                        }
                }
            }
    
    }
    
}

extension ContentView {
    
    private func tabSelection() -> Binding<Tab> {
        Binding { //this is the get block
            self.selectedTab
        } set: { tappedTab in
            //            if tappedTab == self.selectedTab {
            //                //User tapped on the tab twice == Pop to root view
            //                if homeNavigationStack.isEmpty {
            //                    //User already on home view, scroll to top
            //                } else {
            //                    homeNavigationStack = []
            //                }
            //            }
            //Set the tab to the tabbed tab
            self.selectedTab = tappedTab
            print(self.selectedTab)
        }
    }
}

struct ToastView<Presenting>: View where Presenting: View {
    var presenting: Presenting
    var message: String
    @Binding var show: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                Text(message)
                    .foregroundColor(Color.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(15)
                    .padding(.bottom, 40)
                    .frame(width: geometry.size.width, alignment: .center)
                    .transition(.move(edge: .bottom))
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottom)
            .offset(y: show ? 0 : geometry.size.height)
        }
    }
}

#Preview {
    ContentView()
    
}
