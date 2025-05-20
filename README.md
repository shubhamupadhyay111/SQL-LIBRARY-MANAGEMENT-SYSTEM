# 📚 Library Management SQL Project

This project contains a collection of SQL queries designed to perform various **CRUD operations**, **data analysis**, and **report generation** on a fictional Library Management System. It includes operations such as inserting book records, analyzing issued books, managing members and employees, and generating summary reports using SQL.

---

## 📂 Project Structure

The script is divided into several key sections:

### 1. 🔄 CRUD Operations

* **Create**: Add new book records to the library.
* **Update**: Modify member details.
* **Delete**: Remove issued book records.
* **Retrieve**:

  * All books issued by a specific employee.
  * Members who have issued more than one book.

### 2. 📊 CTAS (Create Table As Select)

* Generate summary tables:

  * `book_counts`: Contains each book and the number of times it was issued.
  * `book_price_above_7USD`: Lists all books with a rental price greater than \$7.

### 3. 📈 Data Analysis & Insights

* Fetch books from a specific category (e.g., Fiction).
* Calculate total rental income by book category.
* Identify members who registered in the last 10 days.
* List employees along with their branch and manager details.
* Retrieve the list of books that have not been returned.

### 4. ⚠️ Advanced Queries

* Identify members with overdue books (assuming a 60-day return period).

  * Includes member ID, name, book title, issue date, and number of overdue days.

---

## 🛠 Technologies Used

* **SQL (PostgreSQL syntax)**
* Ideal for use with PostgreSQL or other relational databases with minor modifications.

---

## 📁 File

* `Project task.sql` – Contains all SQL queries.

---

## 📝 Notes

* Ensure tables like `books`, `members`, `employees`, `issue_status`, `return_status`, and `branch` exist before executing the script.
* Table `memebers` appears to be a typo; it should likely be `members`.

---

## 📬 Contributions

Feel free to fork this repo, suggest improvements, or fix issues via Pull Requests!
