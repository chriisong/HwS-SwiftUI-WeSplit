//
//  Day15.swift
//  WeSplit
//
//  Created by Chris Song on 2021-10-17.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double? = nil
    @State private var numberOfPeople: Int = 2
    @State private var tipPercentage: Int = 0
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var currencyCode: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currencyCode ?? "CAD")
    }
    
    var totalPerPerson: Double {
        if let checkAmount = checkAmount {
            let peopleCount = Double(numberOfPeople + 2)
            let tipSelection = Double(tipPercentage)
            let tipValue = checkAmount / 100 * tipSelection
            let grandTotal = checkAmount + tipValue
            let amountPerPerson = grandTotal / peopleCount
            return amountPerPerson
        }
        
        return 0
    }
    
    var totalAmount: Double {
        if let checkAmount = checkAmount {
            let tipSelection = Double(tipPercentage)
            let tipValue = checkAmount / 100 * tipSelection
            let grandTotal = checkAmount + tipValue
            return grandTotal
        }
        
        return 0
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Total bill amount", value: $checkAmount, format: currencyCode)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<20) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.automatic)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip %", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .listRowInsets(.init())
                    .listRowBackground(Color.clear)
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Text(totalPerPerson, format: currencyCode)
                        .foregroundColor(.indigo).bold()
                } header: {
                    Text("Amount to pay (per person)")
                } footer: {
                    Text("Total amount before split: \(totalAmount.formatted(currencyCode))")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
