CREATE DATABASE techflow;
use techflow
--CREATE USER 'apt_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'wlQ7cgP1oVf9JgXRR9TW';
--GRANT SELECT ON techflow.* TO 'apt_user'@'localhost';
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS product_categories;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS employee_performance;
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    budget DECIMAL(12, 2),
    created_at DATE
);
INSERT INTO departments VALUES
(1, 'Sales', 500000.00, '2020-01-15'),
(2, 'Engineering', 1200000.00, '2020-01-15'),
(3, 'Marketing', 350000.00, '2020-03-01'),
(4, 'Customer Support', 250000.00, '2020-06-15'),
(5, 'Product', 450000.00, '2021-01-01');
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department_id INT,
    manager_id INT,
    hire_date DATE,
    salary DECIMAL(10, 2),
    is_active BIT DEFAULT 1,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);
INSERT INTO employees VALUES
(1, 'Sarah', 'Chen', 'sarah.chen@techflow.com', 1, NULL, '2020-01-15', 150000.00, 1),
(2, 'Michael', 'Rodriguez', 'michael.r@techflow.com', 1, 1, '2020-03-20', 85000.00, 1),
(3, 'Emily', 'Johnson', 'emily.j@techflow.com', 1, 1, '2020-06-01', 82000.00, 1),
(4, 'David', 'Kim', 'david.kim@techflow.com', 1, 1, '2021-02-15', 78000.00, 1),
(5, 'Jessica', 'Williams', 'jessica.w@techflow.com', 2, NULL, '2020-01-15', 180000.00, 1),
(6, 'Ryan', 'Taylor', 'ryan.t@techflow.com', 2, 5, '2020-04-10', 125000.00, 1),
(7, 'Amanda', 'Brown', 'amanda.b@techflow.com', 2, 5, '2020-08-22', 115000.00, 1),
(8, 'Chris', 'Martinez', 'chris.m@techflow.com', 2, 5, '2021-01-05', 105000.00, 1),
(9, 'Lisa', 'Anderson', 'lisa.a@techflow.com', 2, 6, '2021-06-15', 95000.00, 1),
(10, 'James', 'Thompson', 'james.t@techflow.com', 3, NULL, '2020-03-01', 130000.00, 1),
(11, 'Maria', 'Garcia', 'maria.g@techflow.com', 3, 10, '2020-09-14', 75000.00, 1),
(12, 'Kevin', 'Lee', 'kevin.l@techflow.com', 3, 10, '2021-04-01', 72000.00, 1),
(13, 'Rachel', 'Clark', 'rachel.c@techflow.com', 4, NULL, '2020-06-15', 95000.00, 1),
(14, 'Thomas', 'Wright', 'thomas.w@techflow.com', 4, 13, '2020-11-01', 55000.00, 1),
(15, 'Jennifer', 'Hall', 'jennifer.h@techflow.com', 4, 13, '2021-03-15', 52000.00, 1),
(16, 'Daniel', 'Young', 'daniel.y@techflow.com', 4, 13, '2021-08-01', 50000.00, 0),
(17, 'Michelle', 'King', 'michelle.k@techflow.com', 5, NULL, '2021-01-01', 160000.00, 1),
(18, 'Andrew', 'Scott', 'andrew.s@techflow.com', 5, 17, '2021-05-15', 110000.00, 1),
(19, 'Stephanie', 'Green', 'stephanie.g@techflow.com', 5, 17, '2022-01-10', 100000.00, 1),
(20, 'Robert', 'Adams', 'robert.a@techflow.com', 1, 1, '2022-03-01', 75000.00, 1);
CREATE TABLE employee_performance (
    performance_id INT PRIMARY KEY,
    employee_id INT,
    review_quarter VARCHAR(10),
    review_year INT,
    performance_score DECIMAL(3, 2),
    deals_closed INT,
    revenue_generated DECIMAL(12, 2),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
INSERT INTO employee_performance VALUES
(1, 2, 'Q1', 2024, 4.20, 12, 145000.00),
(2, 2, 'Q2', 2024, 4.50, 15, 178000.00),
(3, 2, 'Q3', 2024, 4.10, 11, 132000.00),
(4, 3, 'Q1', 2024, 3.80, 9, 98000.00),
(5, 3, 'Q2', 2024, 4.00, 10, 115000.00),
(6, 3, 'Q3', 2024, 4.30, 14, 156000.00),
(7, 4, 'Q1', 2024, 3.50, 7, 72000.00),
(8, 4, 'Q2', 2024, 3.90, 9, 95000.00),
(9, 4, 'Q3', 2024, 4.20, 12, 140000.00),
(10, 20, 'Q1', 2024, 4.00, 10, 110000.00),
(11, 20, 'Q2', 2024, 4.40, 13, 155000.00),
(12, 20, 'Q3', 2024, 4.60, 16, 195000.00);
CREATE TABLE product_categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    parent_category_id INT,
    FOREIGN KEY (parent_category_id) REFERENCES product_categories(category_id)
);
INSERT INTO product_categories VALUES
(1, 'Software', NULL),
(2, 'Business Tools', 1),
(3, 'Developer Tools', 1),
(4, 'Security', 1),
(5, 'CRM', 2),
(6, 'Project Management', 2),
(7, 'IDE & Editors', 3),
(8, 'CI/CD', 3),
(9, 'Antivirus', 4),
(10, 'VPN', 4);
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(200) NOT NULL,
    category_id INT,
    base_price DECIMAL(10, 2),
    subscription_type VARCHAR(20),
    launch_date DATE,
    is_active BIT DEFAULT 1,
    FOREIGN KEY (category_id) REFERENCES product_categories(category_id)
);
INSERT INTO products VALUES
(1, 'TechFlow CRM Basic', 5, 29.99, 'monthly', '2020-06-01', 1),
(2, 'TechFlow CRM Pro', 5, 79.99, 'monthly', '2020-06-01', 1),
(3, 'TechFlow CRM Enterprise', 5, 199.99, 'monthly', '2021-01-15', 1),
(4, 'TaskMaster', 6, 9.99, 'monthly', '2020-08-15', 1),
(5, 'TaskMaster Team', 6, 49.99, 'monthly', '2020-08-15', 1),
(6, 'CodeStudio Personal', 7, 14.99, 'monthly', '2020-03-01', 1),
(7, 'CodeStudio Professional', 7, 39.99, 'monthly', '2020-03-01', 1),
(8, 'CodeStudio Ultimate', 7, 99.99, 'monthly', '2021-06-01', 1),
(9, 'PipelineX Starter', 8, 49.99, 'monthly', '2021-03-01', 1),
(10, 'PipelineX Business', 8, 149.99, 'monthly', '2021-03-01', 1),
(11, 'SecureShield Home', 9, 4.99, 'monthly', '2020-09-01', 1),
(12, 'SecureShield Business', 9, 24.99, 'monthly', '2020-09-01', 1),
(13, 'PrivacyVPN', 10, 9.99, 'monthly', '2021-09-01', 1),
(14, 'PrivacyVPN Business', 10, 29.99, 'monthly', '2021-09-01', 1),
(15, 'TechFlow CRM Basic', 5, 299.99, 'annual', '2020-06-01', 1),
(16, 'TechFlow CRM Pro', 5, 799.99, 'annual', '2020-06-01', 1),
(17, 'CodeStudio Lifetime', 7, 499.99, 'lifetime', '2022-01-01', 1);
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    company_name VARCHAR(200),
    contact_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    country VARCHAR(50),
    industry VARCHAR(100),
    company_size VARCHAR(20),
    signup_date DATE,
    referred_by_customer_id INT,
    FOREIGN KEY (referred_by_customer_id) REFERENCES customers(customer_id)
);
INSERT INTO customers VALUES
(1, 'Acme Corp', 'John Smith', 'john@acme.com', 'USA', 'Manufacturing', 'enterprise', '2020-07-15', NULL),
(2, 'TechStart Inc', 'Alice Johnson', 'alice@techstart.io', 'USA', 'Technology', 'startup', '2020-08-01', NULL),
(3, 'Global Retail Ltd', 'Bob Wilson', 'bob@globalretail.com', 'UK', 'Retail', 'enterprise', '2020-09-10', 1),
(4, 'DataDriven Co', 'Carol White', 'carol@datadriven.com', 'Canada', 'Technology', 'medium', '2020-10-05', 2),
(5, 'FinanceHub', 'Dave Brown', 'dave@financehub.com', 'USA', 'Finance', 'medium', '2020-11-20', 1),
(6, 'CreativeMinds', 'Eva Green', 'eva@creativeminds.com', 'Germany', 'Media', 'small', '2021-01-15', NULL),
(7, 'HealthPlus', 'Frank Miller', 'frank@healthplus.com', 'USA', 'Healthcare', 'enterprise', '2021-02-28', 5),
(8, 'EduTech Solutions', 'Grace Lee', 'grace@edutech.com', 'Australia', 'Education', 'small', '2021-04-10', 4),
(9, 'CloudNine Services', 'Henry Taylor', 'henry@cloudnine.com', 'USA', 'Technology', 'startup', '2021-06-01', 2),
(10, 'Innovate Labs', 'Ivy Chen', 'ivy@innovatelabs.com', 'Singapore', 'Technology', 'medium', '2021-07-22', NULL),
(11, 'RetailMax', 'Jack Davis', 'jack@retailmax.com', 'USA', 'Retail', 'medium', '2021-09-05', 3),
(12, 'SecureBank', 'Karen Wilson', 'karen@securebank.com', 'UK', 'Finance', 'enterprise', '2021-10-18', NULL),
(13, 'GreenEnergy Co', 'Leo Martin', 'leo@greenenergy.com', 'Germany', 'Energy', 'medium', '2022-01-10', 6),
(14, 'LogiTrans', 'Mia Anderson', 'mia@logitrans.com', 'Canada', 'Logistics', 'small', '2022-03-25', NULL),
(15, 'SmartHome Inc', 'Nick Brown', 'nick@smarthome.com', 'USA', 'Technology', 'startup', '2022-05-14', 9),
(16, 'MediaStream', 'Olivia White', 'olivia@mediastream.com', 'USA', 'Media', 'small', '2022-07-30', NULL),
(17, 'BuildRight', 'Peter Clark', 'peter@buildright.com', 'Australia', 'Construction', 'medium', '2022-09-12', 8),
(18, 'FoodChain Global', 'Quinn Harris', 'quinn@foodchain.com', 'UK', 'Food & Beverage', 'enterprise', '2022-11-01', 3),
(19, 'TravelEase', 'Rosa Martinez', 'rosa@travelease.com', 'Spain', 'Travel', 'small', '2023-01-20', NULL),
(20, 'CyberDefend', 'Sam Johnson', 'sam@cyberdefend.com', 'USA', 'Security', 'startup', '2023-03-15', 12),
(21, 'AutoMotive Plus', 'Tina Lee', 'tina@automotive.com', 'Japan', 'Automotive', 'enterprise', '2023-05-28', NULL),
(22, 'AgriTech Farms', 'Uma Patel', 'uma@agritech.com', 'India', 'Agriculture', 'medium', '2023-07-10', NULL),
(23, 'LegalEagle', 'Victor Stone', 'victor@legaleagle.com', 'USA', 'Legal', 'small', '2023-09-05', 5),
(24, 'PharmaCare', 'Wendy Zhang', 'wendy@pharmacare.com', 'China', 'Healthcare', 'enterprise', '2023-10-22', 7),
(25, 'SpaceX Logistics', 'Xavier Moon', 'xavier@spacexlog.com', 'USA', 'Aerospace', 'medium', '2024-01-08', NULL);
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    employee_id INT,
    order_date DATE,
    status VARCHAR(20),
    payment_method VARCHAR(50),
    discount_percent DECIMAL(5, 2) DEFAULT 0,
    notes TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
