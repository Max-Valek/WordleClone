//
//  ToastView.swift
//  WordleClone
//
//  Created by Max Valek on 6/28/23.
//

import SwiftUI

struct ToastView: View {
    
    let toastText: String
    
    var body: some View {
        Text(toastText)
            .foregroundColor(.systemBackground)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.primary.opacity(0.8)))
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(toastText: "Not in word list")
    }
}
