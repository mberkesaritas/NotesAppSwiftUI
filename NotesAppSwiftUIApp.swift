//
//  NotesAppSwiftUIApp.swift
//  NotesAppSwiftUI
//
//  Created by Berke Sarıtaş on 22.04.2022.
//

import SwiftUI

@main
struct NotesAppSwiftUIApp: App {
    @StateObject private var myNotes = MyNotes()

    var body: some Scene {
        WindowGroup {
            ContentView(myNotes: myNotes)
        }
    }
}
