//
//  ViewController.swift
//  ECE564_HOMEWORK
//
//  Created by Ric Telford on 7/16/17.
//  Copyright © 2018 ece564. All rights reserved.
//

import UIKit
import MobileCoreServices

let DARK_GREEN = UIColor(displayP3Red: 249/255, green: 246/255, blue: 67/255, alpha: 0.5)
let APPLE_GREEN = UIColor(displayP3Red: 109/255, green: 210/255, blue: 149/255, alpha: 1)
let OP_GREEN = UIColor(displayP3Red: 109/255, green: 210/255, blue: 149/255, alpha: 0)
let LIGHT_GRAY = UIColor(displayP3Red: 89/255, green: 156/255, blue: 120/255, alpha: 0.7)

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    

    @IBOutlet weak var jobSeg: UISegmentedControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var isNewPerson: Bool = true
    var newPerson: DukePerson = DukePerson("", "")
    var save: SaveBtn = .Edit
    var isClose: Bool = false
    //var imgId: Int = 0
    var imgId: String = ""
    var imgJS: String = ""
    
    let gender = ["Female", "Male"]
    let degSet: Set<String> = ["" ,"MS", "BS", "MENG", "PhD", "NA", "Other"]
    let roleSet: Set<String> = ["", "Student", "TA", "Professor"]
    //var map: [String : DukePerson] = [:]
    
    
    //These functions are used for pickerView to display gender
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        hideLabel.text = gender[row]
    }
    
    /* pickerView reference: https://stackoverflow.com/questions/44223862/how-do-i-change-the-font-size-in-a-uipickerview-in-swift-3/44223906
     */
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Chalkduster", size: 17)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = gender[row]
        pickerLabel?.textColor = UIColor.white
        
        return pickerLabel!
    }
    
    var mainView: UIView!
    var firstBox: TextBlock!
    var secondBox: TextBlock!
    var thirdBox: UIView!
    var forthBox: TextBlock!
    var fromBox: TextBlock!
    var degBox: TextBlock!
    var hobBox: TextBlock!
    var langBox: TextBlock!
    var teamBox: TextBlock!
    var thirdLabel: UILabel!
    var thirdText: UIPickerView!
    var hideLabel: UILabel!
    var addButton: UIButton!
    var findButton: UIButton!
    var takePicButton: UIButton!
    var desView: UITextView!
    var myImage: UIImageView!
    var jobLabel: UILabel!
    
    
    //The TextBlock class is used to display each line of the information view. Every TextBlock
    //Contains a UITextField and a UILabel.
    //主要为了是方便对齐所有的信息栏
    class TextBlock: UIView{

        var myText: UITextField!
        var myLabel: UILabel!
        override init (frame : CGRect) {
            super.init(frame : frame)
            
            myText = UITextField(frame: CGRect(x:80, y: 0, width:180, height: 20))
            myText.backgroundColor = APPLE_GREEN
            myText.placeholder = "First Name"
            //myText.font = myText.font?.withSize(15)
            myText.font = UIFont(name: "Chalkduster", size: 15)
            myText.setBottomBorder(backGroundColor: APPLE_GREEN, borderColor: .white)
            myText.textColor = UIColor.white
            myText.clearButtonMode = .whileEditing
            self.addSubview(myText)
            
            myLabel = UILabel(frame: CGRect(x:0, y: 0, width:80, height: 20))
            myLabel.isHidden = false
            myLabel.backgroundColor = APPLE_GREEN
            myLabel.textColor = UIColor.white
            myLabel.setBottomBorder(backGroundColor: APPLE_GREEN, borderColor: .white)
            myLabel.font = UIFont(name: "Chalkduster", size: 17)
            myLabel.text = "First:"
            self.addSubview(myLabel)
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
    }
    
    // create views manually
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var preferredStatusbarStyle: UIStatusBarStyle {
            return .lightContent
        }
        
        mainView = self.view
        mainView.backgroundColor = APPLE_GREEN
        hideLabel = UILabel(frame: CGRect(x:0, y: 0, width:5, height: 5))
        hideLabel.isHidden = true
        hideLabel.text = "Female"
        
        firstBox = TextBlock(frame: CGRect(x: 30, y: 80, width: 320, height: 30))
        secondBox = TextBlock(frame: CGRect(x: 30, y: 110, width: 320, height: 30))
        thirdBox = UIView(frame: CGRect(x: 30, y: 140, width: 320, height: 100))
        forthBox = TextBlock(frame: CGRect(x: 30, y: 210, width: 320, height: 30))
        fromBox = TextBlock(frame: CGRect(x: 30, y: 240, width: 320, height: 30))
        degBox = TextBlock(frame: CGRect(x: 30, y: 270, width: 320, height: 30))
        hobBox = TextBlock(frame: CGRect(x: 30, y: 300, width: 320, height: 30))
        langBox = TextBlock(frame: CGRect(x: 30, y: 330, width: 320, height: 30))
        teamBox = TextBlock(frame: CGRect(x: 30, y: 360, width: 320, height: 30))
        
        mainView.addSubview(firstBox)
        mainView.addSubview(secondBox)
        mainView.addSubview(thirdBox)
        mainView.addSubview(forthBox)
        mainView.addSubview(fromBox)
        mainView.addSubview(degBox)
        mainView.addSubview(hobBox)
        mainView.addSubview(langBox)
        mainView.addSubview(teamBox)
        
        firstBox.myText.delegate = self
        secondBox.myText.delegate = self
        forthBox.myText.delegate = self
        fromBox.myText.delegate = self
        degBox.myText.delegate = self
        hobBox.myText.delegate = self
        langBox.myText.delegate = self
        teamBox.myText.delegate = self

        firstBox.myText.placeholder = "First Name"
        firstBox.myLabel.text = "First:"
        secondBox.myText.placeholder = "Last Name"
        secondBox.myLabel.text = "Last:"
        forthBox.myText.placeholder = "Student, TA or Professor"
        forthBox.myLabel.text = "Role:"
        fromBox.myText.placeholder = "Any string of location info"
        fromBox.myLabel.text = "From:"
        degBox.myText.placeholder = "MS,BS,MENG,PhD,NA,Other"
        degBox.myLabel.text = "Degree:"
        hobBox.myText.placeholder = "Up to 3 hobbies"
        hobBox.myLabel.text = "Hobbies:"
        langBox.myText.placeholder = "Up to 3 prog languages"
        langBox.myLabel.text = "Langs:"
        teamBox.myLabel.text = "Team:"
        teamBox.myText.placeholder = "Only apply to students"
        
        //These are used to create the UIPickerView to display gender
        thirdText = UIPickerView(frame: CGRect(x:100, y: -15, width:100, height: 100))
        thirdText.delegate = self
        thirdLabel = UILabel(frame: CGRect(x:0, y: 18, width:240, height: 30))
        thirdLabel.isHidden = false
        thirdLabel.backgroundColor = APPLE_GREEN
        thirdLabel.text = "Gender:"
        thirdLabel.textColor = UIColor.white
        thirdLabel.setBottomBorder(backGroundColor: APPLE_GREEN, borderColor: UIColor.white)
        thirdLabel.font = UIFont(name: "Chalkduster", size: 17)
        thirdBox.addSubview(thirdLabel)
        thirdBox.addSubview(thirdText)
        
        //These are used to set a UISegmentControl for users to chose if they have
        //job experience
        jobLabel = UILabel(frame: CGRect(x:30, y: 410, width:200, height: 30))
        jobLabel.text = "Work Experience?"
        jobLabel.textColor = UIColor.white
        jobLabel.font = UIFont(name: "Chalkduster", size: 17)
        jobSeg.setTitle("Yes", forSegmentAt: 0)
        jobSeg.setTitle("No", forSegmentAt: 1)
        jobSeg.tintColor = LIGHT_GRAY
        jobSeg.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: UIControlState.selected)
        
        //These are used in hw2 and they are abandoned now.
        //不用管这些，这俩button已经用不着了
        addButton = UIButton(frame: CGRect(x: 30, y: 410, width: 110, height: 30))
        findButton = UIButton(frame: CGRect(x: 200, y: 410, width: 70, height: 30))
        addButton.backgroundColor = LIGHT_GRAY
        findButton.backgroundColor = LIGHT_GRAY
        addButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 15)
        findButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 15)
        addButton.setTitle("Add/Update", for: .normal) 
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.setTitleColor(UIColor.gray, for: .selected)
        addButton.setTitleColor(UIColor.red, for: .highlighted)
        findButton.setTitle("Find", for: .normal)
        findButton.setTitleColor(UIColor.white, for: .normal)
        findButton.setTitleColor(UIColor.gray, for: .selected)
        findButton.setTitleColor(UIColor.red, for: .highlighted)
        
        addButton.addTarget(self, action: #selector(ViewController.pressedAdd(_:)), for: .touchUpInside)
        findButton.addTarget(self, action: #selector(ViewController.pressedFind(_:)), for: .touchUpInside)
        
        //These set a take picture button.
        takePicButton = UIButton(frame: CGRect(x: 30, y: 490, width: 110, height: 30))
        takePicButton.backgroundColor = LIGHT_GRAY
        takePicButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 15)
        takePicButton.setTitle("Take Pic", for: .normal)
        takePicButton.setTitleColor(UIColor.white, for: .normal)
        takePicButton.setTitleColor(UIColor.gray, for: .selected)
        takePicButton.setTitleColor(UIColor.red, for: .highlighted)
        takePicButton.addTarget(self, action: #selector(ViewController.takePic(_:)), for: .touchUpInside)
        
        //desView was used in hw2, and now is abandoned
        //不用desView了现在
        desView = UITextView(frame: CGRect(x: 30, y: 510, width: 150, height: 170))
        desView.backgroundColor = LIGHT_GRAY
        desView.layer.cornerRadius = 20
        desView.font = UIFont(name: "Chalkduster", size: 10)
        desView.textColor = UIColor.white
        desView.isUserInteractionEnabled = false
        
        //myImage is Used to display images
        myImage = UIImageView(frame: CGRect(x: 170, y: 450, width: 110, height: 110))
        myImage.backgroundColor = LIGHT_GRAY
        myImage.layer.cornerRadius = (myImage.frame.size.width) / 2
        myImage.clipsToBounds = true
        myImage.isHidden = false
        myImage.image = UIImage(named: "")
        
        //mainView.addSubview(addButton)
        //mainView.addSubview(findButton)
        //mainView.addSubview(desView)
        mainView.addSubview(takePicButton)
        mainView.addSubview(myImage)
        mainView.addSubview(jobLabel)
        
        setDefaultInfo()
        setTextState(state: false)
       // addDefaultPerson()
        
        if(save == .Save) {
           // print("save")
            setEditMode()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //this function is used to take pictures
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        let im = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismiss(animated: true) {
            let type = info[UIImagePickerControllerMediaType] as? String
            if type != nil {
                switch type! {
                case kUTTypeImage as NSString as String:
                    if im != nil {
                        self.myImage.image = im
                        self.myImage.contentMode = .scaleAspectFit
                        self.saveImage(image: self.myImage.image!)
                    }
                default:break
                }
            }
        }
    }
    
    //this function is used to take pictures
    @objc func takePic(_ sender: AnyObject) {
        let cam = UIImagePickerControllerSourceType.camera
        let ok = UIImagePickerController.isSourceTypeAvailable(cam)
        if (!ok) {
            print("no camera")
            return
        }
        let desiredType = kUTTypeImage as NSString as String
        let arr = UIImagePickerController.availableMediaTypes(for: cam)
        print(arr!)
        if arr?.index(of: desiredType) == nil {
            print("no capture")
            return
        }
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.cameraDevice = .front
        picker.mediaTypes = [desiredType]
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
        
    }
    
    //This function saves images to userDefaults
    func saveImage(image: UIImage){
        let imageData = UIImagePNGRepresentation(image)! as NSData
        self.imgJS = UIImageJPEGRepresentation(image, 1)?.base64EncodedString() ?? ""
        self.imgId = DukePerson.personId
        UserDefaults.standard.set(imageData, forKey: self.imgId)
    }
    
    
    //This function set default information of the user in Edit mode.
    //If the user's firstname and lastname are both null it will show a
    //blank info page. Otherwise, it will display the user's info.
    func setDefaultInfo() {
        if(newPerson.firstName != "" && newPerson.lastName != "") {
            firstBox.myText.text = newPerson.firstName
            secondBox.myText.text = newPerson.lastName
            forthBox.myText.text = newPerson.role.rawValue
            fromBox.myText.text = newPerson.whereFrom
            degBox.myText.text = newPerson.degree
            teamBox.myText.text = newPerson.team
            if(newPerson.gender == .Male) {
                thirdText.selectRow(1, inComponent: 0, animated: true)
            } else {
                thirdText.selectRow(0, inComponent: 0, animated: true)
            }
            for i in 0 ..< newPerson.hobbies.count {
                hobBox.myText.text?.append(newPerson.hobbies[i])
                if(i < newPerson.hobbies.count - 1) {
                    hobBox.myText.text?.append(",")
                }
            }
            for i in 0 ..< newPerson.bestProgrammingLanguages.count {
                langBox.myText.text?.append(newPerson.bestProgrammingLanguages[i])
                if(i < newPerson.bestProgrammingLanguages.count - 1) {
                    langBox.myText.text?.append(",")
                }
            }
            if(newPerson.hasJob) {
                jobSeg.selectedSegmentIndex = 0
            } else {
                jobSeg.selectedSegmentIndex = 1
            }
        }
    }
    
    //This function check the user input format
    func check() -> Bool {
        let role: String = forthBox.myText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let deg: String = degBox.myText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let hobtok =  hobBox.myText.text!.components(separatedBy:",").count - 1
        let langtok =  langBox.myText.text!.components(separatedBy:",").count - 1
        if(firstBox.myText.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" || secondBox.myText.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            let alert = UIAlertController(title: "Please Give Fullname", message: "You didn't entern the fullname.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return false
        } else if(!roleSet.contains(role) || !degSet.contains(deg) || hobtok > 2 || langtok > 2) {
            let alert = UIAlertController(title: "Please Check Information Format", message: "Please fix the input information format.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return false
        }
        return true
    }
    
    //abandoned
    @objc func pressedAdd(_ sender: UIButton!) {
        if !check() {
            return
        }
        let fullName: String = firstBox.myText.text!.trimmingCharacters(in: .whitespacesAndNewlines) + " " + secondBox.myText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        var person: DukePerson
        if(map[fullName] != nil) {
            person = map[fullName]!
        } else {
            person = DukePerson(firstBox.myText.text!,secondBox.myText.text!);
            personArray.append(person)
        }
        let role: String = forthBox.myText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        person.gender = hideLabel.text! == "Male" ? Gender.Male : Gender.Female
        if(role != ""){person.role = role == "Student" ? DukeRole.Student : (role == "TA" ? DukeRole.TA : DukeRole.Professor)}
        let from = fromBox.myText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if(from != "") {person.whereFrom = from}
        let deg = degBox.myText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if(deg != "") {person.degree = deg}
        let team = teamBox.myText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if(team != "") {person.team = team}
        if(hobBox.myText.text! != "") {
            let hobtok =  hobBox.myText.text!.components(separatedBy:",")
            person.hobbies.removeAll()
            person.hobbies.append(contentsOf: hobtok)
        }
        if(langBox.myText.text! != "") {
            let langtok =  langBox.myText.text!.components(separatedBy:",")
            person.bestProgrammingLanguages.removeAll()
            person.bestProgrammingLanguages.append(contentsOf: langtok)
        }
        map[fullName] = person
    }
    
    //abandoned
    @objc func pressedFind(_ sender: UIButton!) {
        let res: String = firstBox.myText.text!.trimmingCharacters(in: .whitespacesAndNewlines) + " " + secondBox.myText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let tupleRes: (String, String) = whoIs(res)
        desView.text = tupleRes.0
        myImage.image = UIImage(named: tupleRes.1)
    }
    
    //abandoned
    func whoIs(_ name: String) -> (String, String) {
        if(name.count == 0) {
            print("no such person")
            return ("","")
        }
        var fullName = name.components(separatedBy: " ")
        if(fullName.count != 2) {
            print("no such person")
            return ("","")
        }
        let firstName: String = fullName[0]
        let lastName: String = fullName[1]
        var personInfo: String = ""
        var findPerson: Bool = false
        var img: String = ""
        for person in personArray {
            if(person.firstName == firstName && person.lastName == lastName) {
                personInfo = person.description
                findPerson = true
                img = person.img
            }
        }
        if !findPerson {
            print("no such person")
            return ("","")
        }
        return (personInfo, img)
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    //This function disable text editing in before user hit the Edit button
    //In add mode, it will enable the editing by default.
    func setTextState(state: Bool) {
        firstBox.myText.isEnabled = state
        secondBox.myText.isEnabled = state
        thirdBox.isUserInteractionEnabled = state
        forthBox.myText.isEnabled = state
        fromBox.myText.isEnabled = state
        degBox.myText.isEnabled = state
        hobBox.myText.isEnabled = state
        langBox.myText.isEnabled = state
        teamBox.myText.isEnabled = state
        takePicButton.isEnabled = state
        jobSeg.isEnabled = state
    }
    
    //This function set the save button
    func setEditMode() {
        saveButton.title = "Save"
        save = .Save
        setTextState(state: true)
    }
    
    //This function is used in unwind segue to ensure saving info in the right time
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if( navigationItem.rightBarButtonItem == (sender as? UIBarButtonItem)) {
            if(save == .Save) {
                if(!check()) {
                    return false
                }
                return true
            }
            setEditMode()
            return false
        }
        return true
    }
    
    //This function is used in unwind segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(navigationItem.leftBarButtonItem == (sender as? UIBarButtonItem)) {
            isClose = true
        }
        if ((sender as? UIBarButtonItem) != self.saveButton) { return
        }
        if !check() {
            return
        }
        if(isNewPerson) {
            self.newPerson = DukePerson(firstBox.myText.text!,secondBox.myText.text!);
            personArray.append(self.newPerson)
        }
        let role: String = forthBox.myText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        self.newPerson.gender = hideLabel.text! == "Male" ? Gender.Male : Gender.Female
        if(role != ""){self.newPerson.role = role == "Student" ? DukeRole.Student : (role == "TA" ? DukeRole.TA : DukeRole.Professor)}
        let from = fromBox.myText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if(from != "") {self.newPerson.whereFrom = from}
        let deg = degBox.myText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if(deg != "") {self.newPerson.degree = deg}
        let team = teamBox.myText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if(team != "") {self.newPerson.team = team}
        if(hobBox.myText.text! != "") {
            let hobtok =  hobBox.myText.text!.components(separatedBy:",")
            self.newPerson.hobbies.removeAll()
            self.newPerson.hobbies.append(contentsOf: hobtok)
        }
        if(langBox.myText.text! != "") {
            let langtok =  langBox.myText.text!.components(separatedBy:",")
            self.newPerson.bestProgrammingLanguages.removeAll()
            self.newPerson.bestProgrammingLanguages.append(contentsOf: langtok)
        }
        self.newPerson.img = self.imgId
        self.newPerson.imgForJSON = self.imgJS
        if(jobSeg.selectedSegmentIndex == 0) {
            self.newPerson.hasJob = true
        } else {
            self.newPerson.hasJob = false
        }
    }

}

//This extension is used to display only the bottom line of the textField
extension UITextField {
    func setBottomBorder(backGroundColor: UIColor, borderColor: UIColor) {
        self.layer.backgroundColor = backGroundColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height:1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.layer.shadowColor = borderColor.cgColor
    }
}

//This extension is used to display only the bottom line of the textLabel
extension UILabel {
    func setBottomBorder(backGroundColor: UIColor, borderColor: UIColor) {
        self.layer.backgroundColor = backGroundColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height:1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.layer.shadowColor = borderColor.cgColor
    }
}

