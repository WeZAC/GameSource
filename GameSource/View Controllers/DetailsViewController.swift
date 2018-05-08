//
//  DetailsViewController.swift
//  GameSource
//
//  Created by Langtian Qin on 4/17/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var curr:GSGame!

    @IBOutlet weak var myTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row==0{
            let newcell=tableView.dequeueReusableCell(withIdentifier: "GameDetailsCell", for: indexPath) as! GameDetailsTableViewCell
            newcell.posterImageView.image=#imageLiteral(resourceName: "8bitsword.png")
            newcell.titleLabel.text="Sword"
            newcell.descLabel.text="Sword sword"
            newcell.mainDevImageView.image=#imageLiteral(resourceName: "8bitghost.png")
            newcell.mainDevLabel.text="ghost"
            return newcell
        }
        else if indexPath.row==1{
            let newcell=tableView.dequeueReusableCell(withIdentifier: "SingleLabelCell", for: indexPath) as! SingleLabelTableViewCell
            newcell.singleLabel.text="fun"
            return newcell
        }
        else{
            let newcell=tableView.dequeueReusableCell(withIdentifier: "DoubleLabelCell", for: indexPath) as! DoubleLabelTableViewCell
            newcell.firstLabel.text="Playthrough"
            newcell.secondLabel.text="Use a sword"
            return newcell
        }
    }
    
    @IBAction func didTapProfile(_ sender: Any) {
        performSegue(withIdentifier: "profileSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //pass the devid on
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate=self
        myTableView.dataSource=self
        myTableView.rowHeight=UITableViewAutomaticDimension
        myTableView.estimatedRowHeight=400
        myTableView.reloadData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapX(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
