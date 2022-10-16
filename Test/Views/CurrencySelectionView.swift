//
//  CurrencySelectionView.swift
//  Test
//
//  Created by Chris Andrews on 15/10/2022.
//

import SwiftUI

struct CurrencySelectionView: View {
    
    @Environment(\.presentationMode) private var presentationMode

    @AppStorage(Constants.selectedCurrencyKey) var selectedCurrency: Currencies = .GBP

    var body: some View {
        
        VStack {
            
            List {
                
                ForEach(Currencies.allCases) { currency in
                    Button(currency.stringDescription) {
                        selectedCurrency = currency
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct CurrencySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySelectionView()
    }
}
