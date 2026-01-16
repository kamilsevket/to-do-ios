import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TodoListView()
                .tabItem {
                    Label(String(localized: "tab.tasks"), systemImage: "checklist")
                }

            AchievementsView()
                .tabItem {
                    Label(String(localized: "tab.rewards"), systemImage: "trophy.fill")
                }

            ProfileView()
                .tabItem {
                    Label(String(localized: "tab.profile"), systemImage: "person.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
