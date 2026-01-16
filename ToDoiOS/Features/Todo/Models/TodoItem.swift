import Foundation
import SwiftData

@Model
final class TodoItem {
    var id: UUID
    var title: String
    var itemDescription: String
    var isCompleted: Bool
    var createdAt: Date
    var completedAt: Date?
    var priority: Priority
    var points: Int

    enum Priority: Int, Codable {
        case low = 0
        case medium = 1
        case high = 2
    }

    init(
        id: UUID = UUID(),
        title: String,
        itemDescription: String = "",
        isCompleted: Bool = false,
        createdAt: Date = Date(),
        completedAt: Date? = nil,
        priority: Priority = .medium,
        points: Int = 10
    ) {
        self.id = id
        self.title = title
        self.itemDescription = itemDescription
        self.isCompleted = isCompleted
        self.createdAt = createdAt
        self.completedAt = completedAt
        self.priority = priority
        self.points = points
    }
}
