//
//  PrivacyPolicyView.swift
//  Celemo
//
//  Created by zunda on 2021/09/25.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        List {
            Section(content: {
                Text("個人情報(デバイス情報)は第三者に提供されません。")
            }, header: {
                Text("個人情報")
            })
            Section(content: {
                Text("アプリへの要望や、バグの発見などがあればApp Storeのレビューにて行っていただけると対応可能です。")
            }, header: {
                Text("報告")
            })
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
