//
//  ProfileViewController.swift
//  GameSource
//
//  Created by Ruben A Gonzalez on 4/16/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var realnameTextView: UITextView!
    @IBOutlet weak var descTextView: UITextView!
    

    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var mainTableView: UITableView!
    var curr:String?
    var currUser:GSUser?
    var editable=true
    var currentCells=[String]()
    let vc = UIImagePickerController()
    var originalImage:UIImage? = nil
    var editedImage:UIImage? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        if(editable){
            curr=Auth.auth().currentUser?.uid
            vc.delegate = self
            vc.allowsEditing = true
            vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
            addButton.isHidden=false
            confirmButton.isHidden=false
        }
        else{
            addButton.isHidden=true
            confirmButton.isHidden=true
        }
        let userRef=Database.database().reference(withPath: "users").child(curr!)
        userRef.observeSingleEvent(of: .value, with: {snapshot in
            var user:GSUser
            user=GSUser(snapshot: snapshot)!
            self.currUser=user
        })
        if(currUser?.picRefString==""){
            self.mainImageView.image=#imageLiteral(resourceName: "8bitsword.png")
        }
        else{
        let imageRef=Storage.storage().reference().child(curr!)
        imageRef.getData(maxSize: 10*1024*1024, completion: {data,error in
            if let error=error{
                print(error.localizedDescription)
            }
            else{
                self.mainImageView.image=UIImage(data:data!)
            }
        })
        }
        descTextView.text=currUser?.desc
        realnameTextView.text=currUser?.realname
        nameTextView.text=currUser?.username
        
        mainTableView.delegate=self
        mainTableView.dataSource=self
        mainTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func didTap(_ sender: Any) {
         self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        
        // Do something with the images (based on your use case)
        mainImageView.image=editedImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didAdd(_ sender: Any) {
        currentCells.append("")
        currentCells.append("")
        mainTableView.reloadData()
    }
    
    @IBAction func didBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCells.count/2
    }
    @IBAction func didConfirm(_ sender: Any) {
        var newProfile=[String:Any]()
        newProfile["uid"]=curr
        newProfile["username"]=nameTextView.text
        newProfile["realname"]=realnameTextView.text
        newProfile["desc"]=descTextView.text
        for i in stride(from: 0, to: currentCells.count, by: 2){
            currentCells[i]=(mainTableView.cellForRow(at: IndexPath(row: i, section: 0))as! DoubleLabelEditTableViewCell).textField.text!
            currentCells[i+1]=(mainTableView.cellForRow(at: IndexPath(row: i, section: 0))as! DoubleLabelEditTableViewCell).textLabel!.text!
        }
        newProfile["textdist"]=currentCells
        let picid=UUID().uuidString
        let imageRef=Storage.storage().reference().child(picid)
        let imageData=UIImagePNGRepresentation(editedImage!)
        imageRef.putData(imageData!)
        newProfile["picRefString"]=picid
        Database.database().reference(withPath: "users").child(curr!).setValue(newProfile)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newcell=mainTableView.dequeueReusableCell(withIdentifier: "DoubleLabelEditCell") as! DoubleLabelEditTableViewCell
        newcell.textField.text=currentCells[2*indexPath.row]
        newcell.textView.text=currentCells[2*indexPath.row+1]
        if(!editable){
            newcell.textView.isEditable=false
            newcell.textField.isUserInteractionEnabled=false
        }
        return newcell
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
