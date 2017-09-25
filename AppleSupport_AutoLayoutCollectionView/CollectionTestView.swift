//
//  CollectionTestView.swift
//  AppleSupport_AutoLayoutCollectionView
//
//  Created by Joseph Falcone on 9/17/17.
//  Copyright © 2017 Joseph Falcone. All rights reserved.
//

import UIKit

class CollectionTestView: UIView
{
    
    let cv_layout = JFCVLayout_TableAuto()
    var collectionView : UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup()
    {
        backgroundColor = .green
        
        // The provided size should be a plausible estimate of the actual
        // size. You can set your item size in your storyboard
        // to a good estimate and use the code below. Otherwise,
        // you can provide it manually too, e.g. CGSize(width: 100, height: 100)
        
        cv_layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        cv_layout.minimumLineSpacing = 16
//        cv_layout.estimatedItemSize = CGSize(width: 300, height: 800)
        cv_layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        cv_layout.headerReferenceSize = CGSize(width: 0, height: 40)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: cv_layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.blue
        collectionView.register(CollectionTestHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CellHeaderView")
        collectionView.register(CollectionTestCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        // Assemble
        self.addSubview(collectionView)
        
        // Layout
        collectionView.constrain_edges(to: self)
    }
}

extension CollectionTestView : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
}

extension CollectionTestView : UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        guard let c = cell as? CollectionTestCell else {
            return cell
        }
        
        var str = "TestA"
        for _ in 0..<indexPath.row {
            str += "\nRow\(indexPath.row)"
        }
        c.label_A.text = str
        
        // NOTE_1
        // Uncomment the line below to REALLY mess up the cells
        //c.label_A.text = "Experiment with Swift standard library types and learn high-level concepts using visualizations and practical examples. Learn how the Swift standard library uses protocols and generics to express powerful constraints. Download the playground below to get started."
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        switch kind
        {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "CellHeaderView",
                                                                             for: indexPath) as! CollectionTestHeader
            switch indexPath.section
            {
            case 0:
                headerView.label_title.text = "SECTION 0"
            case 1:
                headerView.label_title.text = "SECTION 1"
            default:
                assertionFailure("\(#function) - Invalid section: \(indexPath.section)")
            }
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
        return UICollectionReusableView()
    }
}

