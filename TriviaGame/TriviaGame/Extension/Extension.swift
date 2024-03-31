import Foundation
import SwiftUI

extension Categories {
    
    var icon: String {
        switch self {
            
        case .GK:
            return "text.book.closed.fill"
        case .Books:
            return "book.fill"
        case .Film:
            return "film.fill"
        case .Music:
            return "music.note.list"
        case .Musical:
            return "music.mic"
        case .Television:
            return "tv.fill"
        case .VideoGames:
            return "gamecontroller.fill"
        case .BoardGames:
            return "gamecontroller"
        case .Nature:
            return "cloud.sun.rain.fill"
        case .Computers:
            return "desktopcomputer"
        case .Maths:
            return "divide.circle"
        case .Mythology:
            return "questionmark.diamond"
        case .Sports:
            return "sportscourt.fill"
        case .Geography:
            return "map.fill"
        case .History:
            return "book.circle"
        case .Politics:
            return "waveform.path"
        case .Art:
            return "paintbrush.fill"
        case .Celebrities:
            return "person.fill"
        case .Animals:
            return "tortoise.fill"
        case .Vehicles:
            return "car.fill"
        case .Comics:
            return "book"
        case .Gadgets:
            return "hourglass.bottomhalf.fill"
        case .Manga:
            return "book"
        case .Cartoon:
            return "tv.fill"
        }
    }
}

extension Color {
    
    static subscript(name: String) -> Color {
        switch name {
        case "green":
            return Color.green
        case "teal":
            return Color.teal
        case "accent":
            return Color.accentColor
        case "pink":
            return Color.pink
        case "mint":
            return Color.mint
        case "purple":
            return Color.purple
        case "orange":
            return Color.orange
        case "brown":
            return Color.brown
        case "indigo":
            return Color.indigo
        case "cyan":
            return Color.cyan
        default:
            return Color.accentColor
        }
    }
    
    static var random: Color {
        let colors = ["green", "teal", "accent", "pink", "mint", "purple", "orange", "brown", "indigo", "cyan"]
        if let random = colors.randomElement() {
            return Color[random]
        }
        return Color["accent"]
    }
}

extension Text {
    func boldTitle() -> some View {
        self.font(.title)
            .fontWeight(.heavy)
            .foregroundColor(.accentColor)
    }
}

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
