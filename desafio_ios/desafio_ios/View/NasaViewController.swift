//
//  NasaViewController.swift
//  desafio_ios
//
//  Created by Lelio Jorge on 29/03/21.
//

import UIKit

class NasaViewController: UIViewController {
    
    private var viewModel: NasaViewModel
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(NasaCell.self, forCellWithReuseIdentifier: NasaCell.identifier)
        return collectionView
    }()
    private var nasa: [Nasa] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        viewModel = NasaViewModel(manager: AlamofireManager())
        super.init(nibName: nil, bundle: nil)
        viewModel.getNasa(completion: { [weak self] (response) in
            self?.nasa.append(contentsOf: response)
            self?.collectionView.reloadData()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        super.loadView()
        setupView()
    }

}

// MARK: - Delegate
extension NasaViewController: UICollectionViewDelegate {
    
}
// MARK: - DataSource
extension NasaViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nasa.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NasaCell.identifier, for: indexPath) as! NasaCell
        cell.downloadImage = {
            self.viewModel.getImage(nasa: self.nasa[indexPath.row], index: indexPath.row, completion: { (image) in
                cell.populate(with: image)
            })
        }
        cell.nasa = self.nasa[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         if (indexPath.row == nasa.count / 2) {
            viewModel.getNasa(completion: { [weak self] (response) in
                self?.nasa.append(contentsOf: response)
                self?.collectionView.reloadData()
            })
         }
    }
    
}
// MARK: - ViewCoding
extension NasaViewController: ViewCoding {
    
    func buildViewHierarchy() {
        self.view.addSubview(collectionView)

    }
    
    func setupConstraints() {
        self.collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        print(self.view.bounds)
    }
    
    
}

extension NasaViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.bounds.width / 2) - 10, height: (self.view.bounds.height / 2) - 30)
    }
}
