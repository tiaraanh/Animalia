//
//  SettingView.swift
//  Animalia
//
//  Created by Tiara H on 16/06/24.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    
    @AppStorage("hideName") var hideName: Bool = false
    @AppStorage("hideType") var hideType: Bool = false
    
    var body: some View {
        Form {
            Toggle("Hide Name", isOn: $hideName)
            Toggle("Hide Type", isOn: $hideType)
        }
    }
}
