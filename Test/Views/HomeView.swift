//
//  ContentView.swift
//  Test
//
//  Created by Chris Andrews on 12/10/2022.
//

import SwiftUI
import Combine

class SheetMananger: ObservableObject{
    
    @Published var showDetailView = false
    @Published var selectedProduct: Product? = nil
}

struct HomeView: View {
    
    @AppStorage(Constants.selectedCurrencyKey) var selectedCurrency: Currencies = .GBP
    @ObservedObject private var viewModel: ProductViewModel
    @StateObject private var sheetMananger = SheetMananger()
    @State private var showModal = false
    
    init(viewModel: ProductViewModel) { self.viewModel = viewModel }
    
    var body: some View {
        
        NavigationStack {

            ScrollView(.vertical, showsIndicators: true) {
                
                LazyVStack(alignment: .center) {
                    
                    ForEach(viewModel.items ?? [Product]()) { product in
                        
                        ProductCardView(product: product)
                            .id(product.id)
                            .onTapGesture {
                                sheetMananger.showDetailView = true
                                sheetMananger.selectedProduct = product
                            }
                    }
                }
            }
            .sheet(isPresented: $sheetMananger.showDetailView) {
                if let product = $sheetMananger.selectedProduct.wrappedValue {
                    ProductDetailView(product: product)
                }
            }
            .padding(16)
            .navigationTitle("Test App")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                
                Button("Currency: \(selectedCurrency.shortSymbol)") {

                    showModal = true

                }.sheet(isPresented: $showModal) {
                    
                    CurrencySelectionView()
                }
            }
        }.onAppear() { viewModel.fetchHomePageContent() }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        HomeView(viewModel: ProductViewModel(fashionAPIClient: MockAPIClient(), currencyConversionAPIClient: MockAPIClient()))
    }
}

