CREATE DATABASE IF NOT EXISTS procrm CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE procrm;

DROP TABLE IF EXISTS followups;
DROP TABLE IF EXISTS deals;
DROP TABLE IF EXISTS leads;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS users;

CREATE TABLE users(
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  email VARCHAR(190) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  role ENUM('admin','sales','support') DEFAULT 'sales',
  status ENUM('active','inactive') DEFAULT 'active',
  last_login DATETIME NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customers(
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  email VARCHAR(190),
  phone VARCHAR(50),
  company VARCHAR(150),
  status ENUM('active','inactive','vip') DEFAULT 'active',
  industry VARCHAR(100),
  address VARCHAR(255),
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE leads(
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  email VARCHAR(190),
  phone VARCHAR(50),
  company VARCHAR(150),
  source VARCHAR(80),
  status ENUM('new','contacted','qualified','proposal','converted','lost') DEFAULT 'new',
  estimated_value DECIMAL(12,2) DEFAULT 0,
  notes TEXT,
  owner_id INT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(owner_id) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE deals(
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(180) NOT NULL,
  customer_id INT NOT NULL,
  amount DECIMAL(12,2) DEFAULT 0,
  stage ENUM('prospecting','qualified','proposal','negotiation','won','lost') DEFAULT 'prospecting',
  expected_close DATE NULL,
  probability TINYINT UNSIGNED DEFAULT 20,
  notes TEXT,
  owner_id INT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY(customer_id) REFERENCES customers(id) ON DELETE CASCADE,
  FOREIGN KEY(owner_id) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE followups(
  id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  subject VARCHAR(180) NOT NULL,
  type ENUM('call','email','meeting','task') DEFAULT 'call',
  due_at DATETIME NOT NULL,
  status ENUM('pending','completed','cancelled') DEFAULT 'pending',
  completed_at DATETIME NULL,
  notes TEXT,
  owner_id INT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(customer_id) REFERENCES customers(id) ON DELETE CASCADE,
  FOREIGN KEY(owner_id) REFERENCES users(id) ON DELETE SET NULL
);

-- ===================== USERS =====================
INSERT INTO users(name,email,password,role,status) VALUES
('Admin User','admin@procrm.local','$2y$10$wYbPHeUVPhaWA0TNtJOwweze4eEH5mnNRlpbJz14J5Efi.yV5sSiK','admin','active'),
('Helen Tadesse','helen@procrm.local','$2y$10$wYbPHeUVPhaWA0TNtJOwweze4eEH5mnNRlpbJz14J5Efi.yV5sSiK','sales','active'),
('Yonas Kebede','yonas@procrm.local','$2y$10$wYbPHeUVPhaWA0TNtJOwweze4eEH5mnNRlpbJz14J5Efi.yV5sSiK','sales','active'),
('Sara Mohammed','sara@procrm.local','$2y$10$wYbPHeUVPhaWA0TNtJOwweze4eEH5mnNRlpbJz14J5Efi.yV5sSiK','support','active'),
('Dawit Alemu','dawit@procrm.local','$2y$10$wYbPHeUVPhaWA0TNtJOwweze4eEH5mnNRlpbJz14J5Efi.yV5sSiK','sales','active');

-- ===================== CUSTOMERS (25) =====================
INSERT INTO customers(name,email,phone,company,status,industry,address,notes) VALUES
('Abel Tesfaye','abel@brighttech.et','0911000001','Bright Tech','vip','Technology','Bole, Addis Ababa','Key VIP client - website & support'),
('Marta Ali','marta@greenretail.et','0911000002','Green Retail','active','Retail','Kazanchis, Addis Ababa','Monthly supply contracts'),
('Kidist Haile','kidist@nova.et','0911000003','Nova Solutions','active','Consulting','CMC, Addis Ababa',NULL),
('Samuel Girma','samuel@bluesky.et','0911000004','Blue Sky Media','vip','Media','Mexico, Addis Ababa','Long-term advertising partner'),
('Hanna Bekele','hanna@ethiogreen.et','0911000005','Ethio Green','active','Agriculture','Bahir Dar','Organic produce exporter'),
('Yared Mulugeta','yared@techhub.et','0911000006','Tech Hub Ethiopia','active','Technology','Piassa, Addis Ababa',NULL),
('Selamawit Tsegaye','selam@fashionet.et','0911000007','FashionET','active','Fashion','Merkato, Addis Ababa','Seasonal campaigns'),
('Biruk Assefa','biruk@logistics.et','0911000008','Fast Logistics','vip','Logistics','Akaki, Addis Ababa','Fleet management system'),
('Tigist Worku','tigist@healthplus.et','0911000009','HealthPlus Clinic','active','Healthcare','Saris, Addis Ababa',NULL),
('Elias Demeke','elias@construct.et','0911000010','Construct Co','active','Construction','Lebu, Addis Ababa','Building materials supplier'),
('Meron Fikadu','meron@eduworld.et','0911000011','EduWorld Academy','active','Education','Gerji, Addis Ababa','Student management system'),
('Getachew Lemma','getachew@agripro.et','0911000012','AgriPro','active','Agriculture','Hawassa','Irrigation equipment'),
('Rahel Solomon','rahel@beauty.et','0911000013','Beauty Queen','active','Beauty','Bole Atlas, Addis Ababa',NULL),
('Nahom Gizaw','nahom@fintech.et','0911000014','FinTech Solutions','vip','Finance','CMC Michael, Addis Ababa','Payment gateway client'),
('Betty Abraham','betty@travel.et','0911000015','Ethio Travel','active','Tourism','Kazanchis, Addis Ababa','Tour booking platform'),
('Daniel Mekonnen','daniel@solar.et','0911000016','Solar Energy ET','active','Energy','Mekelle','Solar panel installations'),
('Hiwot Desta','hiwot@foodhub.et','0911000017','FoodHub','active','Food & Beverage','Piassa, Addis Ababa',NULL),
('Amanuel Tekle','amanuel@security.et','0911000018','SecureNet','active','Security','Bole, Addis Ababa','CCTV & access control'),
('Liya Kebede','liya@design.et','0911000019','Creative Design Studio','active','Design','Mexico, Addis Ababa','Branding packages'),
('Fikru Hailu','fikru@transport.et','0911000020','City Transport','active','Transport','Autobis Tera, Addis Ababa',NULL),
('Saron Alemu','saron@pharmacy.et','0911000021','City Pharmacy','active','Healthcare','Saris, Addis Ababa','Inventory system needed'),
('Michael Tadesse','michael@realestate.et','0911000022','Prime Real Estate','vip','Real Estate','Bole, Addis Ababa','Property listing platform'),
('Bethel Yohannes','bethel@events.et','0911000023','Event Masters','active','Events','Kazanchis, Addis Ababa',NULL),
('Solomon Asfaw','solomon@mining.et','0911000024','Ethio Mining','active','Mining','Dire Dawa','Equipment tracking'),
('Aster Bekele','aster@textile.et','0911000025','Textile Pro','active','Manufacturing','Adama','Factory management system');

-- ===================== LEADS (30) =====================
INSERT INTO leads(name,email,phone,company,source,status,estimated_value,notes,owner_id) VALUES
('Daniel Bekele','daniel@novasol.et','0912000001','Nova Solutions','Website','qualified',4500,'Interested in full CRM package',1),
('Sara Kassa','sara@bluestudio.et','0912000002','Blue Studio','Referral','new',2500,NULL,2),
('Yonas Hailu','yonas@startup.et','0912000003','Startup Hub','LinkedIn','contacted',8000,'Looking for custom development',2),
('Mekdes Alemu','mekdes@retailplus.et','0912000004','RetailPlus','Website','proposal',12000,'POS + inventory system',3),
('Tewodros Girma','tewodros@logi.et','0912000005','LogiExpress','Cold Call','qualified',6500,NULL,1),
('Hanna Tsegaye','hanna@edu.et','0912000006','Smart Edu','Referral','new',3200,'Student portal',4),
('Abebe Mulatu','abebe@farm.et','0912000007','Green Farm','Exhibition','contacted',15000,'Farm management software',5),
('Rahel Desta','rahel@clinic.et','0912000008','City Clinic','Website','qualified',7800,'Appointment system',2),
('Kidus Solomon','kidus@media.et','0912000009','Media House','LinkedIn','proposal',9500,NULL,3),
('Selam Workneh','selam@hotel.et','0912000010','Grand Hotel','Referral','new',11000,'Booking engine',1),
('Biruk Tadesse','biruk@shop.et','0912000011','Online Shop ET','Website','lost',4200,'Chose competitor',2),
('Tigist Fikru','tigist@law.et','0912000012','Law Firm Partners','Cold Call','contacted',5600,NULL,5),
('Elias Haile','elias@construction.et','0912000013','BuildRight','Exhibition','qualified',18500,'Project management tool',3),
('Meron Assefa','meron@ngo.et','0912000014','Hope NGO','Referral','new',2800,'Donor management',4),
('Getachew Bekele','getachew@bank.et','0912000015','Community Bank','Website','proposal',25000,'Core banking integration',1),
('Hiwot Girma','hiwot@cafe.et','0912000016','Coffee House','Walk-in','new',1500,NULL,2),
('Nahom Lemma','nahom@insurance.et','0912000017','Safe Insurance','LinkedIn','qualified',14000,'Claims system',3),
('Betty Mulugeta','betty@travelplus.et','0912000018','Travel Plus','Website','contacted',6700,NULL,5),
('Dawit Solomon','dawit@energy.et','0912000019','Green Energy','Referral','proposal',22000,'Monitoring dashboard',1),
('Liya Tadesse','liya@fashion.et','0912000020','Style House','Instagram','new',3800,'E-commerce site',2),
('Amanuel Haile','amanuel@securityplus.et','0912000021','SecurePlus','Website','qualified',8900,NULL,3),
('Saron Kebede','saron@school.et','0912000022','Future School','Referral','contacted',7200,'LMS platform',4),
('Michael Worku','michael@real.et','0912000023','City Homes','Cold Call','new',16000,'Property CRM',5),
('Bethel Alemu','bethel@eventpro.et','0912000024','EventPro','Website','qualified',5400,NULL,2),
('Solomon Desta','solomon@miningpro.et','0912000025','Mining Pro','Exhibition','proposal',31000,'Asset tracking',1),
('Aster Girma','aster@textilepro.et','0912000026','Textile Masters','LinkedIn','new',9800,NULL,3),
('Yared Bekele','yared@logisticspro.et','0912000027','Logistics Pro','Referral','contacted',12500,'Fleet tracking',5),
('Hanna Solomon','hanna@pharmacy.et','0912000028','MediCare Pharmacy','Website','qualified',4300,NULL,4),
('Fikru Tadesse','fikru@auto.et','0912000029','Auto Service','Walk-in','new',2900,'Workshop management',2),
('Selam Haile','selam@consult.et','0912000030','Biz Consult','LinkedIn','proposal',17500,'Full business suite',1);

-- ===================== DEALS (20) =====================
INSERT INTO deals(title,customer_id,amount,stage,expected_close,probability,notes,owner_id) VALUES
('Website Revamp',1,6500,'proposal','2026-10-15',60,'Phase 1 design completed',1),
('Support Contract',2,3200,'won','2026-09-10',100,'Annual support signed',2),
('CRM Implementation',3,12500,'negotiation','2026-10-30',70,'Waiting for final approval',1),
('Digital Marketing Package',4,8900,'qualified','2026-11-15',40,NULL,3),
('Inventory System',5,15600,'proposal','2026-10-20',55,'Demo scheduled',5),
('Custom ERP Module',8,28000,'negotiation','2026-12-01',65,'Complex requirements',1),
('Payment Gateway Integration',14,18500,'won','2026-09-05',100,'Successfully live',3),
('Tour Booking Platform',15,14200,'proposal','2026-11-10',50,NULL,2),
('Solar Monitoring Dashboard',16,22000,'qualified','2026-12-15',35,'Technical discussion ongoing',5),
('CCTV Management System',18,9800,'prospecting','2026-11-30',20,NULL,4),
('Branding + Website',19,7500,'won','2026-08-20',100,'Delivered and paid',2),
('Property Listing Platform',22,31000,'negotiation','2026-12-20',60,'Contract under review',1),
('Event Management App',23,6800,'proposal','2026-10-25',45,NULL,3),
('Fleet Tracking System',8,19500,'qualified','2026-11-05',40,'Pilot project agreed',5),
('Student Portal',11,11200,'won','2026-09-01',100,'Training completed',4),
('POS System Rollout',2,8700,'proposal','2026-10-18',55,NULL,2),
('Security Audit Package',18,5400,'prospecting','2026-12-01',15,NULL,4),
('Mobile App Development',1,24500,'negotiation','2026-11-28',70,'iOS + Android',1),
('Data Migration Project',14,9800,'won','2026-08-15',100,'Completed successfully',3),
('Annual Maintenance',3,4500,'qualified','2026-12-31',30,'Renewal discussion',5);

-- ===================== FOLLOWUPS (25) =====================
INSERT INTO followups(customer_id,subject,type,due_at,status,notes,owner_id) VALUES
(1,'Discuss proposal','call','2026-09-25 10:00:00','pending','Review scope and pricing',1),
(2,'Quarterly check-in','email','2026-09-28 14:00:00','pending','Send account update',2),
(3,'Contract review meeting','meeting','2026-09-26 11:00:00','pending','Prepare final quote',1),
(4,'Send marketing proposal','email','2026-09-27 09:30:00','pending',NULL,3),
(5,'Demo preparation','task','2026-09-29 16:00:00','pending','Prepare inventory demo',5),
(8,'Technical requirements call','call','2026-09-30 10:30:00','pending','Discuss ERP modules',1),
(14,'Post-implementation review','meeting','2026-10-02 14:00:00','pending','Gather feedback',3),
(15,'Booking platform walkthrough','meeting','2026-10-03 11:00:00','pending',NULL,2),
(16,'Technical discussion','call','2026-10-05 15:00:00','pending','Solar sensors integration',5),
(18,'Security needs assessment','call','2026-10-01 09:00:00','pending',NULL,4),
(19,'Upsell discussion','email','2026-10-04 10:00:00','pending','Offer maintenance package',2),
(22,'Contract finalization','meeting','2026-10-06 13:00:00','pending','Legal review pending',1),
(23,'Feature prioritization','call','2026-10-07 11:30:00','pending',NULL,3),
(1,'Mobile app mockup review','meeting','2026-10-08 15:00:00','pending','Show wireframes',1),
(2,'POS pilot feedback','call','2026-10-09 10:00:00','pending','Collect user feedback',2),
(11,'Training follow-up','email','2026-09-26 08:00:00','completed','Training went well',4),
(14,'Thank you note','email','2026-09-20 12:00:00','completed','Sent after go-live',3),
(3,'Initial discovery call','call','2026-09-15 10:00:00','completed',NULL,1),
(8,'Site visit','meeting','2026-09-18 14:00:00','completed','Visited warehouse',5),
(5,'Requirements gathering','meeting','2026-09-22 11:00:00','completed',NULL,5),
(4,'Send case study','email','2026-10-10 09:00:00','pending','Share similar client success',3),
(22,'Pricing negotiation','call','2026-10-11 16:00:00','pending','Discuss payment terms',1),
(15,'Content collection','task','2026-10-12 10:00:00','pending','Collect hotel photos & rooms',2),
(16,'Sensor compatibility check','task','2026-10-13 14:00:00','pending',NULL,5),
(1,'Final proposal send','email','2026-10-14 09:30:00','pending','Include mobile app option',1);
