import SwiftUI
import SwiftData

struct AchievementsView: View {
    @Query private var achievements: [Achievement]
    @Query private var profiles: [UserProfile]

    private var profile: UserProfile? { profiles.first }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    if let profile = profile {
                        statsCard(profile: profile)
                    }

                    achievementsList
                }
                .padding()
            }
            .navigationTitle("Achievements")
            .background(Color(.systemGroupedBackground))
        }
    }

    private func statsCard(profile: UserProfile) -> some View {
        VStack(spacing: 16) {
            HStack(spacing: 24) {
                StatItem(value: "\(profile.totalPoints)", label: "Points", icon: "star.fill", color: .yellow)
                StatItem(value: "\(profile.level)", label: "Level", icon: "arrow.up.circle.fill", color: .blue)
                StatItem(value: "\(profile.currentStreak)", label: "Streak", icon: "flame.fill", color: .orange)
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Level \(profile.level)")
                    Spacer()
                    Text("Level \(profile.level + 1)")
                }
                .font(.caption)
                .foregroundColor(.secondary)

                ProgressView(value: profile.progressToNextLevel)
                    .tint(.blue)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 8)
    }

    private var achievementsList: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Badges")
                .font(.headline)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(achievements) { achievement in
                    AchievementCard(achievement: achievement)
                }
            }
        }
    }
}

struct StatItem: View {
    let value: String
    let label: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            Text(value)
                .font(.title2.bold())
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    AchievementsView()
        .modelContainer(for: [Achievement.self, UserProfile.self], inMemory: true)
}
