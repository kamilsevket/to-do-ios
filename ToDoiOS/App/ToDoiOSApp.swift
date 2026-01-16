import SwiftUI
import SwiftData

@main
struct ToDoiOSApp: App {
    @State private var gamificationViewModel = GamificationViewModel()

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            TodoItem.self,
            UserProfile.self,
            Achievement.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    initializeData()
                }
                .overlay {
                    if gamificationViewModel.showLevelUpCelebration {
                        LevelUpView(level: gamificationViewModel.newLevel) {
                            gamificationViewModel.showLevelUpCelebration = false
                        }
                    }
                }
        }
        .modelContainer(sharedModelContainer)
        .environment(gamificationViewModel)
    }

    private func initializeData() {
        let context = sharedModelContainer.mainContext
        gamificationViewModel.initializeProfile(context: context)
        gamificationViewModel.initializeAchievements(context: context)
    }
}
