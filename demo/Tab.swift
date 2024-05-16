import SwiftUI

struct TabItem: Identifiable{
    var id = UUID()
    var text: String
    var textEn: String
    var icon: String
    var tab: Tab
}

var tabItems = [
    TabItem(text: "Home",textEn: "Summary", icon: "house", tab: .home),
    TabItem(text: "Reservation", textEn: "Task", icon: "calendar.badge.clock", tab: .task)
]

enum Tab: String{
    var id: String { return self.rawValue }
    
    case home
    case task
    
    var localizedRawValue: String{
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

struct TabItemWidthKey: PreferenceKey{
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

