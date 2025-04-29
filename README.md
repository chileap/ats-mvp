# ATS (Applicant Tracking System) with Event Sourcing

A Ruby on Rails API application for managing job applications and candidates using Event Sourcing pattern.

## Overview

This Applicant Tracking System (ATS) is designed to help HR managers track job applications and candidates. The system uses Event Sourcing to maintain a complete history of all changes to jobs and applications, allowing for historical tracking and audit capabilities.

## Features

- Event Sourcing pattern implementation for jobs and applications
- Job status management (activated/deactivated)
- Application status tracking (applied/interview/hired/rejected)
- Notes management for applications
- RESTful JSON API endpoints

## Technical Stack

- Ruby on Rails
- PostgreSQL (or your preferred database)
- Event Sourcing pattern implementation
- Single Table Inheritance for events

## Architecture

### Core Models

- **Job**
  - Properties: name, description, etc.
  - Status calculated from events
  - Events: `Job::Event::Activated`, `Job::Event::Deactivated`

- **Application**
  - Properties: candidate name, etc.
  - Status calculated from events
  - Events: `Application::Event::Interview`, `Application::Event::Hired`, `Application::Event::Rejected`, `Application::Event::Note`

### Event Sourcing Implementation

The system uses Event Sourcing to maintain the state of jobs and applications. Instead of storing the current state directly, we store events that represent state changes. The current state is calculated by replaying these events.

## API Endpoints

### 1. Applications for Activated Jobs
`GET /api/applications`

Returns all applications for activated jobs with:
- Job name
- Candidate name
- Application status
- Number of notes
- Last interview date (if any)

### 2. Jobs List
`GET /api/jobs`

Returns all jobs (including deactivated ones) with:
- Job name
- Job status
- Number of hired candidates
- Number of rejected candidates
- Number of ongoing applications

## Getting Started

1. Clone the repository
2. Install dependencies:
   ```bash
   bundle install
   ```
3. Set up the database:
   ```bash
   rails db:create db:migrate db:seed
   ```
4. Start the server:
   ```bash
   rails server
   ```

## Testing

Run the test suite:
```bash
bundle exec rspec
```
