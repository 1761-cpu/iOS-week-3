import SwiftUI

struct AddStudentView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var students: [Student]
    
    @State private var studentID: String = ""
    @State private var name: String = ""
    @State private var GPA: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Image(systemName: "person.badge.plus")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                TextField("Enter student ID (e.g. S004)", text: $studentID)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Enter student name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Enter GPA (e.g. 8.5)", text: $GPA)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                
                Button(action: {
                    if !studentID.isEmpty && !name.isEmpty, let GPAValue = Double(GPA) {
                        let newStudent = Student(
                            studentID: studentID,
                            name: name,
                            GPA: GPAValue
                        )
                        students.append(newStudent)
                        dismiss()
                    }
                }) {
                    Text("Add Student")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                        }
                        .foregroundColor(.blue)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("ADD STUDENT")
                        .font(.system(size: 20, weight: .bold, design: .monospaced))
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
