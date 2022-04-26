//
//  ContentView.swift
//  NotesAppSwiftUI
//
//  Created by Berke Sarıtaş on 22.04.2022.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var myNotes : MyNotes
    @State var searchString : String = ""
    @State var newFolderName : String = ""
    @State var showPopUp = false
    
    var body: some View {
        
        ZStack {
            NavigationView {
                List{
                    TextField("search", text: $searchString)
                    Section( content: {} ,
                             header: {Text("On My Iphone")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.black)
                            
                    })
                    
                    if myNotes.folders.count > 0 {
                        FolderCell(name: "All on my iPhone")
                    }
                    
                    FolderCell(name: "Notes")
                    
                    ForEach(myNotes.folders){ folder in
                        
                        FolderCell(name: folder.name)
                        
                    }.onDelete(perform: {indexSet in
                        print("Delete")
                        myNotes.folders.remove(atOffsets: indexSet)
                    })
                    
                }.listStyle(InsetGroupedListStyle())
                    .navigationTitle("Folders")
                    .toolbar(content: {
                        ToolbarItemGroup(placement: .navigationBarTrailing, content: {
                            EditButton()
                        })
                        ToolbarItemGroup(placement: .bottomBar, content: {
                            Image(systemName: "folder.badge.plus")
                                .foregroundColor(.yellow)
                                .onTapGesture {
                                    showPopUp.toggle()
                                }
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(.yellow)
                        })
                    })
            }
            if showPopUp{
                CreateNewFolder( $showPopUp , with: myNotes)
            }
            
            
        }
        
    }
}



struct FolderCell: View {
    var name : String
    var body: some View {
        HStack{
            Image(systemName: "folder")
                .foregroundColor(.yellow)
            Text(name)
        }
    }
}

struct CreateNewFolder: View {
    @State var newFolderName : String = ""
    @Binding var showPopUp : Bool
    @ObservedObject var myNotes : MyNotes
    
    init(_ showPopUp:Binding<Bool> , with myNotes : MyNotes ) {
        self._showPopUp = showPopUp
        self.myNotes = myNotes
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .fill(Color(.systemGray4))
                    .frame(width: geo.size.width * 0.7 , height: geo.size.width * 0.4, alignment: .center)
                
                VStack{
                    Text("New Folder")
                        .font(.headline)
                    Text("Enter a name this folder")
                        .font(.subheadline)
                    Spacer()
                    TextField("Name" ,  text: $newFolderName)
                        .frame(width: 200, height: 10)
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(7)
                    
                    Spacer()
                    
                    Color.gray.frame(width: geo.size.width * 0.7, height: CGFloat(1), alignment: .center)
                    
                    HStack{
                        Button("Cancel" , action: {
                            print("Cancel")
                        })
                        .frame(maxWidth : .infinity)
                        Button("Save" , action: {
                            myNotes.folders.append(Folder(name: newFolderName))
                            showPopUp.toggle()
                        }).frame(maxWidth : .infinity)
                        
                    }
                }.frame(width: geo.size.width * 0.7, height: geo.size.width * 0.35 , alignment: .center)
            }.frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            let testNotes = MyNotes()
            testNotes.folders = testFolder
           return ContentView(myNotes: testNotes)
        }
    }
}
