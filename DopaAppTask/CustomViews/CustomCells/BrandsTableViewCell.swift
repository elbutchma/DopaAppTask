//
//  BrandsTableViewCell.swift
//  DopaAppTask
//
//  Created by Mostafa Elbutch on 8/12/17.
//  Copyright © 2017 Mostafa Elbutch. All rights reserved.
//

import UIKit

class BrandsTableViewCell: UITableViewCell {

    @IBOutlet weak var brandImageView: UIImageView!
    @IBOutlet weak var brandNameLabel: UILabel!
    
    func configureCell (){
        
    }
    
    class func cellForTableView(tableView: UITableView, atIndexPath indexPath: NSIndexPath) -> BrandsTableViewCell {
        
        let kBrandsCellIdentifier = "BrandsCell"
        
        tableView.register(UINib(nibName: "BrandsTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: kBrandsCellIdentifier)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kBrandsCellIdentifier, for: indexPath as IndexPath) as! BrandsTableViewCell
        
        
        cell.selectionStyle = .none
        
        
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
