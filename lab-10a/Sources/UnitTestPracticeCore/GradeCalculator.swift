import Foundation

public struct GradeItem: Equatable {
    public let name: String
    public let earnedPoints: Double
    public let possiblePoints: Double

    public init(name: String, earnedPoints: Double, possiblePoints: Double) {
        self.name = name
        self.earnedPoints = earnedPoints
        self.possiblePoints = possiblePoints
    }
}

public enum LetterGrade: String, CaseIterable, Equatable {
    case a = "A"
    case b = "B"
    case c = "C"
    case d = "D"
    case f = "F"

    public static func forPercentage(_ percentage: Double) -> Self {
        switch percentage {
        case 90...100: return .a
        case 80..<90: return .b
        case 70..<80: return .c
        case 60..<70: return .d
        default: return .f
        }
    }
}

public struct GradeResult: Equatable {
    public let percentage: Double
    public let letterGrade: LetterGrade
}

public enum GradeCalculationError: Error, Equatable {
    case noGrades
    case invalidScore(item: String)
}

public enum GradeCalculator {
    public static func calculate(_ items: [GradeItem]) throws -> GradeResult {
        if items.isEmpty {
            throw GradeCalculationError.noGrades
        }

        var totalEarned = 0.0
        var totalPossible = 0.0

        for item in items {
            if item.possiblePoints <= 0 || item.earnedPoints < 0 || item.earnedPoints > item.possiblePoints {
                throw GradeCalculationError.invalidScore(item: item.name)
            }
            totalEarned += item.earnedPoints
            totalPossible += item.possiblePoints
        }

        let percentage = (totalEarned / totalPossible) * 100
        return GradeResult(percentage: percentage, letterGrade: LetterGrade.forPercentage(percentage))
    }
}
