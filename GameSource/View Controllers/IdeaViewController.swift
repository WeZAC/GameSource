//
//  IdeaViewController.swift
//  GameSource
//
//  Created by Langtian Qin on 4/17/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit
import Firebase

class IdeaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row==0){
            let newcell=mainTableView.dequeueReusableCell(withIdentifier: "GameEditingCell") as! GameEditingTableViewCell
            return newcell
        }
        else if(currentCells[indexPath.row]==1){
            let newcell=mainTableView.dequeueReusableCell(withIdentifier: "DoubleLabelEditCell") as! DoubleLabelEditTableViewCell
            return newcell
        }
        else{
            let newcell=mainTableView.dequeueReusableCell(withIdentifier: "SingleLabelCell") as! SingleLabelEditTableViewCell
            return newcell
        }
    }
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var gameDic=[String:Any]()
    var currentCells=[0]
    let vc = UIImagePickerController()
    var originalImage:UIImage? = nil
    var editedImage:UIImage? = nil
    let imageStorageRef=Storage.storage().reference().child("images")
    override func viewDidLoad() {
        super.viewDidLoad()

        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        mainTableView.delegate=self
        mainTableView.dataSource=self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func didTap(_ sender: Any) {
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func confirmAction(_ sender: Any) {
        let uuid=UUID().uuidString
        gameDic["gameid"]=uuid
        let devid=Auth.auth().currentUser?.uid
        gameDic["developers"]=devid
        let mainCell=mainTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! GameEditingTableViewCell
        gameDic["gamename"]=mainCell.titleField.text
        gameDic["gameintro"]=mainCell.descView.text
        let picid=UUID().uuidString
        let imageRef=Storage.storage().reference().child(picid)
        let imageData=UIImagePNGRepresentation(editedImage!)
        imageRef.putData(imageData!)
        gameDic["picRefString"]=picid
        gameDic["karma"]=0
        gameDic["rating"]=0
        let gameRef=Database.database().reference().child("games").child(uuid)
        for i in stride(from: 0, to: currentCells.count, by: 1) {
            switch currentCells[i]{
            case 0: continue
            case 1:
                let Path1=String(i)+String(1)
                gameDic[Path1]=(mainTableView.cellForRow(at: IndexPath(row: i, section: 0))as!SingleLabelEditTableViewCell).textView
            case 2:
                let Path1=String(i)+String(1)
                let Path2=String(i)+String(2)
                gameDic[Path1]=(mainTableView.cellForRow(at: IndexPath(row: i, section: 0))as! DoubleLabelEditTableViewCell).textField
                gameDic[Path2]=(mainTableView.cellForRow(at: IndexPath(row: i, section: 0))as! DoubleLabelEditTableViewCell).textView
            default: continue
            }
        }
        gameRef.setValue(gameDic)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func didBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addCellAction(_ sender: Any) {
        currentCells.append(2)
        mainTableView.reloadData()
    }
    @IBAction func addLineAction(_ sender: Any) {
        currentCells.append(1)
        mainTableView.reloadData()
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        
        // Do something with the images (based on your use case)
        (mainTableView.cellForRow(at: IndexPath(row: 0, section: 0))as! GameEditingTableViewCell).posterImageView.image=editedImage
        // Dismiss UIImagePickerController to go back to your original view controller
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
