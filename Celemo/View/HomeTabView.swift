//
//  TabView.swift
//  Celemo
//
//  Created by zunda on 2021/09/13.
//

import SwiftUI

struct HomeTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "doc.text.image")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear.circle")
                }
            PrivacyPolicyView()
                .tabItem {
                    Image(systemName: "hand.raised.circle")
                }
        }
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
