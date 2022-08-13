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
                VStack(alignment: .leading) {
                    Text(memo.content)
                        .font(.body)
                        .lineLimit(1)
                    
                    Text(memo.insertDate, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
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
