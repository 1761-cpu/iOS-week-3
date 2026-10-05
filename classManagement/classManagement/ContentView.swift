import SwiftUI

struct ContentView: View {
    @State private var students: [Student] = [
        Student(studentID: "S001", name: "Ánh", GPA: 8.2),
        Student(studentID: "S002", name: "Bảo", GPA: 7.5),
        Student(studentID: "S003", name: "Cẩm", GPA: 9.3),
        Student(studentID: "S004", name: "Đông", GPA: 8.7)
    ]
    
    @State private var searchField: String = ""
    @State private var showAddView: Bool = false
    @State private var showGoodGPA: Bool = false
    @State private var showTopGPA: Bool = false
    @State private var showBottomGPA: Bool = false
    @State private var sortGPA: Int = 0
    
    var managementFeatures: [Student] {
        var result = students
        
        if !searchField.isEmpty {
            result = result.filter {
                $0.name.lowercased().contains(searchField.lowercased())
                ||
                $0.studentID.lowercased().contains(searchField.lowercased())
            }
        }
        
        if showGoodGPA {
            result = result.filter {$0.GPA >= 8.0}
        }
        
        if showTopGPA, let topGPA = result.max(by: {$0.GPA < $1.GPA}) {
            result = [topGPA]
        }
        
        if showBottomGPA, let bottomGPA = result.min(by: {$0.GPA < $1.GPA}) {
            result = [bottomGPA]
        }
        
        if sortGPA == 1 {
            result = result.sorted(using: KeyPathComparator(\.GPA, order: .forward))
        } else if sortGPA == 2 {
            result = result.sorted(using: KeyPathComparator(\.GPA, order: .reverse))
        }
        
        return result
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                
                // HEADER
                VStack(spacing: 8) {
                    Image(systemName: "person.3.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.blue)
                    
                    Text("STUDENT MANAGER")
                        .font(.system(size: 22, weight: .bold, design: .monospaced))
                    
                    Text("A better class, a brighter tomorrow")
                        .font(.system(size: 14, weight: .semibold))
                        .italic()
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.75))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)
                .padding(.top, 8)
                
                // SEARCH FIELD
                TextField("Search by name or ID...", text: $searchField)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        // Top GPA
                        Button(action: {
                            showTopGPA.toggle()
                            if showTopGPA { showGoodGPA = false; showBottomGPA = false }
                        }) {
                            Label("Top GPA", systemImage: "chart.line.uptrend.xyaxis.circle.fill")
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(showTopGPA ? Color.purple : Color.white.opacity(0.85))
                                .foregroundColor(showTopGPA ? .white : .primary)
                                .cornerRadius(20)
                        }
                        
                        // Bottom GPA
                        Button(action: {
                            showBottomGPA.toggle()
                            if showBottomGPA { showGoodGPA = false; showTopGPA = false }
                        }) {
                            Label("Bottom GPA", systemImage: "chart.line.downtrend.xyaxis.circle.fill")
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(showBottomGPA ? Color.pink : Color.white.opacity(0.85))
                                .foregroundColor(showBottomGPA ? .white : .primary)
                                .cornerRadius(20)
                        }
                        
                        // GPA >= 8.0
                        Button(action: {
                            showGoodGPA.toggle()
                            if showGoodGPA { showTopGPA = false; showBottomGPA = false }
                        }) {
                            Label("GPA ≥ 8", systemImage: "star.fill")
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(showGoodGPA ? Color.yellow : Color.white.opacity(0.85))
                                .foregroundColor(showGoodGPA ? .white : .primary)
                                .cornerRadius(20)
                        }
                        
                        // Sort by GPA
                        Button(action: {
                            sortGPA = (sortGPA + 1) % 3
                        }) {
                            Label(
                                sortGPA == 0 ? "Sort GPA" : sortGPA == 1 ? "Low → High" : "High → Low",
                                systemImage: sortGPA == 1 ? "arrow.up" :
                                    sortGPA == 2 ? "arrow.down" : "arrow.up.arrow.down"
                            )
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(sortGPA == 0 ? Color.white.opacity(0.85) : Color.indigo)
                            .foregroundColor(sortGPA == 0 ? .primary : .white)
                            .cornerRadius(20)
                        }
                        
                        // Reset
                        Button(action: {
                            showTopGPA = false
                            showGoodGPA = false
                            showBottomGPA = false
                            sortGPA = 0
                            searchField = ""
                        }) {
                            Label("Reset", systemImage: "arrow.counterclockwise")
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.red.opacity(0.85))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                    }
                    .padding(.horizontal)
                }
                
                List {
                    ForEach(managementFeatures) { student in
                        NavigationLink {
                            EditStudentView(students: $students, student: student)
                        } label: {
                            HStack {
                                Image(systemName: "person.circle.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.blue)
                                
                                VStack(alignment: .leading) {
                                    Text(student.name)
                                        .font(.headline)
                                        .bold()
                                    Text("ID: \(student.studentID)")
                                        .font(.caption)
                                        .italic()
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Text("GPA: \(String(format: "%.1f", student.GPA))")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(student.GPA >= 8.0 ? .green : .orange)
                            }
                            .padding(.vertical, 4)
                        }
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.9))
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                        )
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
                
                
                // ADD STUDENT BUTTON
                Button(action: {
                    showAddView = true
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Student")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.9))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Text("Total students: \(students.count)")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.5), radius: 2)
                    .padding(.bottom, 8)
            }
            .sheet(isPresented: $showAddView) {
                AddStudentView(students: $students)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Image("bg1")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    ContentView()
}
