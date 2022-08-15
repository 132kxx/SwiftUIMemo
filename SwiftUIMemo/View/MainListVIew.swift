//
//  MainListVIew.swift
//  SwiftUIMemo
//
//  Created by kxx: on 2022/07/14.
//

import SwiftUI

struct MainListVIew: View {
    @EnvironmentObject var manager: CoreDataManager
    
    @State private var showCompeser: Bool = false
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\MemoEntity.insertDate, order: .reverse)])
    var memoList: FetchedResults<MemoEntity>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(memoList) { memo in
                    NavigationLink {
                        DetailView(memo: memo)
                    } label: {
                        MemoCell(memo: memo)
                    }
                }
                .onDelete(perform: delete)
            }
            .listStyle(.plain)
            .navigationTitle("My Memo")
            .toolbar {
                Button {
                    showCompeser = true
                } label: {
                    Image(systemName: "plus")
                }

            }
            .sheet(isPresented: $showCompeser) {
                ComposeView()
        }
        }
        
    }
    
    func delete(set: IndexSet) {
        for index in set {
            manager.delete(memo: memoList[index])
        }
    }
    
}

struct MainListVIew_Previews: PreviewProvider {
    static var previews: some View {
        MainListVIew()
            .environmentObject(CoreDataManager.shared)
            .environment(\.managedObjectContext, CoreDataManager.shared.mainContext)
    }
}
