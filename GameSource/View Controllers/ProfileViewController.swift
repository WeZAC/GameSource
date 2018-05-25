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
            if(self.currUser?.picRefString==""){
                self.mainImageView.image=#imageLiteral(resourceName: "download (6)")
            }
            else{
                let imageRef=Storage.storage().reference().child(self.curr!)
                imageRef.getData(maxSize: 10*1024*1024, completion: {data,error in
                    if let error=error{
                        print(error.localizedDescription)
                    }
                    else{
                        self.mainImageView.image=UIImage(data:data!)
                    }
                })
            }
            if(self.currUser?.desc==""&&self.editable){
                self.descTextView.text="Say something about yourself..."
                self.descTextView.textColor=UIColor.lightGray
            }else if(self.currUser?.desc==""){
                self.descTextView.text="This user hasn't made a profile description yet."
            }else{
                self.descTextView.text=self.currUser?.desc
            }
            if(self.currUser?.realname==""&&self.editable){
                self.realnameTextView.text="Your name in real life... or in game"
                self.realnameTextView.textColor=UIColor.lightGray
            }else if(self.currUser?.realname==""){
                self.realnameTextView.text="This user hasn't revealed this real name."
            }else{
                self.realnameTextView.text=self.currUser?.realname
            }
            if(self.currUser?.username==""&&self.editable){
                self.nameTextView.text="Choose a username for yourself! Can be changed anytime"
                self.nameTextView.textColor=UIColor.lightGray
            }else if(self.currUser?.username==""){
                self.nameTextView.text="User-"+(self.currUser?.uid)!
            }else{
                self.nameTextView.text=self.currUser?.username
            }
        })
        
        let tapG=UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        mainImageView.addGestureRecognizer(tapG)
        
        mainTableView.delegate=self
        mainTableView.dataSource=self
        mainTableView.reloadData()
        realnameTextView.delegate=self
        nameTextView.delegate=self
        descTextView.delegate=self
        // Do any additional setup after loading the view.
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
            currentCells[i+1]=(mainTableView.cellForRow(at: IndexPath(row: i, section: 0))as! DoubleLabelEditTableViewCell).textView!.text!
        }
        newProfile["textdist"]=currentCells
        if let im=editedImage{
            let picid=UUID().uuidString
            let imageRef=Storage.storage().reference().child(picid)
            let imageData=UIImagePNGRepresentation(editedImage!)
            imageRef.putData(imageData!)
            newProfile["picRefString"]=picid}
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
