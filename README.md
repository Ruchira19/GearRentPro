# GearRentPro

GearRentPro is a Java-based desktop application for managing a professional gear rental business. It supports multi-branch operations, customer memberships, equipment reservations, rentals, returns, overdue management, and reporting. The system is designed for Admins, Branch Managers, and Staff roles.

## Project Description
- **Multi-branch support**: Manage multiple branches, each with its own inventory and staff.
- **Membership system**: Customers can have different membership levels (Regular, Silver, Gold) with discounts.
- **Equipment management**: Track equipment by category, status, and branch.
- **Reservation & rental workflows**: Reserve, rent, return, and manage overdue equipment.
- **Role-based access**: Admin, Manager, and Staff roles with different permissions.

## How to Configure the Database
1. **Install MySQL** (if not already installed).
2. Open your MySQL client (Workbench, CLI, etc.).
3. Run the SQL script at `mySQL Script/SQL Script.sql` to create the database, tables, and insert sample data:
   ```sql
   SOURCE path/to/mySQL Script/SQL Script.sql;
   ```
   - This will create a database named `gearrent_pro` and populate it with sample data.
4. **Database connection settings** (see `DBConnection.java`):
   - Host: `localhost`
   - Port: `3306`
   - Database: `gearrent_pro`
   - Username: `root`
   - Password: `password`
   - Update these in `src/edu/ijse/gearrentpro/db/DBConnection.java` if your MySQL credentials differ.

## How to Run the Application
1. **Build the project** using your preferred Java IDE (NetBeans, IntelliJ, Eclipse) or compile with:
   ```sh
   javac -d build/classes src/edu/ijse/gearrentpro/Main.java
   java -cp build/classes edu.ijse.gearrentpro.Main
   ```
2. Ensure MySQL server is running and the database is set up.
3. The application will start with the login window.

## Default Login Credentials
Use these sample accounts to log in:

| Role           | Username      | Password   | Branch           |
|----------------|--------------|------------|------------------|
| Admin          | admin        | admin123   | Colombo Branch   |
| Branch Manager | manager_col  | pass123    | Colombo Branch   |
| Staff          | staff_kandy  | staff001   | Kandy Branch     |

- You can add more users via the database (`system_user` table).

---

For any issues, check your database connection, ensure the SQL script ran successfully, and verify your Java runtime is compatible (Java 8+ recommended).