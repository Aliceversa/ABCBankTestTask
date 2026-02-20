//
//  CarouselView.swift
//  ABCBankTestTask
//
//  Created by Andrew Isaenko on 12/02/2026.
//

import SwiftUI

struct CarouselView<ViewModel: CarouselViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    @State private var searchText: String = ""
    @State private var selectedPageIndex: Int = 0
        
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack(spacing: 0) {
                    imagesCarousel
                    
                    LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                        Section {
                            itemsList
                        } header: {
                            searchBar
                        }
                    }
                }
            }
            
            fabButton
        }
        .onAppear(perform: viewModel.loadData)
        .sheet(isPresented: $viewModel.isShowingStatistics) {
            StatisticsView(statistics: viewModel.getStatistics())
        }
    }
    
}

// MARK: - Components

extension CarouselView {
    
    private var imagesCarousel: some View {
        TabView(selection: $selectedPageIndex) {
            ForEach(viewModel.pages.indices, id: \.self) { index in
                Image(viewModel.pages[index].imageName)
                    .resizable()
                    .scaledToFit()
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 250)
        .onChange(of: selectedPageIndex) { _, newIndex in
            viewModel.selectPage(newIndex)
        }
    }
    
    private var searchBar: some View {
        SearchBarView(text: $searchText)
            .onChange(of: searchText) { _, newValue in
                viewModel.search(newValue)
            }
    }
    
    private var itemsList: some View {
        LazyVStack(spacing: 0) {
            ForEach(viewModel.currentItems, id: \.self) { item in
                Text(item)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 60)
                    .padding(.horizontal, 16)
                    .background(Color(.systemBackground))
            }
        }
    }
    
    private var fabButton: some View {
        Button(action: {
            viewModel.isShowingStatistics = true
        }) {
            Text("📊")
                .font(.system(size: 30))
                .frame(width: 60, height: 60)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Circle())
                .shadow(radius: 4)
        }
        .padding()
    }
}
