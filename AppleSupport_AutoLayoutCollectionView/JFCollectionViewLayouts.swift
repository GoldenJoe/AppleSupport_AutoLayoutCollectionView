//
//  JFCollectionViewLayouts.swift
//  WeThePeople
//
//  Created by Joseph Falcone on 5/27/17.
//  Copyright © 2017 Joseph Falcone. All rights reserved.
//

import Foundation
import UIKit

// Found at:
// https://stackoverflow.com/questions/26143591/specifying-one-dimension-of-cells-in-uicollectionview-using-auto-layout
//class HorizontallyFlushCollectionViewFlowLayout: UICollectionViewFlowLayout

// TODO: This does not work with section headers
// Single column, cells use autolayout
open class JFCVLayout_TableAuto : UICollectionViewFlowLayout
{
    // Don't forget to use this class in your storyboard (or code, .xib etc)
    /*
    private var cache = [UICollectionViewLayoutAttributes]()
    
    open override func prepare()
    {
        cache = [UICollectionViewLayoutAttributes]()
        guard let collectionView = collectionView else { return }
        
        let columnWidth = collectionView.bounds.width - sectionInset.left - sectionInset.right
        
        for section in 0 ..< collectionView.numberOfSections {
            for item in 0 ..< collectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                
                
                // Create our attributes
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(sectionInset.left, )
                cache.append(attributes)
            }
        }
        
        
        // xOffset tracks for each column. This is fixed, unlike yOffset.
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth )
        }
        
        // yOffset tracks the last y-offset in each column
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        
        // Start calculating for each item
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            
            let width = columnWidth - cellPadding * 2
            let cellHeight = delegate.collectionView(collectionView!, heightForCellAt: indexPath, withWidth: width)
            let height = cellHeight + 2*cellPadding
            
            // Find the shortest column to place this item
            var shortestColumn = 0
            if let minYOffset = yOffset.min() {
                shortestColumn = yOffset.index(of: minYOffset) ?? 0
            }
            
            let frame = CGRect(x: xOffset[shortestColumn], y: yOffset[shortestColumn], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // Create our attributes
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            // Updates
            contentHeight = max(contentHeight, frame.maxY)
            
            yOffset[shortestColumn] = yOffset[shortestColumn] + height
        }
    }
    */
    
    
    open override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath) else { return nil }
