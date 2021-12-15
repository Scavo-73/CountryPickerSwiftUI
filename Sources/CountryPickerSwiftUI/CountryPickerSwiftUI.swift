//
//  CountryPicker.swift
//  CustomCountryPickerSwiftUI
//
//  Created by Oskar Joziak on 14/12/21.
//

import SwiftUI

public struct CountryPicker: View {
    
    @State var CountrySelectedColor: Color = Color.green
    @State var cournerRadiusCountrySelcted: Int = 10
    @State var backgroundColorList: Color = Color.black
    @State var show: Bool = false
    @State var country: Country = Country(countryCode: "", name: "", currencyCode: "", currencySimbol: "", phoneCode: "", flag: "")
    
    /// You can quiclky add this module to your own porject that requires custom shapes and colors
    ///
    /// - Parameters:
    ///   - CountrySelectedColor: Backgorund button color when country is selected
    ///   - cournerRadiusCountrySelcted: Courner radius button for contry selcted
    ///   - backgroundColorList: Backgorund color List
    ///   - show: Boolean for the List
    
    public init(CountrySelectedColor: Color = Color.green, cournerRadiusCountrySelcted: Int = 10, backgroundColorList: Color = Color.black, show: Bool = false) {
        self.CountrySelectedColor = CountrySelectedColor
        self.cournerRadiusCountrySelcted = cournerRadiusCountrySelcted
        self.backgroundColorList = backgroundColorList
        self.show = show
    }
    
 public var body: some View {
        
        Button(country.name.isEmpty ? "Choose a country" : country.name) {
            // Your code here
            show = true
        }.sheet(isPresented: $show, onDismiss: {
            show = false
        }) {
            ListView(showPhoneNumber: show,  CountrySelectedColor: CountrySelectedColor, cournerRadiusCountrySelcted: cournerRadiusCountrySelcted, backgroundColorList: backgroundColorList, showCountries: $show, countrySelected: $country)
        }
    }
}
