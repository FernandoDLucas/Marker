//
//  DKComicCollectionView.swift
//  DesignKit
//
//  Created by Fernando de Lucas da Silva Gomes on 23/04/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import Foundation
import UIKit

public final class DKComicCollectionViewLayout: UICollectionViewFlowLayout {
    
    override public var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    private let numberOfColumns: Int
    private let cellPadding: CGFloat
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    private var column: Int = 0
    private var yOffSet: [CGFloat] = []
    private var xOffSet: [CGFloat] = []

    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return .zero
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    public init(
        numberOfColumns: Int = 2,
        cellPadding: CGFloat = 6
    ) {
        self.numberOfColumns = numberOfColumns
        self.cellPadding = cellPadding
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func prepare() {

        guard let collectionView = collectionView else {
            return
        }
        cache.removeAll()
        contentHeight = 0
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        for column in 0..<numberOfColumns {
            xOffSet.append(CGFloat(column) * columnWidth)
        }
        yOffSet = .init(repeating: 0, count: numberOfColumns)
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let height = prepareHeightFromIndex(index: item)
            let frame = CGRect(x: xOffSet[column],
                               y: yOffSet[column],
                               width: columnWidth,
                               height: height)

            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

            // Create one instance of UICollectionViewLayoutAttributes change it frame using insetFrame and add the attributes in cache
            let atributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            atributes.frame = insetFrame
            cache.append(atributes)

            //Expand the contentHeight to fit the frame in the new calculated Item. So, add the current yOffSet, for the current column based on the frame. Finally, add a new column and the next item will be add in the next Column.
            contentHeight = max(contentHeight, frame.maxY)
            yOffSet[column] = yOffSet[column] + height
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }

    override public func layoutAttributesForElements(in rect: CGRect)
    -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }

    override public func layoutAttributesForItem(at indexPath: IndexPath)
    -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }

    func prepareHeightFromIndex(index: Int) -> CGFloat {
        if index % 3 == 0 {
            return 180
        } else if index % 3 == 1 {
            return 400
        } else {
            return 230
        }
    }

    func emptyCache() {
        cache = []
    }
}
