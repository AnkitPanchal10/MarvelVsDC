//
//  ViewController.swift
//  MarvelVsDC
//
//  Created by Ankit Panchal on 08/01/23.
//

import UIKit
import CoreMotion
import SkeletonView

enum TableViewSection: Int {
    case marvel = 0, dc
}

class ComicViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: ComicProtocol
    
    
    // MARK: - UIComponents
    private let comicTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.rowHeight = 240
        tableView.estimatedRowHeight = 240
        tableView.allowsSelection = false
        tableView.isSkeletonable = true
        return tableView
    }()
    
    private var comicCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        layout.minimumLineSpacing = 20
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.itemSize =  CGSize(width: screenWidth - 20, height: 150)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 370), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.isSkeletonable = true
        return collectionView
    }()
    
    // MARK: - Life Cycle Methods
    init(viewModel: ComicProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        uiSetup()
    }
    
}

// MARK : - Private Methods
private extension ComicViewController{
    
     func initialSetup() {
        view.backgroundColor = .white
        comicTableView.dataSource = self
        comicTableView.delegate = self
        comicTableView.register(UINib(nibName: ComicTableViewCell.identidier, bundle: nil), forCellReuseIdentifier: ComicTableViewCell.identidier)
        comicTableView.register(UINib(nibName: MarvelTableViewCell.identidier, bundle: nil), forCellReuseIdentifier: MarvelTableViewCell.identidier)
        loadOrderHistory()
    }
    
     func uiSetup() {
        // TableView
        view.addSubview(comicTableView)
        comicTableView.constrainEdges(to: view.safeAreaLayoutGuide)
    }
    
     func loadOrderHistory() {
        showLoading()
        viewModel.requestComicsAPI { [weak self] status in
            guard let self = self else {
                return
            }
            if status {
                self.comicTableView.reloadData()
            }
            self.hideLoading()
        }
    }
    
     func collectionViewSetup(){
        // CollectionView
        comicCollectionView.dataSource = self
        comicCollectionView.register(UINib(nibName: MarvelCollectionViewCell.identidier, bundle: nil), forCellWithReuseIdentifier: MarvelCollectionViewCell.identidier)
        comicCollectionView.reloadData()
    }
    
    func showLoading() {
       // Skeleton loading view
       let gradient = SkeletonGradient(baseColor: UIColor.lightGray)
       comicTableView.showAnimatedGradientSkeleton(usingGradient: gradient, transition: .crossDissolve(0.5))
    }
    
    func hideLoading() {
        // Skeleton loading view
        comicTableView.hideSkeleton(transition: .crossDissolve(0.5))
    }
    
}

// MARK: - UITableViewDataSource
extension ComicViewController: SkeletonTableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSectionsInTable()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.getSection(section: indexPath.section) {
        case .marvel:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MarvelTableViewCell.identidier, for: indexPath) as? MarvelTableViewCell else {
                return UITableViewCell()
            }
            cell.uiSetup(collectionView: comicCollectionView)
            collectionViewSetup()
            return cell
        case .dc:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ComicTableViewCell.identidier, for: indexPath) as? ComicTableViewCell else {
                return UITableViewCell()
            }
            guard let comic = viewModel.getComicItem(at: indexPath) else {
                return cell
            }
            cell.configure(item: comic)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch viewModel.getSection(section: section){
        case .marvel:
            return "Marvel"
        case .dc:
            return "DC Comic"
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return ComicTableViewCell.identidier
    }
}

// MARK: - UITableViewDelegate
extension ComicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.getSection(section: indexPath.section){
        case .marvel:
            return 160
        case .dc:
            return 240
        }
    }
    
}

// MARK: - UICollectionViewDataSource
extension ComicViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSectionsInCollection()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarvelCollectionViewCell.identidier, for: indexPath) as? MarvelCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let comic = viewModel.getComicItem(at: indexPath) else {
            return cell
        }
        cell.configure(item: comic)
        return cell
    }
    
}

