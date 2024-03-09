//
//  ContentView.swift
//  Examples
//
//  Created by Yu Kanamori on 2024/03/09.
//

import SwiftUI
import RandomPasswordGenerator

struct ContentView: View {
    @State private var password: String = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            Text(password)
                .padding()
            Button(action: generatePassword) {
                Text("Generate Password")
            }
            if let errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            }
        }
        .onAppear(perform: generatePassword)
    }
    
    func generatePassword() {
        let generator = RandomPasswordGenerator(length: 10,
                                                characterTypes: [.digits, .uppercase, .lowercase],
                                                excludedCharacters: "0OIl1")
        do {
            password = try generator.generate()
            errorMessage = nil
        } catch {
            print("パスワードの生成に失敗しました: \(error)")
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    ContentView()
}
