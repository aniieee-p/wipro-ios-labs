import Foundation

public struct GradeItem: Equatable, Sendable {
    public let name: String
    public let earnedPoints: Double
    public let possiblePoints: Double

    public init(name: String, earnedPoints: Double, possiblePoints: Double) {
        self.name = name
        self.earnedPoints = earnedPoints
        self.possiblePoints = possiblePoints
    }
}

public enum LetterGrade: String, CaseIterable, Equatable, Sendable {
    case a = "A"
    case b = "B"
    case c = "C"
    case d = "D"
    case f = "F"

    public static func forPercentage(_ percentage: Double) -> Self {
        switch percentage {
        case 90...100: .a
        case 80..<90: .b
        case 70..<80: .c
        case 60..<70: .d
        default: .f
        }
    }
}

public struct GradeResult: Equatable, Sendable {
    public let percentage: Double
    public let letterGrade: LetterGrade
}

public enum GradeCalculationError: Error, Equatable {
    case noGrades
    case nonFiniteScore(item: String)
    case nonFiniteTotal
    case nonPositivePossiblePoints(item: String)
    case negativeEarnedPoints(item: String)
    case earnedExceedsPossible(item: String)
}

public enum GradeCalculator {
    public static func calculate(_ items: [GradeItem]) throws -> GradeResult {
        guard !items.isEmpty else {
            throw GradeCalculationError.noGrades
        }

        for item in items {
            guard item.earnedPoints.isFinite, item.possiblePoints.isFinite else {
                throw GradeCalculationError.nonFiniteScore(item: item.name)
            }
            guard item.possiblePoints > 0 else {
                throw GradeCalculationError.nonPositivePossiblePoints(item: item.name)
            }
            guard item.earnedPoints >= 0 else {
                throw GradeCalculationError.negativeEarnedPoints(item: item.name)
            }
            guard item.earnedPoints <= item.possiblePoints else {
                throw GradeCalculationError.earnedExceedsPossible(item: item.name)
            }
        }

        let earned = items.reduce(0) { $0 + $1.earnedPoints }
        let possible = items.reduce(0) { $0 + $1.possiblePoints }
        guard earned.isFinite, possible.isFinite else {
            throw GradeCalculationError.nonFiniteTotal
        }
        let percentage = earned / possible * 100

        return GradeResult(
            percentage: percentage,
            letterGrade: LetterGrade.forPercentage(percentage)
        )
    }
}
