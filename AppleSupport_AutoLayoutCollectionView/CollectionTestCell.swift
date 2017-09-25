//
//  CollectionTestCell.swift
//  AppleSupport_AutoLayoutCollectionView
//
//  Created by Joseph Falcone on 9/17/17.
//  Copyright © 2017 Joseph Falcone. All rights reserved.
//

import UIKit

// A simple cell that contains two labels stacked on top of each other, separated by a horizontal line
class CollectionTestCell: UICollectionViewCell
{
    let label_A     = UILabel()
    let label_B     = UILabel()
    
    override init(frame: CGRect)            { super.init(frame: frame);     setup() }
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder);  setup() }
    func setup()
    {
        let view_BG     = UIView()
        let view_LineH  = UIView()
        
        // Configure
        view_BG.backgroundColor = .white
        view_BG.layer.cornerRadius = 6
        
        view_LineH.backgroundColor = .gray
        
        label_A.numberOfLines = 0
        label_A.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
        label_A.textColor = .red
        label_B.numberOfLines = 0
        label_B.textColor = .blue
        label_B.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.2)
        
        label_A.text = "TestA"
//        label_B.text = "TestB"
//        label_A.text = "Experiment with Swift standard library types and learn high-level concepts using visualizations and practical examples. Learn how the Swift standard library uses protocols and generics to express powerful constraints. Download the playground below to get started."
        label_B.text = "Experiment with Swift standard library types and learn high-level concepts using visualizations and practical examples. Learn how the Swift standard library uses protocols and generics to express powerful constraints. Download the playground below to get started."
        
        // Assemble
        contentView.addSubview(view_BG)
        view_BG.addSubview(label_A)
        view_BG.addSubview(view_LineH)
        view_BG.addSubview(label_B)
        
        // Layout
        view_BG.constrain_edges(to: contentView)
        label_A.constrain_edges(to: view_BG, excludingEdge: .bottom)
        label_B.constrain_edges(to: view_BG, excludingEdge: .top)
        
        view_LineH.constrain_height(1)
        view_LineH.constrain_left(to: view_BG)
        view_LineH.constrain_right(to: view_BG)
        view_LineH.constrain_topToBottom(of: label_A)
        label_B.constrain_topToBottom(of: view_LineH)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes
    {
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        return layoutAttributes
    }
}

// A simple header that contains a centered label
class CollectionTestHeader: UICollectionReusableView {
    let label_title = UILabel()
    
    override init(frame: CGRect)            { super.init(frame: frame);     setup() }
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder);  setup() }
    func setup()
    {
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        label_title.text = "TestHeader"
        self.addSubview(label_title)
        label_title.constrain_center(in: self)
    }
}

