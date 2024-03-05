//
//  SecondView.swift
//  ReSwiftUI
//
//  Created by Kim Nordin on 2024-03-01.
//

import SwiftUI

struct SecondView: View {
    @EnvironmentObject var store: ObservableState<RootState>
    @State private var currentNumber: Int?
    
    var body: some View {
        VStack {
            if let number = currentNumber {
                Text("\(number)")
            }
            HStack {
                Button("Increase Number") {
                    IncrementNumber().dispatchFromMain()
                }
                Button("Decrease Number") {
                    DecreaseNumber().dispatchFromMain()
                }
            }
        }
        .onReceive(store.$state) { state in
            newState(state: state)
        }
    }
}

extension SecondView: StateViewProtocol {
    var skipRepeatsClosure: SkipRepeats<RootState>? {
        return { _, _ in return false }
    }

    func newState(state: RootState) {
        DispatchQueue.main.async {
            currentNumber = state.numberState.number
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
            .environmentObject(ObservableState(initialState: initialRootState()))
    }
}
