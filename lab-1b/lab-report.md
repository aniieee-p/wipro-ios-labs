# Lab 1B – Access Control and Encapsulation

## Access Modifiers Used

### private
The `balance` property in `BankAccount` is `private`. It can only be read or changed inside the class itself. This stops any outside code from directly setting the balance to an invalid value.

### fileprivate
The `filePrivateMessage` property in `AccessControlDemo` is `fileprivate`. It is accessible from anywhere inside `AccessControlDemo.swift`, including the top-level `demonstrateFilePrivateAccess()` function defined in the same file.

### internal
The `internalMessage` property is `internal`. This is the default access level in Swift. It is accessible from other files within the same module, as shown by reading it from `main.swift`.

### public
The `BankAccount` class, its initializer, `deposit()`, `withdraw()`, `accountHolder`, and `currentBalance` are all `public`. These are the operations that callers outside the module are allowed to use. The `currentBalance` property is read-only — it uses a `private` stored property with a `public` computed getter, so callers can check the balance but cannot change it directly.

## Conclusion

Access control protects the account balance from invalid changes. Only `deposit()` and `withdraw()` can modify it, and both methods check that the amount is valid before updating the balance.
