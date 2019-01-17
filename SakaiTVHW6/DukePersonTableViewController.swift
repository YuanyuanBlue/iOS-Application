//
//  DukePersonTableViewController.swift
//  ECE564_HOMEWORK
//
//  Created by yuyuanyuan on 9/16/18.
//  Copyright © 2018 ece564. All rights reserved.
//

import UIKit


//This class is used to diaplay everyone in ECE564
//test of tong
class DukePersonTableViewController: UITableViewController, UISearchBarDelegate {
    
    

    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet var myTableView: UITableView!
    
    
    @IBOutlet weak var getButton: UIBarButtonItem!
    @IBOutlet weak var postButton: UIBarButtonItem!
    
    
    var rowIdx: Int = 0
    var secIdx: Int = 0
    var currentTeam = [DukePerson]()
    var isSearch: Bool = false
    
    //this function initialize the items 2d array
    func initItems(){
        for _ in sections {
            items.append([])
        }
    }
    
    //this function is connected to get button in the nav bar to get people by HTTP
    @IBAction func getDukePerson(_ sender: UIBarButtonItem) {
        let _ = GETJson()
        let _ = DukePerson.saveToDoInfo(items)
        let _ = DukePerson.saveToDoInfo2(sections)
        self.tableView.reloadData()
    }

      //  for person in items[3]{
        //    print("items[3]: \(items[3])")
          //  postPeople(member: person)
       // }

    //this function is connected to post button in the tableview cell to send people by HTTP
    @IBAction func postDukePerson(_ sender: postBtn) {
        let seg = sender.secTag
        let row = sender.tag
        let person = items[seg][row]
        postPeople(member: person)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mySearchBar.delegate = self
        initItems()
        addDefaultPerson()
        currentTeam = Array(items.joined())
        self.view.backgroundColor = APPLE_GREEN
        
        //myTableView.tableHeaderView = mySearchBar
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return isSearch ? "" : sections[section]

    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = DARK_GREEN
        let headerLabel = UILabel(frame: CGRect(x: 30, y: 0, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Chalkduster", size: 20)
        headerLabel.textColor = UIColor.white
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
       return isSearch ? 1 : sections.count
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = APPLE_GREEN
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return isSearch ? currentTeam.count : items[section].count
    }

    //we handle cell propoties in this function
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DukePersonTableViewCell
        let tempPerson: DukePerson
        if(!isSearch) {
            tempPerson = items[indexPath.section][indexPath.row]
        } else {
            tempPerson = currentTeam[indexPath.row]
        }
        let data = UserDefaults.standard.object(forKey: tempPerson.img) as? NSData
        if(data != nil) {
         cell.cellimg.image = UIImage(data: data! as Data)
        } else {
         let myGif = UIImage.gifImageWithName("funny")
         //cell.cellimg.image = UIImage(named: tempPerson.img)
            cell.cellimg.image = myGif
        }
        cell.cellLabel.text = tempPerson.fullName
        cell.cellDes.text = tempPerson.description
        cell.postBtn.tag = indexPath.row
        cell.postBtn.secTag = indexPath.section
        return cell
    }
    
    //this function is used to set a temp array for searching
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentTeam = Array(items.joined())
            isSearch = false
            myTableView.reloadData()
            return
        }
        
        currentTeam = Array(items.joined()).filter({ person -> Bool in
            guard let text = searchBar.text else {return false}
            return person.firstName.lowercased().contains(text.lowercased()) || person.lastName.lowercased().contains(text.lowercased())
        })
        isSearch = true
        myTableView.reloadData()
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    //this function is used in delete people
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items[indexPath.section].remove(at: indexPath.row)
            
