//
//  SchoolCell.swift
//  20201220-Gifton-NYCSchools
//
//  Created by Gifton on 12/20/20.
//

import UIKit


class SchoolCell: UICollectionViewCell {
    
    
    private weak var viewmodel: SchoolCellViewModel?
    
    public func set(withModel viewmodel: SchoolCellViewModel) {
        self.viewmodel = viewmodel
        setView()
    }
    
    let title = UILabel()
    var totalStudents = UILabel()
    var neighborhood = UILabel()
    let forwardArrow = UIImageView(image: UIImage(systemName: "chevron.compact.right"))
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = ""
        title.sizeToFit()
        
        totalStudents.removeFromSuperview()
        totalStudents = UILabel()
        
        neighborhood.removeFromSuperview()
        neighborhood = UILabel()
    }
}


private extension SchoolCell {
    func setView() {
        
        contentView.backgroundColor = Colors.darkBlue.withAlphaComponent(0.5)
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
        
        guard let vm = viewmodel else { return }
        
        title.numberOfLines = 2
        
        title.text = vm.school.schoolName
        totalStudents.text = "\(vm.school.totalStudents) students"
        neighborhood.text = vm.school.neighborhood
        
        title.font = UIFont.preferredFont(forTextStyle: .headline)
        title.adjustsFontForContentSizeCategory = true
        title.left = contentView.left.addPadding()
        title.top = contentView.top.addPadding(.xLarge)
        title.textColor = UIColor.white
        title.width = contentView.width.subtractPadding(.large, multiplier: 2)
        contentView.addSubview(title)
        
        
        title.sizeToFit()
        totalStudents.sizeToFit()
        neighborhood.sizeToFit()
        
        forwardArrow.tintColor = Colors.primaryBlue
        forwardArrow.frame.size = .init(15)
        forwardArrow.right = contentView.right.subtractPadding()
        forwardArrow.centerY = contentView.height / 2
        contentView.addSubview(forwardArrow)
        
        totalStudents = PaddedLabel(content: vm.school.totalStudents + " Students", size: .init((contentView.width / 2).subtractPadding(.large, multiplier: 2) - 40, 45))
        totalStudents.right = contentView.right - 75
        totalStudents.bottom = contentView.bottom.subtractPadding()
        
        contentView.addSubview(totalStudents)
        
        neighborhood = PaddedLabel(content: vm.school.neighborhood, size: .init((contentView.width / 2).subtractPadding(.large, multiplier: 2), 45))
        neighborhood.left = contentView.left.addPadding()
        neighborhood.bottom = contentView.bottom.subtractPadding()
        contentView.addSubview(neighborhood)
        
    }
}
