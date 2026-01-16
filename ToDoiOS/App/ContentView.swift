import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var profiles: [UserProfile]
    @Environment(GamificationViewModel.self) private var gamificationViewModel

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
        .tint(.blue)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [TodoItem.self, UserProfile.self, Achievement.self], inMemory: true)
        .environment(GamificationViewModel())
}