//        print("Section Attributes: \(attributes)")
        return attributes
    }
    
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath)
        if let attributes = attributes {
            guard let collectionView = collectionView else { return attributes }
            attributes.bounds.size.width = collectionView.bounds.width - sectionInset.left - sectionInset.right
        }
        return attributes
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]?
    {
        let allAttributes = super.layoutAttributesForElements(in: rect)
        return allAttributes?.flatMap { attributes in
            switch attributes.representedElementCategory {
            case .cell:
                return layoutAttributesForItem(at: attributes.indexPath)
            case .supplementaryView:
                return layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: attributes.indexPath)
            default: return attributes
            }
        }
    }
    
    // *****DEBUGGING VERSION*****
    /*
    open override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard let attributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath) else { return nil }
        print("Section Attributes: \(attributes)")
        return attributes
        
        
        guard let collectionView = collectionView else { return attributes }
        
        // Last index
        let section = indexPath.section
        let prevSection = section-1
        if section == 0 {
            return attributes
        }
        let lastItemIndex = collectionView.numberOfItems(inSection: prevSection)-1
        
        var newY : CGFloat = attributes.frame.origin.y
        print("Section: \(indexPath.section)")
        print("AttributeFrame: \(attributes.frame)")
        
        if let itemAttributes = layoutAttributesForItem(at: IndexPath(item: lastItemIndex, section: prevSection)){
            print("ItemAttributes: \(itemAttributes.frame)")
            //attributes?.frame.origin.y = itemAttributes.frame.origin.y + itemAttributes.frame.size.height
            newY = itemAttributes.frame.origin.y + itemAttributes.frame.size.height
        }
        
        print("newY: \(newY)")
        attributes.frame.origin.y = newY
        print("New Attributes: \(attributes.frame)")
        return attributes
    }
    
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        //        let attributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes
        let attributes = super.layoutAttributesForItem(at: indexPath)
        if let attributes = attributes {
            
//            print("LAFI_old Attributes: \(attributes)")
            guard let collectionView = collectionView else { return attributes }
            attributes.bounds.size.width = collectionView.bounds.width - sectionInset.left - sectionInset.right
            
            attributes.frame.origin.x = sectionInset.left
//            print("LAFI_new Attributes: \(attributes)")
        }
        return attributes
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]?
    {
        print("layoutAttributesForElements: \(rect)")
        
        let allAttributes = super.layoutAttributesForElements(in: rect)
        return allAttributes?.flatMap { attributes in
            switch attributes.representedElementCategory {
            //            case .cell: print("cell: \(attributes.indexPath)"); return layoutAttributesForItem(at: attributes.indexPath)
            case .cell:
                print("\ncell: \(attributes.indexPath)");
                print("cell_old Attributes: \(attributes)")
                let a = layoutAttributesForItem(at: attributes.indexPath)
                
                print("cell_new Attributes: \(a)")
                return a
            case .supplementaryView:
                print("\nsupp: \(attributes.indexPath)");
                return layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: attributes.indexPath)
            default: return attributes
            }
        }
    }
    */
    /*
    
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes?
    {
        let attributes = super.layoutAttributesForItem(at: indexPath)
        guard let collectionView = collectionView else { return attributes }
        attributes?.bounds.size.width = collectionView.bounds.width - sectionInset.left - sectionInset.right
        return attributes
    }
    */
    /*
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]?
    {
        print("layoutAttributesForElements: \(rect)")
        
        // Get all the attributes for the elements in the specified frame
        let allAttributesInRect = super.layoutAttributesForElements(in: rect)
        if let allAttributesInRect = allAttributesInRect {
            for var attribute in allAttributesInRect {
                switch attribute.representedElementCategory {
                case .cell:
                    attribute = layoutAttributesForItem(at: attribute.indexPath)!
                case .supplementaryView:
                    layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: attribute.indexPath)
                default:()
                }
            }
        }
        return allAttributesInRect
    }
 */
    
    
    
    // TODO: We should remove this when we figure out the section header problem in MyRepresentativesView. This shouldn't be needed.
    public func itemWidth() -> CGFloat {
        guard let cv = self.collectionView else {
            return 44
        }
        return cv.frame.width - sectionInset.left - sectionInset.right - cv.contentInset.left - cv.contentInset.right
    }
}

// Single column, cells have a fixed size
open class JFCVLayout_TableFixed: UICollectionViewFlowLayout {
    
    public var itemHeight: CGFloat = 44
    
    override public init() {
        super.init()
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        scrollDirection = .vertical
        minimumInteritemSpacing = 0
        minimumLineSpacing = 1
        //        self.minimumLineSpacing = 10000
    }
    
    public func itemWidth() -> CGFloat {
        guard let cv = self.collectionView else {
            return 44
        }
        return cv.frame.width - sectionInset.left - sectionInset.right - cv.contentInset.left - cv.contentInset.right
    }
    
    // TODO: Getting infinite loops when calling layout.itemSize elsewhere...fix it later. Meanwhile setting itemHeight is good enough
    override open var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth(), height: itemHeight)
        }
        get {
            print("Item size: \(CGSize(width: itemWidth(), height: itemHeight))")
            return CGSize(width: itemWidth(), height: itemHeight)
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.bounds.width, height: view.bounds.height / CGFloat(cities.count))
//    }
    
}


/*
 // TODO: Figure this out later, probably should give it its own file JFCollectionViewDecroations or something
 class LineDecorationView: UICollectionReusableView {
 
 override init() {
 super.init()
 setup()
 }
 
 required init?(coder aDecoder: NSCoder) {
 super.init(coder: aDecoder)
 setup()
 }
 
 func setup() {
 backgroundColor = .purple
 }
 
 override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
 self.frame = layoutAttributes.frame
 }
 }
 
 override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
 //https://stackoverflow.com/questions/28691408/uicollectionview-custom-line-separators
 }
 //layout.register(LineDecorationView.self, forDecorationViewOfKind: "Separator")
 */
