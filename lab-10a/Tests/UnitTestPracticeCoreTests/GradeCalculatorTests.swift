import XCTest
@testable import UnitTestPracticeCore

final class GradeCalculatorTests: XCTestCase {
    func testCalculatesWeightedPercentageAcrossAssignments() throws {
        let result = try GradeCalculator.calculate([
            GradeItem(name: "Quiz", earnedPoints: 9, possiblePoints: 10),
            GradeItem(name: "Project", earnedPoints: 70, possiblePoints: 90)
        ])

        XCTAssertEqual(result.percentage, 79, accuracy: 0.0001)
        XCTAssertEqual(result.letterGrade, .c)
    }

    func testPerfectScoreReceivesA() throws {
        let result = try GradeCalculator.calculate([
            GradeItem(name: "Final", earnedPoints: 100, possiblePoints: 100)
        ])

        XCTAssertEqual(result.percentage, 100, accuracy: 0.0001)
        XCTAssertEqual(result.letterGrade, .a)
    }

    func testZeroScoreReceivesF() throws {
        let result = try GradeCalculator.calculate([
            GradeItem(name: "Final", earnedPoints: 0, possiblePoints: 100)
        ])

        XCTAssertEqual(result.percentage, 0, accuracy: 0.0001)
        XCTAssertEqual(result.letterGrade, .f)
    }

    func testLetterGradeBoundariesUseInclusiveLowerBound() {
        XCTAssertEqual(LetterGrade.forPercentage(90), .a)
        XCTAssertEqual(LetterGrade.forPercentage(89.99), .b)
        XCTAssertEqual(LetterGrade.forPercentage(80), .b)
        XCTAssertEqual(LetterGrade.forPercentage(70), .c)
        XCTAssertEqual(LetterGrade.forPercentage(60), .d)
        XCTAssertEqual(LetterGrade.forPercentage(59.99), .f)
    }

    func testRejectsEmptyGradeList() {
        XCTAssertThrowsError(try GradeCalculator.calculate([])) { error in
            XCTAssertEqual(error as? GradeCalculationError, .noGrades)
        }
    }

    func testRejectsZeroPossiblePoints() {
        XCTAssertThrowsError(
            try GradeCalculator.calculate([
                GradeItem(name: "Quiz", earnedPoints: 0, possiblePoints: 0)
            ])
        ) { error in
            XCTAssertEqual(error as? GradeCalculationError, .invalidScore(item: "Quiz"))
        }
    }

    func testRejectsEarnedPointsAboveMaximum() {
        XCTAssertThrowsError(
            try GradeCalculator.calculate([
                GradeItem(name: "Quiz", earnedPoints: 11, possiblePoints: 10)
            ])
        ) { error in
            XCTAssertEqual(error as? GradeCalculationError, .invalidScore(item: "Quiz"))
        }
    }

    func testRejectsNegativeEarnedPoints() {
        XCTAssertThrowsError(
            try GradeCalculator.calculate([
                GradeItem(name: "Quiz", earnedPoints: -1, possiblePoints: 10)
            ])
        ) { error in
            XCTAssertEqual(error as? GradeCalculationError, .invalidScore(item: "Quiz"))
        }
    }
}
