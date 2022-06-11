//
//  ShelfCollectionViewModel.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 24/04/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import Strategy
import NetworkingKit
import UIKit

protocol ShelfCollectionViewModelDelegate: AnyObject {
    func handleUpdate()
    func didSelectCellWithObjec(object: Comic)
}
protocol ShelfCollectionViewModelProtocol: CollectionViewModelProtocol {
    var delegate: ShelfCollectionViewModelDelegate? { get set }
    func initialFetch()
    func fetch(status: ComicStatus)
}

final class ShelfCollectionViewModel: NSObject, ShelfCollectionViewModelProtocol {
    
    private let repository: NKComicRepositoryProtocol
    private var comics: [Comic] = []
    weak var delegate: ShelfCollectionViewModelDelegate? = nil

    init(
        repository: NKComicRepositoryProtocol
    ) {
        self.repository = repository
        super.init()
    }
    
    func initialFetch() {
        guard let comics = try? repository.retrieve(status: .reading) else {
            return
        }
        self.comics = comics
        delegate?.handleUpdate()
    }
    
    func fetch(status: ComicStatus) {
        guard let comics = try? repository.retrieve(status: status) else {
            return
        }
        self.comics = comics
        delegate?.handleUpdate()
    }
    
    func delete(comic: Comic) {
        try? repository.delete(comic)
        comics.removeAll {
            $0 == comic
        }
        delegate?.handleUpdate()
    }
}

extension ShelfCollectionViewModel: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return comics.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShelfCollectionViewCell.reuseIdentifier, for: indexPath) as? ShelfCollectionViewCell else {
            return UICollectionViewCell()
        }
        let data = comics[indexPath.row].cover
        let image = UIImage(data: data ?? Data())
        cell.configure(with: image)
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShelfCollectionViewCell.reuseIdentifier, for: indexPath) as? ShelfCollectionViewCell else {
            return
        }
        let comic = comics[indexPath.row]
        if cell.isPresentingEditMode {
            delete(comic: comic)
        } else {
            delegate?.didSelectCellWithObjec(object: comic)
        }
    }
}