INSERT INTO orders VALUES
(1001, 1, 2, '2024-01-05', 'completed', 'credit_card', 0, NULL),
(1002, 2, 3, '2024-01-08', 'completed', 'credit_card', 10.00, 'Startup discount'),
(1003, 3, 2, '2024-01-12', 'completed', 'bank_transfer', 5.00, NULL),
(1004, 4, 4, '2024-01-18', 'completed', 'credit_card', 0, NULL),
(1005, 5, 2, '2024-01-25', 'completed', 'credit_card', 0, NULL),
(1006, 1, 2, '2024-02-02', 'completed', 'credit_card', 0, 'Renewal'),
(1007, 6, 3, '2024-02-10', 'completed', 'paypal', 15.00, 'First purchase discount'),
(1008, 7, 20, '2024-02-15', 'completed', 'bank_transfer', 0, NULL),
(1009, 8, 4, '2024-02-22', 'cancelled', 'credit_card', 0, 'Customer cancelled'),
(1010, 9, 3, '2024-03-01', 'completed', 'credit_card', 10.00, NULL),
(1011, 10, 2, '2024-03-08', 'completed', 'credit_card', 0, NULL),
(1012, 11, 4, '2024-03-15', 'completed', 'paypal', 0, NULL),
(1013, 12, 20, '2024-03-22', 'completed', 'bank_transfer', 5.00, NULL),
(1014, 3, 2, '2024-03-28', 'completed', 'bank_transfer', 0, 'Additional licenses'),
(1015, 13, 3, '2024-04-05', 'completed', 'credit_card', 0, NULL),
(1016, 14, 4, '2024-04-12', 'completed', 'paypal', 20.00, 'Special promotion'),
(1017, 15, 20, '2024-04-18', 'completed', 'credit_card', 10.00, NULL),
(1018, 1, 2, '2024-04-25', 'completed', 'credit_card', 0, 'Upgrade'),
(1019, 16, 3, '2024-05-02', 'refunded', 'credit_card', 0, 'Product not suitable'),
(1020, 17, 4, '2024-05-10', 'completed', 'bank_transfer', 0, NULL),
(1021, 18, 20, '2024-05-18', 'completed', 'credit_card', 0, NULL),
(1022, 2, 3, '2024-05-25', 'completed', 'credit_card', 0, 'Expansion'),
(1023, 19, 2, '2024-06-01', 'completed', 'paypal', 15.00, NULL),
(1024, 20, 4, '2024-06-08', 'completed', 'credit_card', 0, NULL),
(1025, 21, 20, '2024-06-15', 'completed', 'bank_transfer', 10.00, NULL),
(1026, 5, 2, '2024-06-22', 'completed', 'credit_card', 0, 'Renewal'),
(1027, 22, 3, '2024-06-28', 'completed', 'credit_card', 0, NULL),
(1028, 23, 4, '2024-07-05', 'pending', 'bank_transfer', 5.00, 'Awaiting payment'),
(1029, 24, 20, '2024-07-12', 'completed', 'credit_card', 0, NULL),
(1030, 7, 2, '2024-07-18', 'completed', 'bank_transfer', 0, 'Additional modules'),
(1031, 25, 3, '2024-07-25', 'completed', 'credit_card', 15.00, 'New customer promo'),
(1032, 10, 4, '2024-08-01', 'completed', 'credit_card', 0, 'Renewal'),
(1033, 12, 20, '2024-08-08', 'completed', 'bank_transfer', 0, 'Expansion'),
(1034, 15, 2, '2024-08-15', 'completed', 'credit_card', 0, NULL),
(1035, 18, 3, '2024-08-22', 'completed', 'credit_card', 5.00, NULL),
(1036, 21, 4, '2024-08-28', 'cancelled', 'credit_card', 0, 'Duplicate order'),
(1037, 3, 20, '2024-09-05', 'completed', 'bank_transfer', 0, 'Annual renewal'),
(1038, 6, 2, '2024-09-12', 'completed', 'paypal', 10.00, NULL),
(1039, 9, 3, '2024-09-18', 'completed', 'credit_card', 0, NULL),
(1040, 11, 4, '2024-09-25', 'completed', 'credit_card', 0, 'Upgrade');
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10, 2),
    license_months INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO order_items VALUES
