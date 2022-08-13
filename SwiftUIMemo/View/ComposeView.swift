//
//  ComposeView.swift
//  SwiftUIMemo
//
//  Created by kxx: on 2022/08/14.
//

import SwiftUI

struct ComposeView: View {
    @EnvironmentObject var store: MemoStore
    
    @Environment(\.dismiss) var dismiss
    
    @State private var content: String = ""
    
    var body: some View {
        NavigationView {
            VStack{
                TextEditor(text: $content)
                    .padding()
            }
            .navigationTitle("New Memo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        store.insert(memo: content)
                        dismiss()
                    } label: {
                        Text("save")
                    }
                }
                
            }
        }
    }
}

struct ComposeView_Previews: PreviewProvider {
    static var previews: some View {
        ComposeView()
            .environmentObject(MemoStore())
        
    }
}
