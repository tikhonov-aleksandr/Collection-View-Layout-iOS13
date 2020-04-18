//
//  App.swift
//  Collection-View-Layout-iOS13
//
//  Created by atikhonov on 18.04.2020.
//  Copyright © 2020 atikhonov. All rights reserved.
//

import Foundation

struct App {
    var title: String
    var subtitle: String
    var imageName: String
}

extension App {
    static func testData() -> [App] {
        let app1 = App(title: "1password", subtitle: "Peer-to-peer database, identity provider, and messaging system", imageName: "1password")
        let app2 = App(title: "smart-watch", subtitle: "Peer-to-peer database, identity provider, and messaging system", imageName: "smart-watch")
        let app3 = App(title: "telegram-app", subtitle: "Inside the Am2901", imageName: "telegram-app")
        let app4 = App(title: "ifttt", subtitle: "Micro C, Part 3: Generating LLVM", imageName: "ifttt")
        let app5 = App(title: "google", subtitle: "Avatarify lets users run realtime", imageName: "google")
        let app6 = App(title: "microsoft-outlook", subtitle: "The Magical Number Seven, Plus or Minus Two", imageName: "microsoft-outlook")
        let app7 = App(title: "windows8", subtitle: "Ask HN: What are some great posts or articles about history of computing?", imageName: "windows8")
        let app8 = App(title: "airplane", subtitle: "1970s bit-slice processor", imageName: "airplane")
        let app9 = App(title: "apk", subtitle: "CDATA", imageName: "apk")
        let app10 = App(title: "bebo", subtitle: "A new way to control your experience", imageName: "bebo")
        let app11 = App(title: "google-plus", subtitle: "Use of Mussels to Improve", imageName: "google-plus")
        let app12 = App(title: "blackberry", subtitle: "Jungle Problem", imageName: "blackberry")
        let app13 = App(title: "react-native", subtitle: "Goodbye, Object Oriented Programming", imageName: "react-native")
        let app14 = App(title: "pocket", subtitle: "Helpful iOS and Xcode Code", imageName: "pocket")
        return [app1, app2, app3, app4, app5, app6, app7, app8, app9, app10, app11, app12, app13, app14]
    }
}