(1, 1001, 3, 50, 199.99, 12),
(2, 1001, 10, 10, 149.99, 12),
(3, 1002, 6, 5, 14.99, 12),
(4, 1002, 4, 5, 9.99, 12),
(5, 1003, 2, 100, 79.99, 12),
(6, 1003, 12, 100, 24.99, 12),
(7, 1004, 7, 15, 39.99, 12),
(8, 1005, 16, 25, 799.99, 12),
(9, 1006, 3, 50, 199.99, 12),
(10, 1007, 4, 10, 9.99, 6),
(11, 1007, 11, 10, 4.99, 6),
(12, 1008, 3, 200, 199.99, 12),
(13, 1008, 10, 50, 149.99, 12),
(14, 1008, 14, 200, 29.99, 12),
(15, 1010, 6, 8, 14.99, 12),
(16, 1010, 9, 3, 49.99, 12),
(17, 1011, 8, 20, 99.99, 12),
(18, 1012, 5, 15, 49.99, 12),
(19, 1013, 3, 150, 199.99, 12),
(20, 1013, 14, 150, 29.99, 12),
(21, 1014, 3, 25, 199.99, 12),
(22, 1015, 7, 12, 39.99, 12),
(23, 1015, 13, 12, 9.99, 12),
(24, 1016, 4, 8, 9.99, 6),
(25, 1017, 6, 3, 14.99, 12),
(26, 1017, 11, 3, 4.99, 12),
(27, 1018, 3, 75, 199.99, 12),
(28, 1020, 5, 20, 49.99, 12),
(29, 1020, 9, 5, 49.99, 12),
(30, 1021, 2, 300, 79.99, 12),
(31, 1021, 12, 300, 24.99, 12),
(32, 1022, 7, 10, 39.99, 12),
(33, 1022, 9, 5, 49.99, 12),
(34, 1023, 4, 5, 9.99, 6),
(35, 1023, 13, 5, 9.99, 6),
(36, 1024, 6, 2, 14.99, 12),
(37, 1024, 11, 5, 4.99, 12),
(38, 1025, 3, 500, 199.99, 12),
(39, 1025, 10, 100, 149.99, 12),
(40, 1026, 16, 25, 799.99, 12),
(41, 1027, 7, 8, 39.99, 12),
(42, 1028, 1, 10, 29.99, 12),
(43, 1029, 3, 400, 199.99, 12),
(44, 1029, 12, 400, 24.99, 12),
(45, 1030, 8, 50, 99.99, 12),
(46, 1030, 10, 20, 149.99, 12),
(47, 1031, 9, 10, 49.99, 12),
(48, 1032, 8, 20, 99.99, 12),
(49, 1033, 3, 200, 199.99, 12),
(50, 1033, 10, 50, 149.99, 12),
(51, 1034, 17, 3, 499.99, NULL),
(52, 1035, 2, 350, 79.99, 12),
(53, 1036, 3, 500, 199.99, 12),
(54, 1037, 16, 100, 799.99, 12),
(55, 1038, 5, 15, 49.99, 12),
(56, 1038, 13, 15, 9.99, 12),
(57, 1039, 7, 10, 39.99, 12),
(58, 1040, 8, 25, 99.99, 12);



