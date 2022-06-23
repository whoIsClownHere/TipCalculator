//
//  ContentView.swift
//  tipCalculator
//
//  Created by Egor on 04.06.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 0
    @State private var currency = 0
    
    var currencies = ["$", "€", "¥", "₽", "£"]
    var tipPercentages = [0, 5, 10, 15, 20]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(amount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $amount)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<30) {
                            Text("\($0) человек")
                        }
                    }
                    Picker("Currency", selection: $currency) {
                        ForEach(0..<5) {
                            Text("\(currencies[$0])")
                        }
                    }
                }
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<5) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Text("\(totalPerPerson, specifier: "%.2f")\(currencies[currency])")
                }
            }
            .navigationTitle("Tip Calculator")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
