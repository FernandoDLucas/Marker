//
//  ShelfCollectionViewModel.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 24/04/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import Foundation
import UIKit
import NetworkingKit

protocol ShelfCollectionViewModelDelegate: AnyObject {
    func handleUpdate() 
}
protocol ShelfCollectionViewModelProtocol: UICollectionViewDelegate, UICollectionViewDataSource{
    var delegate: ShelfCollectionViewModelDelegate? { get set }
    func initialFetch()
    func fetch(index: Int)
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
        let comics = try? repository.retrieveAll()
        self.comics =  comics ?? []
        delegate?.handleUpdate()
    }
    
    func fetch(index: Int) {
        let status = getCaseForIndex(index: index)
        guard let comics = try? repository.retrieve(status: status) else {
            return
        }
        self.comics = comics
        delegate?.handleUpdate()
    }
    
    func getCaseForIndex(index: Int) -> ComicStatus {
        switch index {
        case 0:
            return .reading
        case 1:
            return .read
        case 2:
            return .wantToRead
        default:
            return .reading
        }
    }
}

extension ShelfCollectionViewModel: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShelfCollectionViewCell.reuseIdentifier, for: indexPath) as? ShelfCollectionViewCell else {
            return UICollectionViewCell()
        }
        let data = comics[indexPath.row].cover
        let image = UIImage(data: data ?? Data())
        cell.configure(with: image)
        return cell
    }
    
}
