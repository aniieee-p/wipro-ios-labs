\# Lab 2D: Error Handling



\## R1: ValidationError Enum



Created a `ValidationError` enum conforming to Swift's `Error` protocol with three cases:



\- `emptyName`

\- `invalidMark`

\- `invalidID`



\## R2: Throwing Student Registration



Implemented `registerStudent(id:name:mark:)` using `throws`.



The function validates the student name, mark (0–100), and positive student ID. It throws the appropriate error when validation fails.



\## R3: do/catch Error Handling



Used `do/catch` to handle registration errors safely. Each validation error displays a specific, user-friendly message.



\## R4: Comparison of Error Handling Approaches



| Approach | Behaviour | Suitable use |

|---|---|---|

| `throws` | Propagates a specific error to the caller | Registration with multiple validation failures |

| Optional (`Int?`) | Returns a value or `nil` | Simple validation when error details are unnecessary |

| `Result` | Returns `.success` or `.failure` | Operations where success and failure are represented as values |



Implemented both optional and Result-based mark validation.



\## R5: Safe Handling of Invalid Input



Tested empty names, invalid marks, and invalid IDs. Expected errors are caught and handled without crashing the program.



\## Extension: Simulated Network Response



Demonstrated a simulated network response using `Result<String, ValidationError>` and handled both success and failure cases.



\## Test Cases



| Case | Input | Expected result |

|---|---|---|

| Valid registration | ID 1, Anisha, 90 | Success |

| Empty name | Blank name | `emptyName` |

| Invalid mark | 120 | `invalidMark` |

| Invalid ID | 0 | `invalidID` |

| Optional valid mark | 85 | Value 85 |

| Optional invalid mark | 150 | `nil` |

| Result valid mark | 95 | `.success(95)` |

| Result invalid mark | -5 | `.failure(.invalidMark)` |



\## Conclusion



This lab demonstrates Swift error handling using custom errors, throwing functions, `do/catch`, optionals, and `Result`. Expected invalid inputs are handled safely without terminating the program.



