//
//  BrandsViewController.swift
//  DopaAppTask
//
//  Created by Mostafa Elbutch on 8/12/17.
//  Copyright © 2017 Mostafa Elbutch. All rights reserved.
//

import UIKit
import ObjectMapper
import SDWebImage

class BrandsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var brandsTableView: UITableView!
    
//    var brandsResponse : [BrandModel] = []
    var checkedBrands : [BrandModel] = []
    var uncheckedBrands : [BrandModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Helper methods
    func setupInitialView () {
        brandsTableView.register(BrandsTableViewCell.self, forCellReuseIdentifier: "BrandsCell")
        
        brandsTableView.delegate = self
        brandsTableView.dataSource = self
        
        callGetBrandsAPI()
        
        
    }
    
    func addBrandToCheckedItems(brandId: Int) {
        
        for model in uncheckedBrands{
            
            if model.brandId == brandId {
                
                if let index = uncheckedBrands.index(where: { $0.brandId == model.brandId })  {
                    uncheckedBrands.remove(at: index)
                }
                checkedBrands.append(model);
            }
        }
        
        brandsTableView.reloadData()
        
    }
    
    func addBrandToUnCheckedItems(brandId: Int) {
        
        for model in checkedBrands{
            
            if model.brandId == brandId {
                
                if let index = checkedBrands.index(where: { $0.brandId == model.brandId })  {
                    checkedBrands.remove(at: index)
                }
                uncheckedBrands.append(model);
            }
        }
        
        brandsTableView.reloadData()
    }
    
    // MARK: - API Calls
    func callGetBrandsAPI(){
        let networkManager = NetworkManager()
        networkManager.fetchBrands(nil, completionHandler: { (response, error) in
            
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: response as [String:Any]!)
                if let json = String(data: jsonData, encoding: .utf8) {
                    print(json)
                    
                    let apiResponse = Mapper<GetBrandsResponseModel>().map(JSONString: json)
                    self.uncheckedBrands = (apiResponse?.brands)!
                    
                    self.brandsTableView.reloadData()
                    
                }
            } catch {
                print("something went wrong with parsing json")
            }
            
        })
    }
    
    
    // MARK: - UITableView delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return checkedBrands.count
        } else {
            return uncheckedBrands.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = BrandsTableViewCell.cellForTableView(tableView: tableView, atIndexPath: indexPath as NSIndexPath)
        var brandName = ""
        var brandImageUrl = ""
        
        if indexPath.section == 0 {
            brandName = self.checkedBrands[indexPath.row].brandName!
            brandImageUrl = self.checkedBrands[indexPath.row].brandLogo!
            cell.accessoryType = .checkmark
        } else {
            brandName = self.uncheckedBrands[indexPath.row].brandName!
            brandImageUrl = self.uncheckedBrands[indexPath.row].brandLogo!
            cell.accessoryType = .none
        }
        
        cell.brandNameLabel.text = brandName
        cell.brandImageView.sd_setImage(with: NSURL(string: brandImageUrl) as URL?)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            addBrandToUnCheckedItems(brandId: checkedBrands[indexPath.row].brandId!)
        } else {
            addBrandToCheckedItems(brandId: uncheckedBrands[indexPath.row].brandId!)
        }
    }
}
