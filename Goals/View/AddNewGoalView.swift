//
//  AddNewGoalView.swift
//  Goals
//
//  Created by Anis Agwan on 01/01/22.
//

import SwiftUI

struct AddNewGoalView: View {
    @StateObject private var addGoalVM: AddGoalViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    init(repo: GoalRepositoryProtocol) {
        _addGoalVM = StateObject<AddGoalViewModel>.init(wrappedValue: AddGoalViewModel(repo: repo))
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Form {
                    Section {
                        TextField("Goal Name", text: $addGoalVM.name)
                        
                        DatePicker(selection: $addGoalVM.dueOnDate, in: Date()..., displayedComponents: .date) {
                            Text("Select Goal due date")
                        }.id(addGoalVM.dueOnDate)
                        
                        ColorPicker("Select goal color", selection: $addGoalVM.color)
                        
                        EmojiTextField(text: $addGoalVM.icon, placeholder: "Enter goal emoji")
                    }
                }
                .frame(maxHeight: 200)
                
                List {
                    HStack {
                        TextField("Enter goal", text: $addGoalVM.goal)
                            .onSubmit {
                                addGoalVM.addGoalToList(item: addGoalVM.goal)
                            }
                            .submitLabel(.return)
                    }
                    
                    ForEach(addGoalVM.items, id: \.self) {
                        item in Text(item)
                    }
                }
                .listStyle(.insetGrouped)
                .navigationTitle("New Goal")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.primary)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            addGoalVM.add()
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Save")
                                .foregroundColor(.primary)
                        }
                    }
                }
                
            }
        }
    }
}

struct AddNewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewGoalView(repo: MockGoalRepository())
    }
}
