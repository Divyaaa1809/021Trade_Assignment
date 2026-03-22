# Flutter Watchlist Assignment (021 Trade)

**Developed by:** Divya Patil

## Overview

This project implements a stock watchlist similar to the 021 Trade app.
The main focus is **reordering (swapping) stocks using BLoC architecture** with **persistent storage using Hive**.


## Features

* Display stock watchlist (name, exchange, price, change)
* Drag & drop reorder (ReorderableListView)
* Delete stock from list
* Persistent storage using Hive (data remains after restart)
* Price formatting using `intl`
* Error handling with SnackBar

---

##  Architecture (BLoC)

* **Event → State → UI**
* Clean separation of UI and business logic

### Events:

* LoadStocksEvent
* ReorderStockEvent
* DeleteStockEvent

### State:

* List of stocks
* Error message (optional)

---

## Reorder Logic

* Copy list from state
* Remove item from old index
* Adjust new index
* Insert item
* Emit updated state

---

## Persistence (Hive)

* Used Hive for local storage
* Data stored in a box (`stockBox`)
* Fix applied for:

  * HiveObject key conflict
  * Reordering using fresh instances
* Ensures **data consistency + no crashes**

---

## Project Structure

```id="vps8t7"
lib/
 ┣ bloc/
 ┃ ┣ stock_bloc.dart
 ┃ ┣ stock_event.dart
 ┃ ┗ stock_state.dart
 ┣ models/
 ┃ ┣ stock.dart
 ┃ ┗ stock.g.dart
 ┣ ui/
 ┃ ┣ watchlist_screen.dart
 ┃ ┗ edit_watchlist_screen.dart
 ┣ utils/
 ┃ ┣ constant.dart
 ┃ ┣ formatter.dart
 ┃ ┗ logger.dart
 ┗ main.dart
```

---

## UI/UX

* Clean and minimal design
* Color-coded price change (green/red)
* Smooth drag interaction
* Responsive layout

---

## Code Quality

* Modular structure
* Reusable utilities
* Immutable state updates
* Type-safe Dart code
* Proper error handling

---

## Challenges & Fixes

* Reorder index issues → handled index adjustment
* Hive key conflict → fixed by deleting all keys of box
* Duplicate SnackBar → fixed using hiding Current SnackBar (hideCurrentSnackBar)

---

## Tech Stack

* Flutter **3.35.2**
* Dart
* flutter_bloc
* Hive
* intl
* logging

---

## ⚙️ Environment

* Java version: **17**
* Flutter version: **3.35.2**

---

## Conclusion

This project demonstrates:

* Proper BLoC implementation
* Clean architecture
* Real-world feature handling (reorder + persistence)

---

## Thank You

Looking forward to your feedback!
