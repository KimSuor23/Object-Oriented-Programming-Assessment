🐾 Species Management Web App
A Java-based web application built for BIT235 Object Oriented Programming (Melbourne Polytechnic). This system lets admins manage species and categories securely, while the public can explore species data with no login required.

🚀 Features
🛡️ Admin Console
- Secure login for admin access (MD5 password encryption)

- Add, edit, delete, and hide species

- Add, edit, and delete categories

- Hidden species management (toggle public/private)

- All management via streamlined admin interface

🌏 Public Portal
- Browse all species (public view)

- See recent species on the homepage

- View species details by category

- Keyword search for species

🛠️ Technologies Used
- Backend: Java (Servlets, JSP, JSTL, Java Beans)

- Framework: MVC pattern

- Database: MySQL

- Frontend: JSP, JSTL, HTML, CSS

📝 How to Run
1. Clone or Download the Project

2. Set up the MySQL Database

- Import the provided SQL script (if available) or create required tables for species, categories, and users

3. Configure Database Connection

- Update DB credentials in the project’s config file (usually in a properties or servlet class)

4. Build and Deploy

- Deploy the .war or project folder to Apache Tomcat or compatible Java web server

4. Access the Application

- Open http://localhost:8080/YourProjectName/ in your browser

📂 Project Structure
- /src – Java source files (Servlets, Beans)

- /web – JSP pages, static files, web.xml

- /sql – SQL scripts (if provided)

🧪 Sample Admin Login
- Username: admin

- Password: (set in DB, MD5 hashed)

👤 Author
Kim Sour Liv
BIT235 Object Oriented Programming
Melbourne Polytechnic
