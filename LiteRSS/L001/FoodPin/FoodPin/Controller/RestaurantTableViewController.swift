//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Simon Ng on 8/8/2018.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

import Alamofire
import SWXMLHash
import AlamofireXmlToObjects
import EVReflection

class CnbetaResponse: EVObject {
    var rss: Rss?
}

class Rss: EVObject {
    var __name: String?
    var _version: String?
    var channel: Channel?
}

class Channel: EVObject {
    var title: String?
    var link: String?
    var language: String?
    var copyright: String?
    var image: EVImage? = nil
    var item: [Item] = [Item]()
    
    var descriptions: String?
    var generator: String?
    var pubDate: String?
    
    // 关键字别名，例如 description 是系统的关键字，那我们用别名 descriptions 代替
    override internal func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
        return [("descriptions", "description")]
    }
}

class EVImage: EVObject {
    var url: String?
    var title: String?
    var link: String?
}

class Item: EVObject {
    var title: String?
    var link: String?
    var descriptions: String?
    var author: String?
    var source: String?
    var pubDate: String?
    var guid: String?
    
    // 关键字别名，例如 description 是系统的关键字，那我们用别名 descriptions 代替
    override internal func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
        return [("descriptions", "description")]
    }
}

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating, XMLParserDelegate {
    
    

    // Cafe Deadend, G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong
    // Homei Shop B, G/F, 22-24A Tai Ping San Street SOHO, Sheung Wan, Hong Kong
    var restaurants: [RestaurantMO] = []
    // 整个空白页面视图
    @IBOutlet var emptyRestaurantView: UIView!
    // 查询控制器
    var fetchResultController: NSFetchedResultsController<RestaurantMO>!
    // 查找控制器
    var searchController: UISearchController!
    // 查找结果
    var searchResults: [RestaurantMO] = []
    
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("RestaurantTableViewController viewDidLoad")

        tableView.cellLayoutMarginsFollowReadableWidth = true
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Customize the navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        if let customFont = UIFont(name: "Rubik-Medium", size: 40.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor(red: 231, green: 76, blue: 60),
                                                                             NSAttributedString.Key.font: customFont ]
        }
        navigationController?.hidesBarsOnSwipe = true
        
        // Prepare the empty view
        tableView.backgroundView = emptyRestaurantView
        tableView.backgroundView?.isHidden = true
        
        // Fetch data from data store
        let fetchRequest: NSFetchRequest<RestaurantMO> = RestaurantMO.fetchRequest()
        
       // let fetchRequest: NSFetchRequest<CnbetaItemMO> = CnbetaItemMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    restaurants = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
        
        // Adding a search bar
        searchController = UISearchController(searchResultsController: nil)
        // self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Search restaurants...", comment: "Search restaurants...")
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.tintColor = UIColor(red: 231, green: 76, blue: 60)
        
        // Replace the follown line of code with the one above
        // if you want to put the search bar in the navigation bar
        tableView.tableHeaderView = searchController.searchBar
        
        self.definesPresentationContext = true
        
        //prepareCoreData()
        
        // Prepare for notifications
        //prepareNotification()
        
        //prepareNotificationV2()
        
        // with image
        //prepareNotificationV3()
        
        // with custom actions
        // prepareNotificationV4()
        
        // Handing the Actions
        //prepareNotificationV5()
        deleteAllRestaurantMO()
        test2()
    }
    
    func test2() {
        let URL = "https://www.cnbeta.com/backend.php"
        Alamofire.request(URL).responseObject { (response: DataResponse<Rss>) in
            if let rss = response.value {
                // That was all... You now have a WeatherResponse object with data
                //print(rss)
                let items = rss.channel?.item
                //print(items.size())
                
                var restaurant: RestaurantMO!
                for (i, item) in (items?.enumerated())! {
                    print("arr[\(i)] = \(item)")
                    if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                        restaurant = RestaurantMO(context: appDelegate.persistentContainer.viewContext)
                        
                        restaurant.name = item.title
                        //restaurant.type = item.descriptions
                        //print(item.description)
                        //print("============================")
                        //var desc: String = item.descriptions ?? ""
                        //let range: Range = desc.range(of: "strong")
                        //print("index: \(indexStrong)")
//                        desc.replaceSubrange("", with: Collection)
                        restaurant.location = self.filterContentTest(str: item.descriptions!)
                        //print(item.descriptions)
                        //restaurant.location = addressTextField.text
//                        restaurant.phone = phoneTextField.text
//                        restaurant.summary = summaryTextView.text
//                        restaurant.isVisited = false
//
//                        if let restaurantImage = photoImageView.image {
//                            restaurant.image = restaurantImage.pngData()
//                        }
                       
                        print("Saving data to context ...")
                        appDelegate.saveContext()
                    }
                }
                // self.stringTest()
                //self.filterContentTest()
            }
        }
    }
    
    func stringTest() {
        let str: String = "一二三四五六七八九十1234567890"
        
        let subStr_prefix_maxLength = str.prefix(5)
        print("subStr_prefix_maxLength: \(subStr_prefix_maxLength)")
        // “一二三四五” 截取 正数 maxLength 位
        
        let subStr_prefix_upTo = str.prefix(upTo: str.firstIndex(of: "6")!)
        print("subStr_prefix_upTo: \(subStr_prefix_upTo)")
        // 一二三四五六七八九十12345
        
        let subStr_prefix_through = str.prefix(through: str.firstIndex(of: "2")!)
        print("subStr_prefix_through: \(subStr_prefix_through)")
        // 一二三四五六七八九十12
        
        let key = "五"
        let range1 = str.range(of: key)
        let subStr_prefix_upTo2_lower = str.prefix(upTo: (range1?.lowerBound)!)
        print("subStr_prefix_upTo2_lower: \(subStr_prefix_upTo2_lower)")
        // 一二三四
        
        let subStr_prefix_upTo2_upper = str.prefix(upTo: (range1?.upperBound)!)
        print("subStr_prefix_upTo2_upper: \(subStr_prefix_upTo2_upper)")
        // 一二三四五
        
        let subStr_prefix_through2_lower = str.prefix(through: (range1?.lowerBound)!)
        print("subStr_prefix_through2_lower: \(subStr_prefix_through2_lower)")
        // 一二三四五
        
        let subStr_prefix_through_upper = str.prefix(through: (range1?.upperBound)!)
        print("subStr_prefix_through_upper: \(subStr_prefix_through_upper)")
        // 一二三四五六
        
        // suffix
        let subStr_suffix_maxLength = str.suffix(6)
        print("subStr_suffix_maxLength: \(subStr_suffix_maxLength)")
        // 567890 截取 倒数 maxLength 位
        
        let subStr_suffix_from = str.suffix(from: str.firstIndex(of: "5")!)
        print("subStr_suffix_from: \(subStr_suffix_from)")
        // 567890 从 String.Index 开始，包含到结束
    }
    
    func findStringTest() {
        let str: String = "我最爱北京天安门！"
        let range: Range = str.range(of: "北京")!
        let location: Int = str.distance(from: str.startIndex, to: range.lowerBound)
        /* location = 3 */
        
        let keyLength: Int = str.distance(from: range.lowerBound, to: range.upperBound)
        // let key = "北京"; let keyLength = key.count;  //count = 2
        /* keyLength = 2 */
        
        print("location = \(location), length = \(keyLength)")
        /* location = 3, length = 2 */
        
        // SubString
        let frontStr: Substring = str[str.startIndex ..< range.lowerBound]
        print("frontSubStr = \(frontStr)")
        /* 我最爱 */
        
        let frontStr2: Substring = str[str.startIndex ... range.lowerBound]
        print("frontSubStr2 = \(frontStr2)")
        /* 我最爱北 */
        
        
        // MARK: 下面这几个方法，可以自己试一下
        /*
         func index(after: String.Index)
         Returns the position immediately after the given index.
         
         func formIndex(after: inout String.Index)
         Replaces the given index with its successor.
         
         
         func index(before: String.Index)
         Returns the position immediately before the given index.
         
         func formIndex(before: inout String.Index)
         Replaces the given index with its predecessor.
         */
        let frontTest_before: Substring = str[str.startIndex ..< str.index(before: range.lowerBound)]
        let frontTest_after: Substring = str[str.startIndex ..< str.index(after: range.lowerBound)]
        print("before = \(frontTest_before), after = \(frontTest_after)")
        /* before = 我最, after = 我最爱北 */
    }
    
    func filterContentTest(str: String) -> String {
        //let str = "<p><strong>美国有线电视新闻网（CNN）发表文章称，今年国际消费电子展（CES）最热门的产品可能是“隐私”。<\\/strong>本周，在拉斯维加斯举行的这场备受关注的行业展会上，参展的几家大型科技公司都特别强调了用户隐私问题。原因是，近几年来，各国监管机构和消费者对高科技行业处理个人数据的方式进行了越来越严格的审查。</p> <a href=\"https:\\/\\/www.cnbeta.com\\articles\\tech\\930109.htm\" target=\"_blank\"><strong>阅读全文<\\/strong><\\/a>"
        
        //let str: String = "我最爱北京天安门！"
        guard let range: Range = str.range(of: "<a ") else {
            var result = str.replacingOccurrences(of: "<p>", with: "")
            result = result.replacingOccurrences(of: "</p>", with: "")
            result = result.replacingOccurrences(of: "<strong>", with: "")
            result = result.replacingOccurrences(of: "</strong>", with: "")
            result = result.replacingOccurrences(of: "<\\/strong>", with: "")
            return result
        }
        //let location: Int = str.distance(from: str.startIndex, to: range.lowerBound)
        
        /* location = 3 */
        
        //let keyLength: Int = str.distance(from: range.lowerBound, to: range.upperBound)
        // let key = "北京"; let keyLength = key.count;  //count = 2
        /* keyLength = 2 */
        
        //print("location = \(location), length = \(keyLength)")
        /* location = 3, length = 2 */
        
        // SubString
        let frontStr: Substring = str[str.startIndex ..< range.lowerBound]
        print("frontSubStr = \(frontStr)")
        /* 我最爱 */
        
        var result = frontStr.replacingOccurrences(of: "<p>", with: "")
        result = result.replacingOccurrences(of: "</p>", with: "")
        result = result.replacingOccurrences(of: "<strong>", with: "")
        result = result.replacingOccurrences(of: "<\\/strong>", with: "")
        result = result.replacingOccurrences(of: "</strong>", with: "")
        
        //let frontStr2: Substring = str[str.startIndex ... range.lowerBound]
        //print("frontSubStr2 = \(frontStr2)")
        /* 我最爱北 */
        
        
        // MARK: 下面这几个方法，可以自己试一下
        /*
         func index(after: String.Index)
         Returns the position immediately after the given index.
         
         func formIndex(after: inout String.Index)
         Replaces the given index with its successor.
         
         
         func index(before: String.Index)
         Returns the position immediately before the given index.
         
         func formIndex(before: inout String.Index)
         Replaces the given index with its predecessor.
         */
//        let frontTest_before: Substring = str[str.startIndex ..< str.index(before: range.lowerBound)]
//        let frontTest_after: Substring = str[str.startIndex ..< str.index(after: range.lowerBound)]
//        print("before = \(frontTest_before), after = \(frontTest_after)")
        /* before = 我最, after = 我最爱北 */
        print("result = \(result)")
        return result
    }
    
    //MARK:    获取上下文对象
    
    func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    //MARK:    删除 RestaurantMO
    func deleteAllRestaurantMO() -> Void {
        
        //获取委托
        let app = UIApplication.shared.delegate as! AppDelegate
        
        //获取数据上下文对象
        let context = getContext()
        
        //声明数据的请求，声明一个实体结构
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RestaurantMO")
        
        
        // 异步请求由两部分组成：普通的request和completion handler
        
        // 返回结果在finalResult中
        let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (result:NSAsynchronousFetchResult) in
            
            //对返回的数据做处理。
            let fetchObject = result.finalResult! as! [RestaurantMO]
            
            for c in fetchObject{
                //所有删除信息
                context.delete(c)
            }
            
            app.saveContext()
        }
        
        // 执行异步请求调用execute
        do {
            try context.execute(asyncFetchRequest)
        } catch  {
            print("error")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 如何显示过向导，就不再显示了
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") {
            return
        }
        
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughViewController")
                                                as? WalkthroughViewController {
            present(walkthroughViewController, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // 没有数据就显示空白视图
        if restaurants.count > 0 {
            tableView.backgroundView?.isHidden = true
            tableView.separatorStyle = .singleLine
        } else {
            tableView.backgroundView?.isHidden = false
            tableView.separatorStyle = .none
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return searchResults.count
        } else {
            return restaurants.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        // Determine if we get the restaurant from search result or the original array
        let restaurant = (searchController.isActive) ? searchResults[indexPath.row] : restaurants[indexPath.row]
        
        // Configure the cell...
        cell.nameLabel.text = restaurant.name
        if let restaurantImage  = restaurant.image {
            cell.thumbnailImageView.image = UIImage(data: restaurantImage as Data)
        }
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
        cell.heartImageView.isHidden = restaurant.isVisited ? false : true
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: NSLocalizedString("Delete", comment: "Delete")) { (action, sourceView, completionHandler) in
            // Delete the row from the data store
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let restaurantToDelete = self.fetchResultController.object(at: indexPath)
                context.delete(restaurantToDelete)
                
                appDelegate.saveContext()
            }
            
            // Call completion handler with true to indicate
            completionHandler(true)
        }
        
        let shareAction = UIContextualAction(style: .normal, title: NSLocalizedString("Share", comment: "Share")) { (action, sourceView, completionHandler) in
            let defaultText = NSLocalizedString("Just checking in at ", comment: "Just checking in at ") + self.restaurants[indexPath.row].name!
            
            let activityController: UIActivityViewController
            
            if  let restaurantImage  = self.restaurants[indexPath.row].image, let imageToShare = UIImage(data: restaurantImage as Data) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else  {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            
            if let popoverController = activityController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        
        // Set the icon and background color for the actions
        deleteAction.backgroundColor = UIColor(red: 231, green: 76, blue: 60)
        deleteAction.image = UIImage(named: "delete")
        
        shareAction.backgroundColor = UIColor(red: 254, green: 149, blue: 38)
        shareAction.image = UIImage(named: "share")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        
        return swipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let checkInAction = UIContextualAction(style: .normal, title: NSLocalizedString("Check-in", comment: "Check-in")) { (action, sourceView, completionHandler) in
            
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            self.restaurants[indexPath.row].isVisited = (self.restaurants[indexPath.row].isVisited) ? false : true
            cell.heartImageView.isHidden = self.restaurants[indexPath.row].isVisited ? false : true
            
            completionHandler(true)
        }
        
        let checkInIcon = restaurants[indexPath.row].isVisited ? "undo" : "tick"
        checkInAction.backgroundColor = UIColor(red: 38, green: 162, blue: 78)
        checkInAction.image = UIImage(named: checkInIcon)
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [checkInAction])
        
        
        return swipeConfiguration
    }
    
    /// 是否可编辑（向左滑动单元格显示分享和删除按钮）
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // 如果有查询控制器就不显示
        if searchController.isActive {
            return false
        } else {
            return true
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestaurantDetailViewController
                destinationController.restaurant = (searchController.isActive) ? searchResults[indexPath.row] : restaurants[indexPath.row]
                // 在详细页面不限行底部bar
                destinationController.hidesBottomBarWhenPushed = true
            }
        }
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - NSFetchedResultsControllerDelegate methods
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        
        if let fetchedObjects = controller.fetchedObjects {
            restaurants = fetchedObjects as! [RestaurantMO]
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    // MARK: - Search methods
    
    func filterContent(for searchText: String) {
        searchResults = restaurants.filter({ (restaurant) -> Bool in
            if let name = restaurant.name,
                let location = restaurant.location {
                let isMatch = name.localizedCaseInsensitiveContains(searchText)
                               || location.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            
            return false
        })
    }
    
     // MARK: - Search methods
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    // MARK: - User Notifications
    
    func prepareNotification() {
        
        print("prepareNotification")
       
        // Create the user notification
        let content = UNMutableNotificationContent()
        
        content.title = "Restaurant Recommendation"
        content.subtitle = "Try new food today"
        content.body = "I recommend you to check out Cafe Deadend"
        content.sound = UNNotificationSound.default
        // 设置请求标识符
        let requestIdentifier = "foodpin.restaurantSuggestion"
        // 设置通知触发器
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
        // 设置一个通知请求
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        
        // Schedule the notification
        // UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)      

        
        // 将通知请求添加到发送中心
        UNUserNotificationCenter.current().add(request) { error in
            if error == nil {
                print("Time Interval Notification scheduled: \(requestIdentifier)")
            }
        }
    }
    
    func prepareNotificationV2() {
        print("prepareNotification")
        // Make sure the restaurant array is not empty
        if restaurants.count <= 0 {
            return
        }
        
        // Pick a restaurant randomly
        let randomNum = Int.random(in: 0..<restaurants.count)
        let suggestedRestaurant = restaurants[randomNum]
        
        // Create the user notification
        let content = UNMutableNotificationContent()
        content.title = "Restaurant Recommendation"
        content.subtitle = "Try new food today"
        content.body = "I recommend you to check out \(suggestedRestaurant.name!). The restaurant is one of your favorites. It is located at \(suggestedRestaurant.location!). Would you like to give it a try?"
        content.sound = UNNotificationSound.default
        print("\(content.body)")
        // 设置请求标识符
        let requestIdentifier = "foodpin.restaurantSuggestion2"
        // 设置通知触发器
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
        // 设置一个通知请求
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        
        // 将通知请求添加到发送中心
        UNUserNotificationCenter.current().add(request) { error in
            if error == nil {
                print("Time Interval Notification scheduled: \(requestIdentifier)")
            }
        }
    }
    
    func prepareNotificationV3() {
        print("prepareNotification")
        // Make sure the restaurant array is not empty
        if restaurants.count <= 0 {
            return
        }
        
        // Pick a restaurant randomly
        let randomNum = Int.random(in: 0..<restaurants.count)
        let suggestedRestaurant = restaurants[randomNum]
        
        // Get the image
        let tempDirURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let tempFileURL = tempDirURL.appendingPathComponent("suggested-restaurant.jpg")
        
        // Create the user notification
        let content = UNMutableNotificationContent()
        content.title = "Restaurant Recommendation"
        content.subtitle = "Try new food today"
        content.body = "I recommend you to check out \(suggestedRestaurant.name!). The restaurant is one of your favorites. It is located at \(suggestedRestaurant.location!). Would you like to give it a try?"
        content.sound = UNNotificationSound.default
        print("\(content.body)")
        
        
        if let image = UIImage(data: suggestedRestaurant.image! as Data) {
            try? image.jpegData(compressionQuality: 1.0)?.write(to: tempFileURL)
            if let restaurantImage = try? UNNotificationAttachment(identifier: "restaurantImage", url: tempFileURL, options: nil) {
                content.attachments = [restaurantImage]
            }
        }
        
        // 设置请求标识符
        let requestIdentifier = "foodpin.restaurantSuggestion31"
        // 设置通知触发器
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
        // 设置一个通知请求
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        
        // 将通知请求添加到发送中心
        UNUserNotificationCenter.current().add(request) { error in
            if error == nil {
                print("Time Interval Notification scheduled: \(requestIdentifier)")
            }
        }
    }
    
    func prepareNotificationV4() {
        print("prepareNotification")
        // Make sure the restaurant array is not empty
        if restaurants.count <= 0 {
            return
        }
        
        // Pick a restaurant randomly
        let randomNum = Int.random(in: 0..<restaurants.count)
        let suggestedRestaurant = restaurants[randomNum]
        
        // Get the image
        let tempDirURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let tempFileURL = tempDirURL.appendingPathComponent("suggested-restaurant.jpg")
        
        // Create the user notification
        let content = UNMutableNotificationContent()
        content.title = "Restaurant Recommendation"
        content.subtitle = "Try new food today"
        content.body = "I recommend you to check out \(suggestedRestaurant.name!). The restaurant is one of your favorites. It is located at \(suggestedRestaurant.location!). Would you like to give it a try?"
        content.sound = UNNotificationSound.default
        print("\(content.body)")
        
        
        if let image = UIImage(data: suggestedRestaurant.image! as Data) {
            try? image.jpegData(compressionQuality: 1.0)?.write(to: tempFileURL)
            if let restaurantImage = try? UNNotificationAttachment(identifier: "restaurantImage", url: tempFileURL, options: nil) {
                content.attachments = [restaurantImage]
            }
        }
        
        // 设置请求标识符
        let requestIdentifier = "foodpin.makeReservation2" // V4
        let categoryIdentifer = "foodpin.restaurantaction2"
        let makeReservationAction = UNNotificationAction(identifier: requestIdentifier, title: "Reserve a table", options: [.foreground])
        let cancelAction = UNNotificationAction(identifier: "foodpin.cancel", title: "Later", options: [])
        let category = UNNotificationCategory(identifier: categoryIdentifer, actions: [makeReservationAction, cancelAction], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        content.categoryIdentifier = categoryIdentifer
        // 设置通知触发器
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
        // 设置一个通知请求
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        
        // 将通知请求添加到发送中心
        UNUserNotificationCenter.current().add(request) { error in
            if error == nil {
                print("Time Interval Notification scheduled: \(requestIdentifier)")
            }
        }
    }
    
    func prepareNotificationV5() {
        print("prepareNotification")
        // Make sure the restaurant array is not empty
        if restaurants.count <= 0 {
            return
        }
        
        // Pick a restaurant randomly
        let randomNum = Int.random(in: 0..<restaurants.count)
        let suggestedRestaurant = restaurants[randomNum]
        
        // Get the image
        let tempDirURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let tempFileURL = tempDirURL.appendingPathComponent("suggested-restaurant.jpg")
        
        // Create the user notification
        let content = UNMutableNotificationContent()
        content.title = "Restaurant Recommendation"
        content.subtitle = "Try new food today"
        content.body = "I recommend you to check out \(suggestedRestaurant.name!). The restaurant is one of your favorites. It is located at \(suggestedRestaurant.location!). Would you like to give it a try?"
        content.sound = UNNotificationSound.default
        print("\(content.body)")
        
        
        if let image = UIImage(data: suggestedRestaurant.image! as Data) {
            try? image.jpegData(compressionQuality: 1.0)?.write(to: tempFileURL)
            if let restaurantImage = try? UNNotificationAttachment(identifier: "restaurantImage", url: tempFileURL, options: nil) {
                content.attachments = [restaurantImage]
            }
        }
        
        // 设置请求标识符
        let requestIdentifier = "foodpin.makeReservation52" // V5
        let categoryIdentifer = "foodpin.restaurantaction52"
        let makeReservationAction = UNNotificationAction(identifier: requestIdentifier, title: "Reserve a table", options: [.foreground])
        let cancelAction = UNNotificationAction(identifier: "foodpin.cancel", title: "Later", options: [])
        let category = UNNotificationCategory(identifier: categoryIdentifer, actions: [makeReservationAction, cancelAction], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        content.userInfo = ["phone": suggestedRestaurant.phone!]
        
        content.categoryIdentifier = categoryIdentifer
        // 设置通知触发器
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
        // 设置一个通知请求
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        
        // 将通知请求添加到发送中心
        UNUserNotificationCenter.current().add(request) { error in
            if error == nil {
                print("Time Interval Notification scheduled: \(requestIdentifier)")
            }
        }
    }
    
    // Prepare Data
    private let restaurants2:   [Restaurant] = [        
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend", isVisited: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image: "homei", isVisited: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isVisited: false),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "cafeloisl", isVisited: false),
        Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", image: "petiteoyster", isVisited: false),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", image: "forkeerestaurant", isVisited: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", image: "posatelier", isVisited: false),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", image: "bourkestreetbakery", isVisited: false),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haighschocolate", isVisited: false),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "palominoespresso", isVisited: false),
        Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate", isVisited: false),
        Restaurant(name: "Traif", type: "American", location: "New York", image: "traif", isVisited: false),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "grahamavenuemeats", isVisited: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", image: "wafflewolf", isVisited: false),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "fiveleaves", isVisited: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image: "cafelore", isVisited: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "New York", image: "confessional", isVisited: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina", isVisited: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia", isVisited: false),
        Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak", isVisited: false),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "caskpubkitchen", isVisited: false)
    ]
    
    func prepareCoreData() {
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            for restaurant in restaurants2 {
                let restaurantVO = RestaurantMO(context: appDelegate.persistentContainer.viewContext)
                restaurantVO.name = restaurant.name
                restaurantVO.type = restaurant.type
                restaurantVO.location = restaurant.location
                restaurantVO.phone = restaurant.phone
                restaurantVO.isVisited = restaurant.isVisited
                if let restaurantImage  = UIImage(named: restaurant.image) {
                    restaurantVO.image = restaurantImage.pngData()
                }
                print("Saving data to context ...")
                appDelegate.saveContext()
            }
        }
    }
    
}