--Expectation 1: Identifies which product categories generate the most revenue.
SELECT pc.category_name,  SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders o
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id
INNER JOIN product_categories pc
    ON p.category_id = pc.category_id
WHERE o.status = 'completed'
GROUP BY pc.category_name
ORDER BY total_revenue DESC;



--Expectation 2: Shows how referrals spread through the customer base and identifies multi-level referral relationships.
SELECT
    c.company_name AS customer_company,
    dr.company_name AS direct_referrer_company,
    orf.company_name AS original_referrer_company
FROM customers AS c
INNER JOIN customers AS dr
    ON c.referred_by_customer_id = dr.customer_id
INNER JOIN customers AS orf
    ON dr.referred_by_customer_id = orf.customer_id
ORDER BY
    original_referrer_company,
    direct_referrer_company,
    customer_company;



--Expectation 3: Measures manager effectiveness through team size, employee performance, and revenue generated.
SELECT
    m.employee_id,
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name,
    COUNT(DISTINCT e.employee_id) AS direct_reports,
    AVG(ep.performance_score) AS avg_performance_score,
    SUM(ep.revenue_generated) AS total_team_revenue
FROM employees AS m
INNER JOIN employees AS e
    ON m.employee_id = e.manager_id
INNER JOIN employee_performance AS ep
    ON e.employee_id = ep.employee_id
