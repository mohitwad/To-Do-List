//
//  ToDoListCell.swift
//  ToDoList
//
//  Created by Mohit on 27/05/23.
//

import UIKit

class ToDoListCell: UITableViewCell {

    //MARK: - Outlet
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnComplete: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblPending: UILabel!
    
    //MARK: - Varibale
    var actionDelete: (()->Void)?
    var actionMarkComplete: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblPending.text = StringConstant.StaticText.pending
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.lblName.textColor = .textColor
        self.lblName.attributedText = nil
        self.lblPending.isHidden = true
    }
    
    func setData(model: ToDoListItem) {
        btnComplete.isSelected = model.markedStatus
        if model.markedStatus{
            self.lblName.attributedText = model.name?.strikeThrough()
        }else {
            self.lblName.attributedText = model.name?.removeStrikeThrough()
        }
        self.lblDate.text = model.endDate?.toString()
        if let date = model.endDate, date < Date(), !model.markedStatus {
            self.lblName.textColor = .redColor
            self.lblPending.isHidden = false
        }
    }
    
    @IBAction func actionTapDelete(_ sender: UIButton) {
        actionDelete?()
    }
    
    @IBAction func actionTapComplete(_ sender: UIButton) {
        actionMarkComplete?()
    }
    
}
