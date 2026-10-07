# ProCRM Professional

> Sales CRM: customers, leads, deals and follow-ups

**Live demo:** https://procrm-professional.freedev.app

## Screenshots

![Login](docs/screenshots/login.png)
![Dashboard](docs/screenshots/dashboard.png)

## Features

- Authentication with hashed passwords and Admin / Sales / Support roles
- Dashboard with KPI cards, sales chart and recent deals
- Customers, leads, deals and follow-up scheduling
- Sales pipeline stages and win-rate reports
- CSRF protection on every form, PDO prepared statements

## Tech stack

PHP 8 · MySQL (PDO) · Bootstrap 5 · Chart.js

## Demo login (local install)

| Role | Email / user | Password |
|---|---|---|
| Admin | `admin@procrm.local` | `Admin123!` |

These are the default credentials of the seed data. The live demo's admin password is private.

## Run locally (XAMPP)

1. Copy this folder to `C:\xampp\htdocs\ProCRM_Professional`
2. Start **Apache** and **MySQL** in XAMPP
3. Open phpMyAdmin → **Import** → `database/procrm.sql`
4. Check the database settings in `config/database.php` (default: host `localhost`, user `root`, empty password)
5. Open `http://localhost/ProCRM_Professional/`

### Deploying to shared hosting

Create an empty database in your hosting panel, delete the `CREATE DATABASE` / `USE` / `DROP DATABASE` lines at the top of `database/procrm.sql`, import it, then put the host's database name, user and password in `config/database.php`.

## Notes

Portfolio / demo project. Before real production use add HTTPS, rate limiting, audit logs, backups and environment-based configuration.

## Author

Built by [natnaelameha213](https://github.com/natnaelameha213).
