//
//  DayFifteen.swift
//  WeSplit
//
//  Created by Chris Song on 2021-10-17.
//

import SwiftUI

// Stuff from Day 15 first 6 videos
struct Day15: View {
    @State private var tapCount = 0
    @State private var name = ""
    
    struct Student: Hashable {
        enum House: String {
            case gryffindor
            case hufflepuff
            case ravenclaw
            case slytherin
        }
        
        let name: String
        var id = UUID().uuidString
        let house: House
    }
    
    let students = [
        Student(name: "Harry Potter", house: .gryffindor),
        Student(name: "Ron Weasley", house: .gryffindor),
        Student(name: "Hermione Granger", house: .gryffindor),
        Student(name: "Draco Malfoy", house: .slytherin),
    ]
    
    @State private var selectedStudent = ""
    
    var body: some View {
        NavigationView {
            
            Form {
                Section {
                    Button("Tap Count: \(tapCount)") {
                        tapCount += 1
                    }
                    .foregroundColor(.indigo)
                    TextField("Enter your name", text: $name)
                    Text("Your name is: \(name)")
                }
                
                Section {
                    Picker("Select your student", selection: $selectedStudent) {
                        ForEach(students, id: \.id) {
                            Text("\($0.name) (\($0.house.rawValue.capitalized))")
                        }
                    }.pickerStyle(.wheel)
                }
                
                Section {
                    ForEach(0..<20) { number in
                        if number % 2 == 0 {
                            Button("Button \(number)") {
                                
                            }
                        } else {
                            Text("Text \(number)")
                        }
                    }
                }
            }
            .navigationTitle("SwiftUI")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct Day15_Previews: PreviewProvider {
    static var previews: some View {
        Day15()
    }
}
