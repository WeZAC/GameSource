//
//  NotificationsViewController.swift
//  GameSource
//
//  Created by Langtian Qin on 4/17/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mainTableView: UITableView!
    var isSearching=false
    var matching=[GSGame]()
    var seguing:GSGame!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate=self
        mainTableView.dataSource=self
        searchBar.delegate=self
        searchBar.returnKeyType=UIReturnKeyType.done
        
        // Do any additional setup after loading the view.
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text==nil || searchBar.text=="" {
            isSearching=false
            view.endEditing(true)
            mainTableView.reloadData()
        }else{
            isSearching=true
            self.filterSearch(text: searchBar.text!)
        }
    }
    
    func filterSearch(text:String){
        Database.database().reference().child("games").queryOrdered(byChild: "gamename").queryStarting(atValue: text).queryEnding(atValue: text+"\u{f8ff}").observe(.value, with: {snapshot in
            var mgames=[GSGame]()
            for i in snapshot.children{
                mgames.append(GSGame(snapshot: i as! DataSnapshot)!)
            }
            self.matching=mgames
            self.mainTableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newcell=mainTableView.dequeueReusableCell(withIdentifier: "SearchCell") as! SearchTableViewCell
        let thisgame=matching[indexPath.row]

        if(!(thisgame.picRefString=="")){
            let imageRef=Storage.storage().reference().child(thisgame.picRefString)
            imageRef.getData(maxSize: 10*1024*1024, completion: {
                data,error in
                if let error=error{
                    print(error.localizedDescription)
                }else {
                    newcell.mainImageView.image=UIImage(data:data!)
                }
            })
        }else{
            newcell.mainImageView.image=#imageLiteral(resourceName: "icons8-game-controller-50")
        }
        newcell.nameLabel.text=thisgame.gamename
        newcell.descLabel.text=thisgame.gameintro
        return newcell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        seguing=matching[indexPath.row]
        performSegue(withIdentifier: "searchSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let desti=segue.destination as! DetailsViewController
        desti.curr=seguing
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isSearching){
            return matching.count
        }else{
            return 0
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
