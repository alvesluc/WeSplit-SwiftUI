//
//  ContentView.swift
//  WeSplit
//
//  Created by Macedo on 28/01/26.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeopleIndex = 0
    @State private var tipPercentage = 20
    
    private var currencyCode = Locale.current.currency?.identifier
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalForTheCheck: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeopleIndex + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section{
                    TextField(
                        "Amount",
                        value: $checkAmount,
                        format: .currency(code: currencyCode ?? "USD")
                    )
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeopleIndex) {
                        ForEach(2..<100) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Total amount for the check") {
                    Text(totalForTheCheck, format: .currency(code: currencyCode ?? "USD"))
                }
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: currencyCode ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
