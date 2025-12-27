//
//  SetupView.swift
//  IrrevHabit
//
//  Created by Paulo Marcelo Santos on 25/12/25.
//

import SwiftUI

struct SetupView: View {
    @EnvironmentObject var store: StandardsStore
    @State private var newStandardTitle: String = ""
    
    var body: some View {
        VStack (spacing: 16){
            Text("Define your Daily Standards")
                .font(.title2)
                .fontWeight(.bold)
            
            TextField("Enter a standard", text: $newStandardTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button("Add Standard"){
                addStandard()
            }
            .disabled(newStandardTitle.trimmingCharacters(in: .whitespaces).isEmpty)
            
            List(store.standards) { standard in
                Text(standard.title)
            }
        }
        .padding()
    }
    
    private func addStandard () {
        let trimed = newStandardTitle.trimmingCharacters(in: .whitespaces)
        guard !trimed.isEmpty else { return }
        
        let standard = Standard (
            id: UUID(),
            title: trimed,
            status: .pending
        )
        
        store.standards.append(standard)
        newStandardTitle = ""
    }
}

#Preview {
    SetupView()
        .environmentObject(StandardsStore())
}
