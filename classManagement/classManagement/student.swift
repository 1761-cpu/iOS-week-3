import Foundation

struct Student: Identifiable {
    let id = UUID()
    var studentID: String
    var name: String
    var GPA: Double
}
