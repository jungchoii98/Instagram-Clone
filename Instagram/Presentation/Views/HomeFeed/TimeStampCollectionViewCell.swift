//
//  TimeStampCollectionViewCell.swift
//  Instagram
//
//  Created by Jung Choi on 8/13/23.
//

import UIKit

class TimeStampCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "\(TimeStampCollectionViewCell.self)"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: TimeStampCellViewModel) {
        
    }
}
