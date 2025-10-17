//
//  SwiftUIView.swift
//  FreehandMapDrawing
//
//  Created by Jeremy Barger on 10/13/25.
//

// View
import SwiftUI

struct SwiftUIViewView: View {
    @State private var oo = SwiftUIViewOO()
    
    var body: some View {
        List(oo.data) { datum in
            Text(datum.name)
        }
        .task {
            oo.fetch()
        }
    }
}

#Preview {
    SwiftUIViewView()
}

// Observable Object
import Observation
import SwiftUI

@Observable
class SwiftUIViewOO {
    var data: [SwiftUIViewDO] = []
    
    func fetch() {
        data = [SwiftUIViewDO(name: "Datum 1"),
                SwiftUIViewDO(name: "Datum 2"),
                SwiftUIViewDO(name: "Datum 3")]
    }
}

// Data Object
import Foundation

struct SwiftUIViewDO: Identifiable {
    let id = UUID()
    var name: String
}
