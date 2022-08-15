//
//  DetailView.swift
//  SwiftUIMemo
//
//  Created by kxx: on 2022/08/15.
//

import SwiftUI

struct DetailView: View {
    
    @State private var showComposer = false
    @State private var showDeleteAlert = false

    
    @ObservedObject var memo: Memo
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: MemoStore
    
    var body: some View {
        VStack {
            ScrollView{
                VStack {
                    HStack {
                        Text(memo.content)
                            .padding()
                        Spacer(minLength: 0)
                    }
                    Text(memo.insertDate, style:.date)
                        .padding()
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("메모보기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                }
                .foregroundColor(.red)
                .alert("확인", isPresented: $showDeleteAlert) {
                    Button(role: .destructive) {
                        store.delete(memo: memo)
                            dismiss()
                    } label: {
                        Text("delete")
                    }

                } message: {
                    Text("delete?")
                }


                Button {
                    showComposer = true
                } label: {
                    Image(systemName: "square.and.pencil")
                }

            }
        }
        .sheet(isPresented: $showComposer) {
            ComposeView(memo: memo)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(memo: Memo(content: "hello"))
                .environmentObject(MemoStore())
        }
    }
}
