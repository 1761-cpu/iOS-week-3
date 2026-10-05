import SwiftUI

struct EditStudentView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var students: [Student]
    let student: Student
    
    @State private var newName: String
    @State private var newGPA: String
    @State private var showDeleteAlert: Bool = false
    
    init(students: Binding<[Student]>, student: Student) {
        self._students = students
        self.student = student
        self._newName = State(initialValue: student.name)
        self._newGPA = State(initialValue: String(format: "%.1f", student.GPA))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            Image(systemName: "pencil.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(.orange.opacity(0.9))
                .padding(.top, 20)
            
            Text("ID: \(student.studentID)")
                .font(.system(size: 16, weight: .bold, design: .monospaced))
                .foregroundColor(.black)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.white.opacity(0.75))
                .clipShape(Capsule())
                .padding(.bottom, 8)
            
            TextField("Enter new name", text: $newName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Enter new GPA", text: $newGPA)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
            
            // UPDATE button
            Button(action: {
                if let GPA = Double(newGPA) {
                    if let index = students.firstIndex(where: { $0.studentID == student.studentID }) {
                        students[index].name = newName
                        students[index].GPA = GPA
                    }
                    dismiss()
                }
            }) {
                Text("Update")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange.opacity(0.9))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            // REMOVE button
            Button(action: {
                showDeleteAlert = true
            }) {
                Text("Remove Student")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red.opacity(0.9))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .padding(.top, 67)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("EDIT STUDENT")
                    .font(.system(size: 25, weight: .bold, design: .monospaced))
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Image("bg1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(Color.white.opacity(0.3))
        }
        .alert("Remove Student", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Remove", role: .destructive) {
                students.removeAll { $0.studentID == student.studentID }
                dismiss()
            }
        } message: {
            Text("Are you sure you want to remove \(student.name)?")
        }
    }
}

#Preview {
    ContentView()
}
