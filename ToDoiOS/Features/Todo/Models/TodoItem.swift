import Foundation
import SwiftData

@Model
class TodoItem {
    var id: UUID
    var title: String
    var itemDescription: String
    var isCompleted: Bool
    var priority: Priority
    var dueDate: Date?
    var completedAt: Date?
    var createdAt: Date
    var pointsAwarded: Int

    enum Priority: String, Codable, CaseIterable {
        case low = "Low"
        case medium = "Medium"
        case high = "High"

        var points: Int {
            switch self {
            case .low: return 10
            case .medium: return 25
            case .high: return 50
            }
        }

        var color: String {
            switch self {
            case .low: return "PriorityLow"
            case .medium: return "PriorityMedium"
            case .high: return "PriorityHigh"
            }
        }
    }

    init(
        title: String,
        itemDescription: String = "",
        priority: Priority = .medium,
        dueDate: Date? = nil
    ) {
        self.id = UUID()
        self.title = title
        self.itemDescription = itemDescription
        self.isCompleted = false
        self.priority = priority
        self.dueDate = dueDate
        self.completedAt = nil
        self.createdAt = Date()
        self.pointsAwarded = 0
    }

    func complete() {
        isCompleted = true
        completedAt = Date()
        pointsAwarded = priority.points
    }
}

extension TodoItem.Priority {
    var localizedName: String {
        switch self {
        case .low: return String(localized: "priority.low")
        case .medium: return String(localized: "priority.medium")
        case .high: return String(localized: "priority.high")
        }
    }
}
