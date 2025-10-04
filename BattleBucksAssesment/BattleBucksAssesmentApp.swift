//
//  BattleBucksAssesmentApp.swift
//  BattleBucksAssesment
//
//  Created by Sudeepa Pal on 01/10/25.
//

import SwiftUI

@main
struct BattleBucksAssesmentApp: App {
    
    init() {
        UISearchBar.appearance().overrideUserInterfaceStyle = .dark
        
        //Use this if NavigationBarTitle is with Large Font
        //UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
            
            ShowingList()
        }
    }
}
