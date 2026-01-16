import SwiftUI

struct AchievementCard: View {
    let achievement: Achievement

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(achievement.isUnlocked ? Color.yellow.opacity(0.2) : Color.gray.opacity(0.1))
                    .frame(width: 60, height: 60)

                Image(systemName: achievement.type.icon)
                    .font(.title)
                    .foregroundColor(achievement.isUnlocked ? .yellow : .gray)
            }

            Text(achievement.type.title)
                .font(.caption.bold())
                .multilineTextAlignment(.center)

            Text(achievement.type.description)
                .font(.caption2)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .lineLimit(2)

            if !achievement.isUnlocked {
                ProgressView(value: Double(achievement.progress), total: Double(achievement.type.target))
                    .tint(.blue)
                Text("\(achievement.progress)/\(achievement.type.target)")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 4)
        .opacity(achievement.isUnlocked ? 1 : 0.7)
    }
}

#Preview {
    let achievement = Achievement(type: .firstTask)
    return AchievementCard(achievement: achievement)
        .padding()
        .background(Color(.systemGroupedBackground))
}
