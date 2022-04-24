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
}

final class ShelfCollectionViewModel: NSObject, ShelfCollectionViewModelProtocol {
    
    private let repository: NKComicRepositoryProtocol
    private var comic: [Comic] = []
    weak var delegate: ShelfCollectionViewModelDelegate? = nil

    init(
        repository: NKComicRepositoryProtocol
    ) {
        self.repository = repository
        super.init()
    }
    
    func initialFetch() {
        let comics = try? repository.retrieveAll()
        self.comic =  comics ?? []
        delegate?.handleUpdate()
    }
}

extension ShelfCollectionViewModel: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as UICollectionViewCell
        cell.backgroundColor = .red
        return cell
    }
    
}