            let _ = DukePerson.saveToDoInfo(items)
            let _ = DukePerson.saveToDoInfo2(sections)
            myTableView.reloadData()
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /*this function get people array by http from the server and it convert JSON
    * from server to DukePerson, and it append these persons into peopleFromServer
    * array in order to save them into items */
    func convertJsonToPeople( peopleFromServer: inout [DukePerson], post: inout [[String: AnyObject]]) {
        for p in post {
            let t = DukePerson("", "")
            if let fn = p["firstname"] as? String
            {
                    t.firstName = String(fn)
            }
            if let uid = p["uid"] as? Int
            {
                    t.uid = uid
            }
            if let ln = p["lastname"] as? String
            {
                    t.lastName = String(ln)
            }
            if let wf = p["wherefrom"] as? String
            {
                    t.whereFrom = String(wf)
            }
            if let g = p["gender"] as? Bool
            {
                    t.gender = g ? Gender.Male : .Female
            }
            if let r = p["role"] as? String
            {
                    t.role = r == "TA" ? DukeRole.TA : r == "Professor" ? DukeRole.Professor : DukeRole.Student
            }
            
            if let team = p["team"] as? String
            {
                    t.team = team
            }
            
            if let hb = p["hobbies"] as? [String]
            {
                    t.hobbies = hb
            }
            
            if let lang = p["languages"] as? [String]
            {
                    t.bestProgrammingLanguages = lang
            }
            
            if let pic = p["pic"] as? String
            {
                    t.imgForJSON = pic
            }
            peopleFromServer.append(t)
            print(t)
        }
    }
    
    /*this is a helper function to check if a person is in item*/
    func containsPeople(_ p: DukePerson) -> Bool {
        for i in items {
            for j in i {
                if ((j.firstName == p.firstName && j.lastName == p.lastName) || j.uid != nil && j.uid == p.uid) {
                    return true
                }
            }
        }
        return false
    }
    
