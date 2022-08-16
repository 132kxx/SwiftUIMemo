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

    
    @ObservedObject var memo: MemoEntity
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var manager: CoreDataManager
    @EnvironmentObject var navigationState: NavigationState
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var placement: ToolbarItemPlacement {
        if horizontalSizeClass == .regular {
            return .primaryAction
        } else {
            return .bottomBar
        }
    }
    
    var body: some View {
        VStack {
            ScrollView{
                VStack {
                    HStack {
                        Text(memo.content ?? "")
                            .padding()
                        Spacer(minLength: 0)
                    }
                    Text(memo.insertDate ?? .now, style:.date)
                        .padding()
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("메모보기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: placement) {
                Button {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                }
                .foregroundColor(.red)
                .alert("확인", isPresented: $showDeleteAlert) {
                    Button(role: .destructive) {
                        manager.delete(memo: memo)
                        
                        if horizontalSizeClass == .regular {
                            navigationState.listId = UUID()
                        } else {
                            dismiss()
                        }
                        
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
            DetailView(memo: MemoEntity(context: CoreDataManager.shared.mainContext))
                .environmentObject(CoreDataManager.shared)
        }
    }
}
