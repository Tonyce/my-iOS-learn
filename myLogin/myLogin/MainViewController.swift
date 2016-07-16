//
//  MainViewController.swift
//  myLogin
//
//  Created by D_ttang on 15/6/18.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit
import Accelerate

@IBDesignable
class MainViewController: UIViewController {

    @IBOutlet var MainView: UIView!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var topView: UIView!
    let tableItems = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5",
        "Item 6", "Item 7", "Item 8", "Item 9", "Item 10", "Item 11",
        "Item 12", "Item 13", "Item 14", "Item 15"]
    
    var cellEntrys = [CellEntry]()
    
    var addButtonFrame: CGRect = CGRectMake( UIScreen.mainScreen().bounds.width - 75, UIScreen.mainScreen().bounds.height, 50, 50)
    let meImageString = "me"
    var firstIn:Bool = true
    var wordView: UIView!
    var goSelfSetTapGesture: UITapGestureRecognizer!
    var headerBottomView: UIView!
    
    @IBOutlet weak var addBtn: MyAddButton!
    
    @IBOutlet weak var headerImageView: UIImageView!
    
    @IBOutlet weak var mainTable: UITableView!
//    var meImage:UIImageView!
    var meImage:UIView!
    
    var blurImages:NSMutableArray = []
    let transition = ShowInfoAnimator()
    var selectIndexPath: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goSelfSetTapGesture = UITapGestureRecognizer(target: self, action: Selector("goSelfSet:"))
        if let savedDiarys = loadDiarys() {
            cellEntrys += savedDiarys
        }else {
            loadSampleEntrys()
        }

        // Do any additional setup after loading the view.
        // let topTapGesture = UITapGestureRecognizer(target: self, action: Selector("topViewTap:"))
        // topView.addGestureRecognizer(topTapGesture)
        

        topView.layer.zPosition = 0
        mainTable.layer.zPosition = 2
        addBtn.layer.zPosition = 3
        segmentControl.layer.zPosition = 3
        
        initAddBtn()
        mainTable.delegate = self
        mainTable.dataSource = self
        
        // TableView Header
        mainTable.backgroundColor = UIColor.clearColor()
        
        mainTable.tableHeaderView = UIView(frame: CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.topView.frame.size.height + 100))
        
