import SwiftUI

struct TodoRowView: View {
    let todo: TodoItem
    let onComplete: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Button(
                action: onComplete,
                label: {
                    Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                        .font(.title2)
                        .foregroundColor(todo.isCompleted ? .green : .secondary)
                }
            )
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 4) {
                Text(todo.title)
                    .font(.body)
                    .strikethrough(todo.isCompleted)
                    .foregroundColor(todo.isCompleted ? .secondary : .primary)

                if let dueDate = todo.dueDate {
                    Text(dueDate, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            PriorityBadge(priority: todo.priority)
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
    }
}

struct PriorityBadge: View {
    let priority: TodoItem.Priority

    var body: some View {
        Text(priority.rawValue)
            .font(.caption2.bold())
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(priorityColor.opacity(0.2))
            .foregroundColor(priorityColor)
            .clipShape(Capsule())
    }

    private var priorityColor: Color {
        switch priority {
        case .low:
            return .green
        case .medium:
            return .orange
        case .high:
            return .red
        }
    }
}
