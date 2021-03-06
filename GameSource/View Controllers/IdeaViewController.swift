//
//  IdeaViewController.swift
//  GameSource
//
//  Created by Langtian Qin on 4/17/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit
import Firebase
import TagListView

class IdeaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCells.count
    }
    
    @IBAction func didAddTag(_ sender: Any) {
        let alert=UIAlertController(title: "Add Tag", message: "Please enter a tag for your game. Only default tags would be considered in pushing out to users.", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {(textField) in
            textField.text=""
        })
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField?.text)")
            let taggedCell=self.mainTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! GameEditingTableViewCell
            taggedCell.tagListView.addTag((textField?.text)!)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row==0){
            let newcell=mainTableView.dequeueReusableCell(withIdentifier: "GameEditingCell") as! GameEditingTableViewCell
            newcell.posterImageView.isUserInteractionEnabled=true
            var tapG=UITapGestureRecognizer(target: self, action: #selector(IdeaViewController.didTap(_:)))
            newcell.posterImageView.addGestureRecognizer(tapG)
            let userRef=Database.database().reference(withPath: "users").child((Auth.auth().currentUser?.uid)!)
            userRef.observeSingleEvent(of: .value, with: {snapshot in
                var user:GSUser
                user=GSUser(snapshot: snapshot)!
                newcell.mainDevLabel.text="by "+((user.username=="") ? user.uid : user.username)
            })
            return newcell
        }
        else if(currentCells[indexPath.row]==1){
            print("got inside")
            let newcell=mainTableView.dequeueReusableCell(withIdentifier: "SingleLabelEditCell") as! SingleLabelEditTableViewCell
            newcell.textView.text="Write something here..."
            newcell.textView.textColor=UIColor.lightGray
            newcell.textView.delegate=self
            return newcell
        }
        else{
            let newcell=mainTableView.dequeueReusableCell(withIdentifier: "DoubleLabelEditCell") as! DoubleLabelEditTableViewCell
            newcell.textField.placeholder="Section title"
            newcell.textView.text="Write something here..."
            newcell.textView.textColor=UIColor.lightGray
            newcell.textView.delegate=self
            return newcell
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.textColor==UIColor.lightGray){
            textView.text=nil
            textView.textColor=UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text="Did you mean to put something?"
            textView.textColor=UIColor.lightGray
        }
    }
    
    @IBOutlet weak var mainTableView: UITableView!
    

    @IBOutlet weak var tagListView: TagListView!
    var gameDic=[String:Any]()
    var currentCells=[0]
    let vc = UIImagePickerController()
    var originalImage:UIImage? = nil
    var editedImage:UIImage? = nil
    let imageStorageRef=Storage.storage().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        self.mainTableView.isEditing=false
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
        print("?")
    }
    
    @IBOutlet weak var editButton: UIButton!
    @IBAction func editAction(_ sender: Any) {
        if(self.mainTableView.isEditing){
            editButton.setTitle("Edit", for: UIControlState.normal)
            self.mainTableView.isEditing=false
        }
        else{
            editButton.setTitle("Stop", for: UIControlState.normal)
            self.mainTableView.isEditing=true
        }
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row==0 ? false : true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return indexPath.row==0 ? .none : .delete
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item=currentCells[sourceIndexPath.row]
        currentCells.remove(at: sourceIndexPath.row)
        currentCells.insert(item,at:destinationIndexPath.row)
    }
    
    
    @IBAction func confirmAction(_ sender: Any) {
        let uuid=UUID().uuidString
        gameDic["gameid"]=uuid
        let devid=Auth.auth().currentUser?.uid
        gameDic["developers"]=devid
        let mainCell=mainTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! GameEditingTableViewCell
        gameDic["gamename"]=mainCell.titleField.text
        gameDic["gameintro"]=mainCell.descView.text
        if let im=editedImage{
        let picid=UUID().uuidString
        let imageRef=Storage.storage().reference().child(picid)
        let imageData=UIImagePNGRepresentation(editedImage!)
        imageRef.putData(imageData!)
        gameDic["picRefString"]=picid
        }else {gameDic["picRefString"]=""}
        gameDic["karma"]=0
        gameDic["rating"]=0
        let gameRef=Database.database().reference().child("games").child(uuid)
        for i in stride(from: 0, to: currentCells.count, by: 1) {
            switch currentCells[i]{
            case 0: continue
            case 1:
                let Path1=String(i)+"-"+String(1)
                gameDic[Path1]=(mainTableView.cellForRow(at: IndexPath(row: i, section: 0))as!SingleLabelEditTableViewCell).textView.text
            case 2:
                let Path1=String(i)+"-"+String(1)
                let Path2=String(i)+"-"+String(2)
                gameDic[Path1]=(mainTableView.cellForRow(at: IndexPath(row: i, section: 0))as! DoubleLabelEditTableViewCell).textField.text
                gameDic[Path2]=(mainTableView.cellForRow(at: IndexPath(row: i, section: 0))as! DoubleLabelEditTableViewCell).textView.text
            default: continue
            }
        }
        gameDic["pagedist"]=currentCells
        var tagdist = [String]()
        for i in (mainTableView.cellForRow(at: IndexPath(row: 0, section: 0))as!GameEditingTableViewCell).tagListView.tagViews{
            tagdist.append(i.currentTitle!)
        }
        gameDic["tagdist"]=tagdist
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