//        mainTable.tableHeaderView?.layer.backgroundColor = UIColor.grayColor().CGColor
//        let bottomBorder = CALayer()
//        bottomBorder.frame = CGRectMake(0.0, (mainTable.tableHeaderView?.frame.height)!, (mainTable.tableHeaderView?.frame.width)!, 1.0);
//        bottomBorder.backgroundColor = UIColor(white: 0.8, alpha: 1.0).CGColor
//        mainTable.tableHeaderView!.layer.addSublayer(bottomBorder)
        headerBottomView = UIView(frame: CGRectMake(self.view.frame.origin.x, self.topView.frame.size.height, self.view.frame.size.width, 90))

        headerBottomView.backgroundColor = UIColor.whiteColor()
        headerBottomView.layer.cornerRadius = 3
        headerBottomView.layer.shadowOpacity = 0.25
        headerBottomView.layer.shadowRadius = 5.0
        headerBottomView.layer.shadowColor = UIColor.blackColor().CGColor
        headerBottomView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        headerBottomView.addGestureRecognizer(goSelfSetTapGesture)
        mainTable.tableHeaderView?.addSubview(headerBottomView)
        mainTable.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.New, context: nil)
        
        headerImageView.image = UIImage(named: "background")
        
        initMeImage()
        initMeWord()
        
        self.prepareForBlurImages()
    }
    
    func loadSampleEntrys(){
        let entry1 = CellEntry(time: "11.02", content:"name: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", photo: photo1, rating: 4")
        
        let entry2 = CellEntry(time: "12.04", content: "UIImage(named:meal2.jpglet meal2 = Meal(name: \"Chicken and Potatoes\", photo: photo2, rating: 5")
        
        let entry3 = CellEntry(time: "11.04", content: "String(name: \"Pasta with Meatballs\", photo: photo3, rating: 3")
        cellEntrys += [entry1, entry2, entry3]
    }
    
    override func viewWillAppear(animated: Bool) {
        animatAddBtn()
        if firstIn == true{
            animateTable()
            firstIn = false
        }
        if let selectedIndexPath = self.mainTable.indexPathForSelectedRow {
            self.mainTable.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissViewAction(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
//    func topViewTap(recognizer: UITapGestureRecognizer) {
//        print("00")
//    }
    
    
    
    func initAddBtn(){
//        addBtn.frame = addButtonFrame
        addBtn.layer.cornerRadius = CGRectGetHeight(addButtonFrame) / 2
    }
    
    func initMeImage(){
        meImage = UIView(frame:CGRectMake(10, self.topView.frame.size.height - 35, 70, 70))
        let meImageView = UIImageView(image: UIImage(named: meImageString))
        meImageView.frame = CGRectMake(0,0,70,70)
        meImageView.layer.cornerRadius = 35
        meImageView.layer.masksToBounds = true
//        meImageView.layer.zPosition = 3
//        meImageView.userInteractionEnabled = false
        meImage.addSubview(meImageView)
        meImage.backgroundColor = UIColor.brownColor()
        meImage.layer.cornerRadius = 35
        meImage.layer.shadowOpacity = 0.75
        meImage.layer.shadowRadius = 5.0
        meImage.layer.shadowColor = UIColor.blackColor().CGColor
        meImage.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        mainTable.tableHeaderView?.addSubview(meImage)

//        meImage.addGestureRecognizer(goSelfSetTapGesture)
    }
    
    func initMeWord(){
//        wordView = UIView(frame:CGRectMake(80, self.topView.frame.size.height + 10, self.topView.frame.size.width - 100, 70))
        let textView = UITextView(frame: CGRectMake(90, 5, self.topView.frame.size.width - 120, 60))
        textView.text = "“至少要赢过昨天的自己"
        textView.font = UIFont.systemFontOfSize(15)
        textView.userInteractionEnabled = false
//        wordView.addSubview(textView)
//        wordView.backgroundColor = UIColor.whiteColor()
//        wordView.layer.cornerRadius = 3
//        wordView.layer.shadowOpacity = 0.25
//        wordView.layer.shadowRadius = 5.0
//        wordView.layer.shadowColor = UIColor.blackColor().CGColor
//        wordView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        headerBottomView.addSubview(textView)
//        wordView.addGestureRecognizer(goSelfSetTapGesture)
    }
    
    func animatAddBtn(){
        UIView.animateWithDuration(0.5, animations: {

            self.addBtn.center.x = self.view.bounds.width - 50
            self.addBtn.center.y = self.view.bounds.height - 50
        })
        UIView.animateWithDuration(1.5, animations: {
            
            self.addBtn.layer.shadowOpacity = 0.75
            self.addBtn.layer.shadowRadius = 5.0
            self.addBtn.layer.shadowColor = UIColor.blackColor().CGColor
            self.addBtn.layer.shadowOffset = CGSize(width: 0, height: 1.5)
            }, completion:nil)
    }
    
    func goSelfSet(recognizer: UITapGestureRecognizer){
        let selfSetView = storyboard!.instantiateViewControllerWithIdentifier("SelfSetViewController") as! SelfSetViewController
//        print("taped")
        presentViewController(selfSetView, animated: true, completion: nil)
        
    }

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return cellEntrys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mainCell", forIndexPath: indexPath) as! MainTableViewCell
        
        let cellEntry = cellEntrys[indexPath.row]
        cell.timeLabel.text = cellEntry.time
        cell.contentText.text = cellEntry.content
//        cell.textLabel?.text = tableItems[indexPath.row]
        return cell
    }
    
    func animateTable() {
        mainTable.reloadData()
        
        let cells = mainTable.visibleCells
        let tableHeight: CGFloat = mainTable.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animateWithDuration(1, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                }, completion: nil)
            
            index += 1
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            cellEntrys.removeAtIndex(indexPath.row)
            mainTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            saveDiarys()
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.addBtn.center.y = self.view.bounds.height + 50
            }, completion:nil)
        
        if segue.identifier == "showInfo" {
            
            UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.addBtn.center.y = self.view.bounds.height + 50
                }, completion: nil)
            
            if let indexPath = self.mainTable.indexPathForSelectedRow {
                selectIndexPath = indexPath
                let item = self.tableItems[indexPath.row]
                segue.destinationViewController.transitioningDelegate = self
                (segue.destinationViewController as! InfoViewController).item = item
            }
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if let selectIndexPath = selectIndexPath {
            // let tmpOriginFrame = (self.mainTable.cellForRowAtIndexPath(selectIndexPath)?.frame)!
            let rectOfCellInTableView = self.mainTable.rectForRowAtIndexPath(selectIndexPath)
            let tmpOriginFrame = self.mainTable.convertRect(rectOfCellInTableView, toView: mainTable.superview)
            transition.originFrame = CGRectMake(tmpOriginFrame.origin.x, tmpOriginFrame.origin.y,
                tmpOriginFrame.size.width, tmpOriginFrame.size.height)
            transition.presenting = true
        }
        return transition

    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}

extension MainViewController {
    @IBAction func loginOut(sender: UIButton) {
        //present details view controller
        LoginStatus.saveStatusToPlist(false)
        let loginViewController = storyboard!.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        presentViewController(loginViewController, animated: true, completion: nil)
    }
    
    @IBAction func addDiary(sender: UIStoryboardSegue){

        if let sourceViewController = sender.sourceViewController as? AddInfoViewController,
            diary = sourceViewController.diary {

//                let newIndexPath = NSIndexPath(forRow: cellEntrys.count, inSection: 0)
                let newIndexPath = NSIndexPath(forRow: 0, inSection: 0)
//                cellEntrys.append(diary)
                cellEntrys.insert(diary, atIndex: 0)
                mainTable.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Top)
                saveDiarys()
        }
//            diary = sourceViewController.diary {
//                if let selectedIndexPath = tableView.indexPathForSelectedRow {
//                    // Update an existing meal.
//                    meals[selectedIndexPath.row] = meal
//                    tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
//                }else {
//                    // Add a new meal.
//                    let newIndexPath = NSIndexPath(forRow: cellEntrys.count, inSection: 0)
//                    cellEntrys.append(diary)
//                    tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
//                }
//                saveMeals()
//        }
    }
}

extension MainViewController {
    func saveDiarys(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(cellEntrys, toFile: CellEntry.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    
    func loadDiarys() -> [CellEntry]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(CellEntry.ArchiveURL.path!) as? [CellEntry]
    }
}

//extension MainViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        let offset = scrollView.contentOffset.y
//        print("\(offset)")
//    }
//}
