//  ContentView.swift
//  IrrevHabit
//  Created by Paulo Marcelo Santos on 23/12/25.
import SwiftUI
struct ContentView: View {
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            VStack{
                Spacer()
                VStack(spacing:12){
                    Text("IrrevHabit does not motivate you")
                    Text("It records what you actually do")
                    Text("Misses are permanent")
                }
                .foregroundColor(.white)
                .font(.system(.body, design: .monospaced))
                Spacer()
            }
        }
    }
}
#Preview {
    ContentView()
}
