//
//  ContentView.swift
//  SplitIt
//
//  Created by Saloni Agarwal on 09/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var numOfPeople = 5
    @State private var amount = 0.0
    @State private var tipPercent =  20
    @FocusState private var amountIsFocused: Bool
    let tipPercents = [25, 10, 15, 0, 20]
    
    var totalPerPerson: Double {                  //Returns the amount to be paid by each person
        let peopleCount = Double(numOfPeople + 2)
        let tipSelection = Double(tipPercent)
        
        let tipAmount = amount * tipSelection / 100
        let grandTotal = amount + tipAmount
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value:$amount, format:.currency(code:Locale.current.currency?.identifier ?? "INR"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numOfPeople){
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(.menu)
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercent) {
                        ForEach(tipPercents, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(5)
                    
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("SplitIt")
            .navigationBarTitleDisplayMode(.large)
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

#Preview {
    ContentView()
}
