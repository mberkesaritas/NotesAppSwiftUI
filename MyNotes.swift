//
//  MyNotes.swift
//  NotesAppSwiftUI
//
//  Created by Berke Sarıtaş on 22.04.2022.
//

import Foundation

class MyNotes: ObservableObject {
    @Published var folders = [Folder(name: "")]
}

struct Folder: Identifiable {
    var id = UUID()
    var name : String
}

var testFolder = [Folder(name: "Folder1") , Folder(name: "Folder2")]
