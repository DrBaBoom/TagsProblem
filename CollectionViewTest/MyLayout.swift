//
//  MyLayout.swift
//  CollectionViewTest
//
//  Created by Yura on 28.07.2023.
//

import UIKit

open class MyLayout: UICollectionViewFlowLayout {
    
    private var cachedFramesOfItems: [IndexPath: CGRect] = [:]
    
    // Retrieves the layout attributes for ALL of the cells and views in the specified rectangle.
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributesToReturn = super.layoutAttributesForElements(in: rect) ?? []

        for attributes in attributesToReturn {
            if attributes.representedElementKind == nil {
                if let layoutForItem = self.layoutAttributesForItem(at: attributes.indexPath) {
                    attributes.frame = layoutForItem.frame
                }
            }
        }
        return attributesToReturn
        
    }
    
    // Retrieves layout information for an item at the specified index path with a corresponding cell.
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let curAttributes = super.layoutAttributesForItem(at: indexPath)
        
        let maximumCellSpacing: CGFloat = 35
        
        if let curAttributes = curAttributes, let flowLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            let sectionInset = flowLayout.sectionInset
                
            if indexPath.item == 0 {
                let f = curAttributes.frame
                curAttributes.frame =  CGRectMake(sectionInset.left, f.origin.y, f.size.width, f.size.height)
            } else {
                let prevIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section)
                
                if let prevItemFrame = cachedFramesOfItems[prevIndexPath] {
                    let curFrame = curAttributes.frame
                    
                    if (prevItemFrame.maxX + maximumCellSpacing + curFrame.size.width <= self.collectionView!.frame.size.width - sectionInset.right) {
                        curAttributes.frame = CGRectMake(prevItemFrame.maxX + maximumCellSpacing,
                                                         prevItemFrame.minY,
                                                         curFrame.size.width,
                                                         curFrame.size.height)
                    } else {
                        curAttributes.frame = CGRectMake(sectionInset.left,
                                                         prevItemFrame.maxY + maximumCellSpacing,
                                                         curFrame.size.width,
                                                         curFrame.size.height)
                    }
                }
            }
            cachedFramesOfItems[indexPath] = curAttributes.frame
        }
        
        return curAttributes
    }
}

