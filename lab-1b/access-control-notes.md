
# Lab 1B – Access Control and Encapsulation

## 1. Private
- The account balance is declared as `private`.
- It cannot be accessed directly outside the BankAccount class.
- This protects the balance from unauthorized modifications.

## 2. Fileprivate
- The `filePrivateMessage` property is declared as `fileprivate`.
- It can be accessed anywhere within `AccessControlDemo.swift`.
- The function `demonstrateFilePrivateAccess()` demonstrates this access.

## 3. Internal
- The `internalMessage` property is declared as `internal`.
- It is accessible from other files within the same module.
- It is demonstrated by accessing it from `main.swift`.
- Internal is the default access level in Swift.

## 4. Public
- The `BankAccount` class, initializer, deposit(), withdraw(), accountHolder, and currentBalance are public.
- Public members allow callers to use the required account operations.
- The currentBalance property is read-only, so callers cannot directly change the balance.

## Conclusion

Access control protects sensitive account data and exposes only necessary operations. The private balance and controlled deposit and withdrawal methods demonstrate encapsulation.
