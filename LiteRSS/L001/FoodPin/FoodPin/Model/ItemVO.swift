//
//  Restaurant.swift
//  FoodPin
//
//  Created by Simon Ng on 15/8/2018.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation

class ItemVO {
    var title: String
    var link: String
    var description: String
    var author: String
    var source: String
    var pubDate: String
    var guid: String
    
    init(title: String, link: String, description: String, author: String, source: String, pubDate: String, guid: String) {
        self.title = title
        self.link = link
        self.description = description
        self.author = author
        self.source = source
        self.pubDate = pubDate
        self.guid = guid
    }
    
    convenience init() {
        self.init(title: "", link: "", description: "", author: "", source: "", pubDate: "", guid: "")
    }
}
