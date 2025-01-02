# Bandle City Municipality and Urban Planning Database Schema

## Project Description

This project aims to develop a Municipality and Urban Planning system for Bandle City. It includes various features such as municipal management, citizen services, feedback and suggestions, and complaint management. The database schema is designed to support these features, utilizing MySQL for data storage and efficient management.

## Technologies

- Database: MySQL
- Framework: Laravel
- Language: SQL

------------------------------------------------------------

# Database Table Descriptions

## 1. General Purpose Tables

- **cache**: Stores key-value pairs with expiration times for caching.
- **cache_locks**: Manages cache locks to avoid data conflicts.
- **failed_jobs**: Tracks failed job attempts with error details and timestamps.
- **job_batches** and **jobs**: Handle queue systems and background job management.
- **migrations**: Manages and tracks database migrations.
- **password_reset_tokens**: Stores tokens for password reset processes.
- **sessions**: Handles user session management, including user IP, agent, and activity data.

------------------------------------------------------------

## 2. Main Functional Tables

- **categories**: Stores information about service categories.
- **users**: Manages system users, including admin rights and credentials.
- **achievements**: Tracks user achievements, such as campaign milestones.
- **admin_actions**: Logs actions taken by administrators within the system.
- **campaigns**: Manages fundraising campaigns with goals, progress, and donations.
- **campaign_categories**: Links campaigns with categories for easy classification.
- **campaign_tags**: Tags campaigns with relevant keywords.
- **campaign_updates**: Stores updates related to each campaign.
- **comments**: Manages comments made by users on campaigns.
- **donations**: Tracks user donations to campaigns, including payment method and status.
- **feedback**: Stores feedback from users on campaigns.
- **invoices**: Manages invoice records for donations.
- **notification_settings**: Manages user preferences for email and SMS notifications.
- **notifications**: Logs notifications sent to users.
- **refunds**: Records refund requests for donations.
- **reports**: Stores reports made by users about campaigns.
- **saved_campaigns**: Tracks campaigns saved by users for later viewing.
- **transactions**: Records details about payment transactions for donations.
- **user_profiles**: Stores user profile information such as address, phone, and profile picture.

------------------------------------------------------------

## 3. Supporting Tables

- **tags**: Stores tags for categorizing and labeling campaigns.
- **sikayetler**: Handles citizen complaints related to the municipality and their status.

------------------------------------------------------------

# Project Features

- **User Management**: Handles system users, their profiles, roles, and permissions.
- **Campaign Management**: Supports the creation, categorization, and tracking of campaigns.
- **Donation Tracking**: Manages donation records, payment status, and transaction details.
- **Feedback and Reporting**: Provides features for users to give feedback and report inappropriate campaigns.
- **Notification Management**: Manages user preferences and sends notifications.
- **Refunds and Transactions**: Tracks refunds and the payment process for donations.

------------------------------------------------------------

# Installation Instructions

## 1. Install Laravel project:

```bash
composer install
