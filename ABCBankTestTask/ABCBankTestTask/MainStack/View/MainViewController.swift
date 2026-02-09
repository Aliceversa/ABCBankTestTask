//
//  ViewController.swift
//  ABCBankTestTask
//
//  Created by Alice Versa on 09/02/2026.
//

import UIKit

class MainViewController: UIViewController {

    var presenter: MainPresenterProtocol
    private var pages: [PageModel] = []
    private var currentItems: [String] = []
    
    private var itemsListViewHeightConstraint: NSLayoutConstraint!
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Carousel
    private lazy var carouselView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.reuseId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // Items list
    private lazy var itemsListView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ListItemCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // Searchbar
    private lazy var searchBarView: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search items..."
        searchBar.delegate = self
        return searchBar
    }()
    
    // TODO: button
    
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }
        
}

// MARK: - UI setup

extension MainViewController {
    
    private func setupUI() {
        view.backgroundColor = .blue
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(carouselView)
        contentView.addSubview(itemsListView)
        
        setupScrollViewConstraints()
        setupContentViewConstraints()
        setupCarouselViewConstraints()
        setupItemsListViewConstraints()
    }
    
    private func setupScrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupContentViewConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupCarouselViewConstraints() {
        NSLayoutConstraint.activate([
            carouselView.topAnchor.constraint(equalTo: contentView.topAnchor),
            carouselView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            carouselView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            carouselView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
        
    private func setupItemsListViewConstraints() {
        itemsListViewHeightConstraint = itemsListView.heightAnchor.constraint(
            equalToConstant: CGFloat(currentItems.count) * 60 + 50
        )
        NSLayoutConstraint.activate([
            itemsListView.topAnchor.constraint(equalTo: carouselView.bottomAnchor, constant: 20),
            itemsListView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemsListView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemsListView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            itemsListViewHeightConstraint
        ])
    }
    
}

// MARK: - CollectionView delegate & datasource

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CarouselCell.reuseId,
            for: indexPath
        ) as? CarouselCell else {
            return UICollectionViewCell()
        }
        
        let imageName = pages[indexPath.row].imageName
        cell.configureWith(imageName: imageName)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        presenter.didSelectPage(pageIndex)
    }
    
}

// MARK: - UITableView delegate & datasource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
        cell.textLabel?.text = currentItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        searchBarView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
}

// MARK: - UISearchBar delegate

extension MainViewController: UISearchBarDelegate {
    
}

// MARK: - MainViewProtocol

extension MainViewController: MainViewProtocol {
    
    func displayPages(_ pages: [PageModel]) {
        self.pages = pages
        carouselView.reloadData()
    }
    
    func displayCurrentPage(_ index: Int, items: [String]) {
        self.currentItems = items
        
        let height = CGFloat(items.count) * 60 + 50
        itemsListViewHeightConstraint.constant = height
        
        itemsListView.reloadData()
    }
    
}
