//
//  Banner.swift
//  Collection-View-Layout-iOS13
//
//  Created by atikhonov on 18.04.2020.
//  Copyright © 2020 atikhonov. All rights reserved.
//

import Foundation

struct Banner {
    var title: String
    var subtitle: String
    var imageName: String
}

extension Banner {
    static func testData() -> [Banner] {
        let banner1 = Banner(title: "A Guide to Pricing Plans", subtitle: "Peer-to-peer database, identity provider, and messaging system", imageName: "1")
        let banner2 = Banner(title: "Ultimate Guide to Switch Debounce", subtitle: "Peer-to-peer database, identity provider, and messaging system", imageName: "2")
        let banner3 = Banner(title: "Show HN: Shishua – Fast pseudo-random generator", subtitle: "Micro C, Part 3: Generating LLVM", imageName: "3")
        let banner4 = Banner(title: "The Lawyer Whose Clients Didn’t Exist", subtitle: "Inside the Am2901", imageName: "4")
        let banner5 = Banner(title: "Effective Reproduction Number", subtitle: "Remembering Freeman Dyson", imageName: "5")
        let banner6 = Banner(title: "Use of Mussels to Improve Water Quality", subtitle: "Avatarify lets users run realtime", imageName: "6")
        let banner7 = Banner(title: "GCC always assumes aligned pointer accesses", subtitle: "The Magical Number Seven, Plus or Minus Two", imageName: "7")
        let banner8 = Banner(title: "BGP and RPKI", subtitle: "Ask HN: What are some great posts or articles about history of computing?", imageName: "8")
        let banner9 = Banner(title: "Watch Zoox’s autonomous car", subtitle: "1970s bit-slice processor", imageName: "9")
        let banner10 = Banner(title: "A P2P hypermedia protocol", subtitle: "CDATA", imageName: "10")
        let banner11 = Banner(title: "Recon", subtitle: "A new way to control your experience", imageName: "11")
        let banner12 = Banner(title: "Helpful iOS and Xcode Code Snippets", subtitle: "Jungle Problem", imageName: "12")
        let banner13 = Banner(title: "Inheritance, Encapsulation, and Polymorphism", subtitle: "Goodbye, Object Oriented Programming", imageName: "13")
        return [banner1, banner2, banner3, banner4, banner5, banner6, banner7, banner8, banner9, banner10, banner11, banner12, banner13]
    }
}
