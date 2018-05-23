//
//  DetailsViewController.swift
//  GameSource
//
//  Created by Langtian Qin on 4/17/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit
import Firebase

class DetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var curr:GSGame!
    let imagesRef=Storage.storage().reference()

    @IBOutlet weak var myTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return curr.pagedist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row==0{
            let newcell=tableView.dequeueReusableCell(withIdentifier: "GameDetailsCell", for: indexPath) as! GameDetailsTableViewCell
            let imageRef=imagesRef.child(curr.picRefString)
            imageRef.getData(maxSize: 10*1024*1024, completion: {
                data,error in
                if let error=error{
                    print(error.localizedDescription)
                }else {
                    newcell.posterImageView.image=UIImage(data:data!)
                }
            })
            newcell.titleLabel.text=curr.gamename
            newcell.descLabel.text=curr.gameintro
            let image2Ref=imagesRef.child(curr.bannerRefString)
            imageRef.getData(maxSize: 10*1024*1024, completion: {
                data,error in
                if let error=error{
                    print(error.localizedDescription)
                }else {
                    newcell.mainDevImageView.image=UIImage(data:data!)
                }
            })
            newcell.mainDevLabel.text=curr.developer
            return newcell
        }
        else{
            if(curr.pagedist[indexPath.row]==1){
            let newcell=tableView.dequeueReusableCell(withIdentifier: "SingleLabelCell", for: indexPath) as! SingleLabelTableViewCell
            newcell.singleLabel.text=curr.textdist[0]
                curr.textdist.remove(at: 0)
            return newcell
            }
            else{
                let newcell=tableView.dequeueReusableCell(withIdentifier: "DoubleLabelCell", for: indexPath) as! DoubleLabelTableViewCell
                newcell.firstLabel.text=curr.textdist[0]
                curr.textdist.remove(at: 0)
                newcell.secondLabel.text=curr.textdist[0]
                curr.textdist.remove(at: 0)
                return newcell
            }
        }
    }
    
    @IBAction func didTapProfile(_ sender: Any) {
        performSegue(withIdentifier: "profileSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let desti=segue.destination as! ProfileViewController
        desti.curr=curr.developer
        desti.editable=false
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
