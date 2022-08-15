//
//  ComposeView.swift
//  SwiftUIMemo
//
//  Created by kxx: on 2022/08/14.
//

import SwiftUI

struct ComposeView: View {
    @EnvironmentObject var manager: CoreDataManager
    
    var memo: MemoEntity? = nil
    
    @Environment(\.dismiss) var dismiss
    
    
    @State private var content: String = ""
    
    var body: some View {
        NavigationView {
            VStack{
                TextEditor(text: $content)
                    .padding()
                    .onAppear{
                        if let memo = memo?.content {
                            content = memo
                        }
                    }
            }
            .navigationTitle(memo != nil ? "edit" : "New Memo")
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
                        if let memo = memo {
                            manager.update(memo: memo, content: content)
                        } else {
                            manager.addMemo(content: content)
                        }
                        
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
            .environmentObject(CoreDataManager.shared)
        
    }
}
