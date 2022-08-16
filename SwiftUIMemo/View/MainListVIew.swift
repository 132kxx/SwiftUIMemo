//
//  MainListVIew.swift
//  SwiftUIMemo
//
//  Created by kxx: on 2022/07/14.
//

import SwiftUI

struct MainListVIew: View {
    @EnvironmentObject var manager: CoreDataManager
    @EnvironmentObject var navigationState: NavigationState
    
    @State private var showComposer: Bool = false
    
    @State private var keyword = ""
    
    @State private var sortByDateDesc = true
    
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
                HStack {
                    Button {
                        showComposer = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                    Button {
                        sortByDateDesc.toggle()
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }

                }

            }
            .sheet(isPresented: $showComposer) {
                ComposeView()
        }
            .searchable(text: $keyword, prompt: "내용을 검색합니다")
            .onChange(of: keyword) { newValue in
                if keyword.isEmpty {
                    memoList.nsPredicate = nil
                } else {
                    memoList.nsPredicate = NSPredicate(format: "content CONTAINS[c] %@", newValue)
                }
            }
            
            .onChange(of: sortByDateDesc) { desc in
                if desc {
                    memoList.sortDescriptors = [
                        SortDescriptor(\.insertDate, order: .reverse)
                    ]
                } else {
                    memoList.sortDescriptors = [
                        SortDescriptor(\.insertDate, order: .forward)
                        ]
                }
            }
            
            VStack {
                Text("내 메모를 탭한 다음 메모를 선택하거나 \n 새 메모를 추가할 수 있어요")
                    .multilineTextAlignment(.center)
                    .font(.title3)
                
                Button {
                    showComposer = true
                } label: {
                    Image(systemName: "plus")
                }
                        .padding()
                        .buttonStyle(.borderedProminent)

            }
        }
        #if os(iOS)
        .id(navigationState.listId)
        #endif
        
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
            .environmentObject(NavigationState())
    }
}
