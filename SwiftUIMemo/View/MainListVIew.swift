//
//  MainListVIew.swift
//  SwiftUIMemo
//
//  Created by kxx: on 2022/07/14.
//

import SwiftUI

struct MainListVIew: View {
    @EnvironmentObject var store: MemoStore
    
    var body: some View {
        NavigationView {
            List(store.list) { memo in
                MemoCell(memo: memo)
            }
            .listStyle(.plain)
            .navigationTitle("My Memo")
        }
        
    }
}

struct MainListVIew_Previews: PreviewProvider {
    static var previews: some View {
        MainListVIew()
            .environmentObject(MemoStore())
    }
}