WHERE m.department_id = 1
    AND ep.review_year = 2024
GROUP BY
    m.employee_id,
    m.first_name,
    m.last_name
ORDER BY total_team_revenue DESC;


--Expectation 4: Tracks revenue trends throughout the year and ranks the best-performing months.
WITH MonthlyRevenue AS
(
    SELECT
        YEAR(o.order_date) AS order_year,
        MONTH(o.order_date) AS order_month,
        SUM(oi.quantity * oi.unit_price) AS monthly_revenue
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.status = 'completed'
      AND YEAR(o.order_date) = 2024
    GROUP BY
        YEAR(o.order_date),
        MONTH(o.order_date)
)

SELECT
    order_month,
    monthly_revenue,

    SUM(monthly_revenue) OVER (
        ORDER BY order_month
    ) AS running_total,

    RANK() OVER (
        ORDER BY monthly_revenue DESC
    ) AS revenue_rank

FROM MonthlyRevenue
ORDER BY order_month;

--Expectaion 5: Displays each product's complete category path within the product hierarchy.
WITH CategoryHierarchy AS
(
    SELECT
        category_id,
        parent_category_id,
        category_name,
        CAST(category_name AS VARCHAR(MAX)) AS category_path
    FROM product_categories
    WHERE parent_category_id IS NULL

    UNION ALL

    SELECT
        pc.category_id,
        pc.parent_category_id,
        pc.category_name,
        CAST(ch.category_path + ' > ' + pc.category_name AS VARCHAR(MAX))
    FROM product_categories pc
    INNER JOIN CategoryHierarchy ch
        ON pc.parent_category_id = ch.category_id
)

SELECT
    p.product_name,
    ch.category_path,
    p.base_price
FROM products p
INNER JOIN CategoryHierarchy ch
    ON p.category_id = ch.category_id
ORDER BY
    ch.category_path,
    p.product_name;

	
