//
//  ViewController.swift
//  ABCBankTestTask
//
//  Created by Andrew Isaenko on 09/02/2026.
//

import UIKit

final class CarouselViewController: UIViewController {

    var presenter: CarouselPresenterProtocol
    
    private var pages: [PageModel] = []
    private var currentItems: [String] = []
    private var itemsListViewHeightConstraint: NSLayoutConstraint?
    
    // Containers
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.delegate = self
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
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ListItemCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var itemsListDataSource: UITableViewDiffableDataSource<Int, String>?
    
    // Searchbars
    private lazy var searchBarView: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search items..."
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var stickySearchBarView: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search items..."
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.isHidden = true
        return searchBar
    }()
    
    // Fab Button
    private lazy var fabButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("📊", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 30
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.3
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(fabButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: Lyfecycle
    
    init(presenter: CarouselPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupConstraints()
        setupKeyboardDismissGesture()
        setupItemsListDataSource()
        presenter.viewDidLoad()
    }
    
    // MARK: Private methods
    
    private func setupAppearance() {
        view.backgroundColor = .white
    }
    
    @objc private func fabButtonTapped() {
        presenter.didTapStatistics()
    }
    
    private func setupKeyboardDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupItemsListDataSource() {
        itemsListDataSource = UITableViewDiffableDataSource<Int, String>(tableView: itemsListView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
            cell.textLabel?.text = item
            return cell
        }
    }
    
}

// MARK: - CarouselViewControllerProtocol realisation

extension CarouselViewController: CarouselViewControllerProtocol {
    
    func displayPages(_ pages: [PageModel]) {
        self.pages = pages
        carouselView.reloadData()
    }
    
    func displayCurrentPage(_ index: Int, items: [String]) {
        self.currentItems = items
        let height = CGFloat(items.count) * 60
        itemsListViewHeightConstraint?.constant = height
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        itemsListDataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func displayStatistics(_ statistics: StatisticsModel) {
        let statsViewController = StatisticsViewController(statistics: statistics)
        if let sheet = statsViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        present(statsViewController, animated: true)
    }
    
}

// MARK: - CollectionView delegate & datasource (For the carousel)

extension CarouselViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        guard scrollView == carouselView else { return }
        
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        presenter.didSelectPage(pageIndex)
    }
    
}

// MARK: - UIScrollViewDelegate (for sticky search bar)

extension CarouselViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == self.scrollView else { return }
        
        let searchBarY = carouselView.frame.height
        let scrollOffset = scrollView.contentOffset.y
        
        if scrollOffset >= searchBarY {
            stickySearchBarView.isHidden = false
            stickySearchBarView.text = searchBarView.text
            searchBarView.alpha = 0
        } else {
            stickySearchBarView.isHidden = true
            searchBarView.alpha = 1
        }
    }
    
}

// MARK: - UITableView delegate

extension CarouselViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

// MARK: - UISearchBar delegate

extension CarouselViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.didSearch(searchText)
        
        searchBarView.text = searchText
        stickySearchBarView.text = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}

// MARK: - Constraints Setup

extension CarouselViewController {
    
    private func setupConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(carouselView)
        contentView.addSubview(searchBarView)
        contentView.addSubview(itemsListView)
        view.addSubview(fabButton)
        view.addSubview(stickySearchBarView)
        
        setupStickySearchBarConstraints()
        setupScrollViewConstraints()
        setupContentViewConstraints()
        setupCarouselViewConstraints()
        setupSearchBarConstraints()
        setupItemsListViewConstraints()
        setupFabButtonConstraints()
    }
    
    private func setupStickySearchBarConstraints() {
        NSLayoutConstraint.activate([
            stickySearchBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stickySearchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stickySearchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stickySearchBarView.heightAnchor.constraint(equalToConstant: 56)
        ])
        stickySearchBarView.layer.zPosition = 1000
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
    
    private func setupSearchBarConstraints() {
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: carouselView.bottomAnchor),
            searchBarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            searchBarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            searchBarView.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
        
    private func setupItemsListViewConstraints() {
        itemsListViewHeightConstraint = itemsListView.heightAnchor.constraint(
            equalToConstant: CGFloat(currentItems.count) * 60
        )
        NSLayoutConstraint.activate([
            itemsListView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor),
            itemsListView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemsListView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemsListView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            itemsListViewHeightConstraint ?? itemsListView.heightAnchor.constraint(
                equalToConstant: CGFloat(currentItems.count) * 60
            )
        ])
    }
    
    private func setupFabButtonConstraints() {
        NSLayoutConstraint.activate([
            fabButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            fabButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            fabButton.widthAnchor.constraint(equalToConstant: 60),
            fabButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
}
