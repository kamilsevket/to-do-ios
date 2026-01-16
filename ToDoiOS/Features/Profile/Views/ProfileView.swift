import SwiftUI
import SwiftData

struct ProfileView: View {
    @Query private var profiles: [UserProfile]
    @Query private var todos: [TodoItem]
    @Query private var achievements: [Achievement]

    private var profile: UserProfile? { profiles.first }
    private var completedTodos: [TodoItem] { todos.filter { $0.isCompleted } }
    private var unlockedAchievements: [Achievement] { achievements.filter { $0.isUnlocked } }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    profileHeader

                    statsSection

                    recentActivitySection
                }
                .padding()
            }
            .navigationTitle("Profile")
            .background(Color(.systemGroupedBackground))
        }
    }

    private var profileHeader: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 100, height: 100)

                Text("Lv")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                    .offset(y: -10)

                Text("\(profile?.level ?? 1)")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .offset(y: 10)
            }

            Text("\(profile?.totalPoints ?? 0) Points")
                .font(.title3.bold())

            if let profile = profile {
                HStack(spacing: 4) {
                    Image(systemName: "flame.fill")
                        .foregroundColor(.orange)
                    Text("\(profile.currentStreak) day streak")
                        .foregroundColor(.secondary)
                }
                .font(.subheadline)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var statsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Statistics")
                .font(.headline)

            HStack(spacing: 16) {
                ProfileStatCard(
                    icon: "checkmark.circle.fill",
                    value: "\(completedTodos.count)",
                    label: "Completed",
                    color: .green
                )

                ProfileStatCard(
                    icon: "trophy.fill",
                    value: "\(unlockedAchievements.count)/\(achievements.count)",
                    label: "Badges",
                    color: .yellow
                )

                ProfileStatCard(
                    icon: "calendar",
                    value: "\(profile?.longestStreak ?? 0)",
                    label: "Best Streak",
                    color: .orange
                )
            }
        }
    }

    private var recentActivitySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recently Completed")
                .font(.headline)

            if completedTodos.isEmpty {
                Text("No completed tasks yet")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            } else {
                ForEach(completedTodos.prefix(5)) { todo in
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)

                        VStack(alignment: .leading) {
                            Text(todo.title)
                                .font(.subheadline)
                            if let completedAt = todo.completedAt {
                                Text(completedAt, style: .relative)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }

                        Spacer()

                        Text("+\(todo.pointsAwarded)")
                            .font(.caption.bold())
                            .foregroundColor(.green)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
    }
}

struct ProfileStatCard: View {
    let icon: String
    let value: String
    let label: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)

            Text(value)
                .font(.headline)

            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ProfileView()
        .modelContainer(for: [UserProfile.self, TodoItem.self, Achievement.self], inMemory: true)
}
