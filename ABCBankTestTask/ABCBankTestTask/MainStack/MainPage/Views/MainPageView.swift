//
//  MainPageView.swift
//  ABCBankTestTask
//
//  Created by Andrew Isaenko on 12/02/2026.
//

import SwiftUI

struct MainPageView<ViewModel: MainPageViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    @State private var searchText: String = ""
    @State private var selectedPageIndex: Int = 0
    @State private var isShowingStatistics: Bool = false
        
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
            .scrollDismissesKeyboard(.immediately)
            
            fabButton
        }
        .onAppear(perform: viewModel.loadData)
        .sheet(isPresented: $isShowingStatistics) {
            StatisticsView(statistics: viewModel.getStatistics())
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

// MARK: - Components

extension MainPageView {
    
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
        VStack(spacing: 0) {
            Divider()
            
            SearchBarView(text: $searchText)
                .onChange(of: searchText) { _, newValue in
                    viewModel.search(newValue)
                }
            
            Divider()
        }
        .background(.white)
    }
    
    private var itemsList: some View {
        LazyVStack(spacing: 0) {
            ForEach(viewModel.currentItems, id: \.self) { item in
                Text(item)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 60)
                    .padding(.horizontal, 16)
                    .background(Color(.systemBackground))
                
                Divider()
                    .padding(.leading, 16)
            }
        }
    }
    
    private var fabButton: some View {
        Button(action: {
            isShowingStatistics = true
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