    /*this function add persons from server to items*/
    func addPeopleFromNet(_ peopleFromServer: inout [DukePerson]) {
        for p in peopleFromServer {
            if p.role == .Professor {
                items[0].append(p)
            } else if p.role == .TA {
                items[1].append(p)
            } else {
                let idx = sections.index(of: p.team)
                if(idx != nil) {
                    if(!containsPeople(p)) {
                    items[idx!].append(p)
                    }
                } else {
                    sections.append(p.team)
                    items.append([DukePerson]())
                    if(!containsPeople(p)) {
                        items[items.count - 1].append(p)
                    }
                }
            }
        }
    }
    /*this function handles get request */
    func GETJson() -> Bool {
        let url = URL(string: "http://ece564.colab.duke.edu:5000/get")
        var isJSON = true
        var peopleFromServer = [DukePerson]()
        let httprequest = URLSession.shared.dataTask(with: url!){ (data, response, error) in
            if error != nil
            {
                print("error calling GET on /posts/55")
                isJSON = false
            }
            else
            {
                do {
                    var post = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String: AnyObject]]
                    self.convertJsonToPeople(peopleFromServer: &peopleFromServer, post: &post)
                    self.addPeopleFromNet(&peopleFromServer)
                    DispatchQueue.main.async {
                        self.myTableView.reloadData()
                    }
                   // print(post)
                } catch let error {
                    print("json error: \(error)")
                    isJSON = false
                }
            }
            
        }
        httprequest.resume()
        return isJSON
    }
    
    /*this function convert a DukePerson into a dictionary and then it convert the
     * dictionary into JSON */
    func postSinglePeople(p : DukePerson) -> String {
        var res = ""
        var dic = [String:AnyObject]()
        dic["uid"] = p.uid as AnyObject
        dic["firstname"] = p.firstName as AnyObject
        dic["lastname"] = p.lastName as AnyObject
        dic["wherefrom"] = p.whereFrom as AnyObject
        dic["gender"] = (p.gender == Gender.Male ? true : false )as AnyObject
        dic["role"] = p.role.rawValue as AnyObject
        dic["degree"] = p.degree as AnyObject
        dic["team"] = p.team as AnyObject
        dic["hobbies"] = p.hobbies as AnyObject
        dic["languages"] = p.bestProgrammingLanguages as AnyObject
        dic["pic"] = (p.imgForJSON ?? "xx") as AnyObject
        
        do {
            let jsonOutput = try JSONSerialization.data(withJSONObject: dic)
            res = String(data: jsonOutput, encoding: String.Encoding.utf8)! as String
        } catch let error {
            print("json error: \(error)")
        }
        print("res: \(res)")
        return res
    }

    /*this function post a DukePerson to server*/
    func postPeople(member: DukePerson) {
        let url = URL(string: "http://ece564.colab.duke.edu:5000/send")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let postString = postSinglePeople(p: member)
        request.httpBody = postString.data(using: .utf8)
        
        DispatchQueue.main.async {
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    return // check for fundamental networking error
                }
                
                // Getting values from JSON Response
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(String(describing: responseString))")
                
            }
            task.resume()
            //            print("response: \()")
        }
    }

    
    //This function add default persons when there is no infomation in the JSON file
    func addDefaultPerson() {
        if let persons = DukePerson.loadToDoInfo() {
            items = persons
            sections = DukePerson.loadToDoInfo2()!
        } else {
            
            let Yuanyuan = DukePerson("Yuanyuan", "Yu")
            Yuanyuan.gender = .Female
            Yuanyuan.role = .Student
            Yuanyuan.whereFrom = "China"
            Yuanyuan.degree = "MS"
            Yuanyuan.hobbies = ["Baseball", "Fencing", "Golf"]
            Yuanyuan.bestProgrammingLanguages = ["Java", "Swift", "Python"]
            Yuanyuan.img = "yy"
            Yuanyuan.uid = 20
            Yuanyuan.team = "Sakai TV"
            map["Yuanyuan Yu"] = Yuanyuan
            personArray.append(Yuanyuan)
            
            let rx = DukePerson("Xin", "Rong")
            rx.gender = .Male
            rx.role = .Student
            rx.whereFrom = "China"
            rx.degree = "MS"
            map["Xin Rong"] = rx
            rx.team = "Sakai TV"
            rx.uid = 21
            rx.hobbies = ["reading", "swimming", "singing"]
            rx.bestProgrammingLanguages = ["C++", "Java", "Swift"]
            personArray.append(rx)
            
            let xt = DukePerson("Tong", "Xiong")
            xt.gender = .Female
            xt.role = .Student
            xt.whereFrom = "China"
            xt.degree = "MS"
            xt.uid = 41
            map["Tong Xiong"] = xt
            xt.team = "Sakai TV"
            xt.hobbies = ["climbing", "shopping", "skating"]
            xt.bestProgrammingLanguages = ["C++", "Python", "Swift"]
            personArray.append(xt)
            
            items[3].append(Yuanyuan)
            items[3].append(xt)
            items[3].append(rx)
            
            
            let _ = DukePerson.saveToDoInfo(items)
            let _ = DukePerson.saveToDoInfo2(sections)
        }
        
        
    }

    
    //this function prepare info for Add and Edit mode
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "Add") {
            if let destination = segue.destination as? UINavigationController {
                let nextViewController = destination.viewControllers[0] as! ViewController
                nextViewController.save = .Save
            }
        }
        if(segue.identifier == "Edit") {
            if let destination = segue.destination as? PageViewController {
                rowIdx = myTableView.indexPathForSelectedRow!.row
                secIdx = myTableView.indexPathForSelectedRow!.section
                destination.isYYY = (items[secIdx][rowIdx].lastName == "Yu" && items[secIdx][rowIdx].firstName == "Yuanyuan")
                destination.isTong = (items[secIdx][rowIdx].lastName == "Xiong" && items[secIdx][rowIdx].firstName == "Tong")
                destination.isXin = (items[secIdx][rowIdx].lastName == "Rong" && items[secIdx][rowIdx].firstName == "Xin")
                let nextViewController = destination.subViewControllers[0] as! nv1
                let now = nextViewController.viewControllers[0] as! ViewController
                now.newPerson = items[secIdx][rowIdx]
                now.isNewPerson = false
                //now.imgId = Int(items[secIdx][rowIdx].img) ?? 0
                now.imgId = items[secIdx][rowIdx].img
            }
        }
    }

    //This function handles info back from ViewController
    @IBAction func returnFromNewItem(segue: UIStoryboardSegue) {
        let source:ViewController = segue.source as! ViewController
        let item:DukePerson = source.newPerson
        if(!source.isClose && item.firstName != "" && item.lastName != "") {
            if(source.isNewPerson == false) {
                print("err")
                items[secIdx].remove(at: rowIdx)
            }
            if (item.role == DukeRole.Professor) {
                items[0].append(item)
            } else if (item.role == DukeRole.TA) {
                items[1].append(item)
            } else if (item.role == DukeRole.Student) {
                let teamName = item.team.trimmingCharacters(in: .whitespacesAndNewlines)
                if(teamName == "" || teamName == "TA" || teamName == "Professor") {
                 items[2].append(item)
                } else {
                    if(!sections.contains(teamName)) {
                        sections.append(teamName)
                        items.append([DukePerson]())
                    }
                    let idx = sections.index(of: teamName)
                    items[idx!].append(item)
                }
            }
        }
        let _ = DukePerson.saveToDoInfo(items)
        let _ = DukePerson.saveToDoInfo2(sections)
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        self.mySearchBar.endEditing(true)
    }
    
}














