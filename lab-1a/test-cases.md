
# Lab 1A – Test Cases

## Boundary Value and Validation Tests

The following test cases verify subject mark validation, passing criteria, and attendance validation.

| Test Case | Input | Expected Output |
|---|---|---|
| TC01 – Minimum mark | Subject mark: 0 | Valid mark |
| TC02 – Maximum mark | Subject mark: 100 | Valid mark |
| TC03 – Failing mark | Subject mark: 30 | Valid mark, but FAIL |
| TC04 – Invalid high mark | Subject mark: 105 | Invalid mark |
| TC05 – Invalid attendance | Attendance: 105% | Invalid attendance |
| TC06 – Minimum attendance | Attendance: 0% | Valid attendance |
| TC07 – Maximum attendance | Attendance: 100% | Valid attendance |
| TC08 – Negative mark | Subject mark: -5 | Invalid mark |

## Normal Student Result

| Input | Expected Output |
|---|---|
| Marks: 85, 78, 90, 82, 88 | Total: 423/500 |
| Attendance: 92.5% | Valid attendance |
| All subject marks are at least 35 | PASS |
| Total: 423, Maximum: 500 | Average: 84.6 |
| Percentage: 84.6% | Grade: A |

## Conclusion

The test cases cover minimum and maximum marks, failing marks, invalid marks, and attendance boundary values. The normal student record also verifies the academic calculations and grading logic.