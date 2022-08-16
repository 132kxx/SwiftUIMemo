//
//  NavigationState.swift
//  SwiftUIMemo
//
//  Created by kxx: on 2022/08/16.
//

import Foundation
import SwiftUI

class NavigationState: ObservableObject {
    @Published var listId = UUID()
}
