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
    @State private var showLockConfirmation: Bool = false
    @State private var confirmationText: String = ""

    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            
            VStack (spacing: 32){
                
                VStack (spacing: 8) {
                    //Header
                    Text("DEFINE DAILY STANDARDS")
                        .font(.caption)
                        .tracking(2)
                        .foregroundColor(.gray)
                    
                    Text("Your non-negotiables")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                }
                VStack(spacing: 12) {
                    TextField("e.g. Slee. before 23:00", text: $newStandardTitle)
                        .padding()
                        .background(Color(white: 0.1))
                        .foregroundColor(.white)
                        .cornerRadius(6)
                    
                    Button("ADD STANDARD"){
                        addStandard()
                    }
                    .disabled(newStandardTitle.trimmingCharacters(in: .whitespaces).isEmpty)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(white: 0.2))
                    .cornerRadius(6)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    ForEach(store.standards) { standard in
                        Text(standard.title)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(white: 0.08))
                            .cornerRadius(6)
                    }
                }
                
                Spacer()
                //Lock section
                VStack(spacing: 12) {
                    Text("Once locked, standards cannot be changed.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    Button("LOCK STANDARDS") {
                        showLockConfirmation = true
                    }
                    .disabled(!store.canLockStandards)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(store.canLockStandards ? Color.white : Color(white: 0.3))
                    .foregroundColor(.black)
                    .cornerRadius(6)
                }
                
                if showLockConfirmation {
                    VStack(spacing: 16) {
                        Text("This action is irreversible.")
                            .font(.headline)
                            .foregroundColor(.white)

                        Text("Type LOCK to confirm.")
                            .font(.footnote)
                            .foregroundColor(.gray)

                        TextField("LOCK", text: $confirmationText)
                            .padding()
                            .background(Color(white: 0.1))
                            .foregroundColor(.white)
                            .cornerRadius(6)
                            .autocapitalization(.allCharacters)

                        Button("CONFIRM & LOCK") {
                            store.lockStandards()
                        }
                        .disabled(confirmationText != "LOCK")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(confirmationText == "LOCK" ? Color.white : Color(white: 0.3))
                        .foregroundColor(.black)
                        .cornerRadius(6)
                    }
                    .padding()
                    .background(Color(white: 0.05))
                    .cornerRadius(8)
                }

                
            }
            .padding()
        }
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
