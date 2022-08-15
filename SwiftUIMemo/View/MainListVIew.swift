//
//  MainListVIew.swift
//  SwiftUIMemo
//
//  Created by kxx: on 2022/07/14.
//

import SwiftUI

struct MainListVIew: View {
    @EnvironmentObject var store: MemoStore
    
    @State private var showCompeser: Bool = false
    
    var body: some View {
        NavigationView {
            List(store.list) { memo in
                NavigationLink {
                    DetailView(memo: memo)
                } label: {
                    MemoCell(memo: memo)
                }

                MemoCell(memo: memo)
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
}

struct MainListVIew_Previews: PreviewProvider {
    static var previews: some View {
        MainListVIew()
            .environmentObject(MemoStore())
    }
}
