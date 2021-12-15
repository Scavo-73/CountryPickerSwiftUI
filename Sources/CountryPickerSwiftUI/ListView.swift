//
//  View.swift
//  CustomCountryPickerSwiftUI
//
//  Created by Oskar Joziak on 14/12/21.
//

import SwiftUI

public struct ListView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let rightToLeftLanguage: Bool = isRightToLeft
    @State var showPhoneNumber: Bool
    @State private var searchText = ""
    @State var CountrySelectedColor: Color
    @State var cournerRadiusCountrySelcted: Int
    @State var backgroundColorList: Color
    
    @Binding var showCountries: Bool
    @Binding var countrySelected: Country
    
    var list: [Country] = getAllCountries()
    
    public var body: some View {
        NavigationView {
            if #available(iOS 15.0, *) {
                VStack {
                    HStack{
                        HStack {
                            Image(systemName: "magnifyingglass")
                            TextField("search", text: $searchText, onEditingChanged: {_ in }, onCommit: {}).foregroundColor(.primary)
                            Button(action: {
                                self.searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                            }
                        }
                        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                        .foregroundColor(.secondary)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10.0)
                        .environment(\.layoutDirection, rightToLeftLanguage ? .rightToLeft : .leftToRight)
                        
                        Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                    .padding()
                    
                    List{
                        ForEach(Array(searchResults.enumerated()), id: \.element) { index, element in
                            Button(action: {
                                countrySelected = element
                                showCountries = false
                                print(element.name)
                                
                            }, label: {
                                VStack {
                                    HStack{
                                        Text(element.flag!)
                                            .font(.system(size: 35))
                                        Text(element.name)
                                            .foregroundColor(.white)
                                            .fontWeight(.bold)
                                        Spacer()
                                        if showCountries {
                                            Text(element.phoneCode)
                                                .foregroundColor(.white)
                                                .fontWeight(.bold)
                                        }
                                    }.environment(\.layoutDirection, rightToLeftLanguage ? .rightToLeft : .leftToRight)
                                }
                                .padding(.trailing, 20)
                                .padding(.leading, 20)
                            }).listRowBackground(Color.clear).background(self.countrySelected == element ? CountrySelectedColor : Color.clear).cornerRadius(10.0)
                        }
                    }.background(Color.black)
                        .onAppear() {
                            UITableView.appearance().backgroundColor = UIColor(backgroundColorList)
                        }
                        .padding([.horizontal], -30)
                }
                .background(.black)
                .navigationBarHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                .resignKeyboardOnDragGesture()
            } else {
                // Fallback on earlier versions
            }
           
        }
    }
    
    var searchResults: [Country] {
        if searchText.isEmpty {
            return list
        } else {
            return list.filter { $0.name.contains(searchText) }
        }
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}


struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
