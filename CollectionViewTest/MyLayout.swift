//
//  MyLayout.swift
//  CollectionViewTest
//
//  Created by Yura on 28.07.2023.
//

import UIKit

//class AlignLeftFlowLayout: UICollectionViewFlowLayout {
//
//    var maximumCellSpacing = CGFloat(9.0)
//
//    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
//        let attributesToReturn = super.layoutAttributesForElementsInRect(rect) as? [UICollectionViewLayoutAttributes]
//
//        for attributes in attributesToReturn ?? [] {
//            if attributes.representedElementKind == nil {
//                attributes.frame = self.layoutAttributesForItemAtIndexPath(attributes.indexPath).frame
//            }
//        }
//
//        return attributesToReturn
//    }
//



//    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
//        let curAttributes = super.layoutAttributesForItemAtIndexPath(indexPath)
//        let sectionInset = (self.collectionView?.collectionViewLayout as UICollectionViewFlowLayout).sectionInset
//
//        if indexPath.item == 0 {
//            let f = curAttributes.frame
//            curAttributes.frame = CGRectMake(sectionInset.left, f.origin.y, f.size.width, f.size.height)
//            return curAttributes
//        }
//
//        let prevIndexPath = NSIndexPath(forItem: indexPath.item-1, inSection: indexPath.section)
//        let prevFrame = self.layoutAttributesForItemAtIndexPath(prevIndexPath).frame
//        let prevFrameRightPoint = prevFrame.origin.x + prevFrame.size.width + maximumCellSpacing
//
//        let curFrame = curAttributes.frame
//        let stretchedCurFrame = CGRectMake(0, curFrame.origin.y, self.collectionView!.frame.size.width, curFrame.size.height)
//
//        if CGRectIntersectsRect(prevFrame, stretchedCurFrame) {
//            curAttributes.frame = CGRectMake(prevFrameRightPoint, curFrame.origin.y, curFrame.size.width, curFrame.size.height)
//        } else {
//            curAttributes.frame = CGRectMake(sectionInset.left, curFrame.origin.y, curFrame.size.width, curFrame.size.height)
//        }
//
//        return curAttributes
//    }
//}

open class MyLayout: UICollectionViewFlowLayout {
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        return super.layoutAttributesForElements(in: rect)?.map { $0.representedElementKind == nil ? layoutAttributesForItem(at: $0.indexPath)! : $0 }
        
        let attributesToReturn = super.layoutAttributesForElements(in: rect) as? [UICollectionViewLayoutAttributes] ?? []

        for attributes in attributesToReturn {
            if attributes.representedElementKind == nil {
                if let layoutForItem = self.layoutAttributesForItem(at: attributes.indexPath) {
                    attributes.frame = layoutForItem.frame
                    print(layoutForItem.frame)
                }
            }
        }
        return attributesToReturn
        
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let curAttributes = super.layoutAttributesForItem(at: indexPath)
        
        let maximumCellSpacing: CGFloat = 15
        
        if let curAttributes = curAttributes, let flowLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            
            let sectionInset = flowLayout.sectionInset
                
            if indexPath.item == 0 {
                let f = curAttributes.frame
                curAttributes.frame = CGRectMake(sectionInset.left, f.origin.y, f.size.width, f.size.height)
                return curAttributes
            }
            
            let prevIndexPath = IndexPath(item: indexPath.item-1, section: indexPath.section)
            if let lafiaip = self.layoutAttributesForItem(at: prevIndexPath) {
                let prevFrame = lafiaip.frame
                let prevFrameRightPoint = prevFrame.origin.x +
                                          prevFrame.size.width + maximumCellSpacing
                
                let curFrame = curAttributes.frame
                let stretchedCurFrame = CGRectMake(0, curFrame.origin.y, self.collectionView!.frame.size.width, curFrame.size.height)
                
                if CGRectIntersectsRect(prevFrame, stretchedCurFrame) {
                    curAttributes.frame = CGRectMake(prevFrameRightPoint, curFrame.origin.y, curFrame.size.width, curFrame.size.height)
                } else {
                    curAttributes.frame = CGRectMake(sectionInset.left, curFrame.origin.y, curFrame.size.width, curFrame.size.height)
                }
            }
        }
        
                return curAttributes
    }
    

//    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        guard let currentItemAttributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes,
//            collectionView != nil else {
//            // should never happen
//            return nil
//        }
//
//        // if the current frame, once stretched to the full row intersects the previous frame then they are on the same row
//        if indexPath.item != 0,
//            let previousFrame = layoutAttributesForItem(at: IndexPath(item: indexPath.item - 1, section: indexPath.section))?.frame,
//            currentItemAttributes.frame.intersects(CGRect(x: -.infinity, y: previousFrame.origin.y, width: .infinity, height: previousFrame.size.height)) {
//            // the next item on a line
//            currentItemAttributes.frame.origin.x = previousFrame.origin.x + previousFrame.size.width + evaluatedMinimumInteritemSpacingForSection(at: indexPath.section)
//        } else {
//            // the first item on a line
//            currentItemAttributes.frame.origin.x = evaluatedSectionInsetForSection(at: indexPath.section).left
//        }
//        return currentItemAttributes
//    }
//
//    func evaluatedMinimumInteritemSpacingForSection(at section: NSInteger) -> CGFloat {
//        return (collectionView?.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(collectionView!, layout: self, minimumInteritemSpacingForSectionAt: section) ?? minimumInteritemSpacing
//    }
//
//    func evaluatedSectionInsetForSection(at index: NSInteger) -> UIEdgeInsets {
//        return (collectionView?.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(collectionView!, layout: self, insetForSectionAt: index) ?? sectionInset
//    }
}
