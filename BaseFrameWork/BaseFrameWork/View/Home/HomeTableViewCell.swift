//
//  HomeTableViewCell.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/27.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var contentLb: UILabel!
    
    var viewModel: HomeCellModel?{
        didSet{
            titleLb.text = viewModel?.nameString
            contentLb.text = viewModel?.contentLbString
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        contentLb.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 2 * 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func rowHeight(vm: HomeCellModel) -> CGFloat {
        viewModel = vm
        contentView.layoutIfNeeded()
        var height = contentLb.frame.maxY + 20
        if viewModel?.contentLbString == "" {
            height = titleLb.frame.maxY + 20
        }
        return height
    }
    
    
    public static func createCell() -> HomeTableViewCell {
        let cell: HomeTableViewCell = Bundle.main.loadNibNamed(HomeTableViewCellID, owner: nil, options: nil)?.first as! HomeTableViewCell
        return cell
    }
}
