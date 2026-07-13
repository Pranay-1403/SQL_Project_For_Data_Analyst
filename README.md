# Data Science Job Market Analysis (India) - SQL Queries

## Overview
This repository contains a series of SQL queries designed to analyze the job market for data professionals (Data Analysts, Data Scientists, and Data Engineers) in India. The analysis focuses on identifying top-paying roles, most in-demand skills, and the optimal skills to learn for maximizing both salary and employability.

## Database Schema
The queries rely on a relational database structure containing the following core tables:
* `job_postings_fact`: Contains core metrics including job titles, locations, schedules, and average yearly salaries.
* `company_dim`: Contains company names and details.
* `skills_dim`: Contains a master list of technical skills.
* `skills_job_dim`: A junction table linking job postings to their required skills.

## Query Breakdown

### 1. Top Paying Data Roles
Identifies the highest-paying roles in the Indian market. It includes queries for the top 10 Data Scientist positions overall, as well as a window function (`ROW_NUMBER()`) approach to rank the top 5 highest-paying jobs across three distinct categories: Data Scientist, Data Analyst, and Data Engineer.

### 2. Skills for Top Paying Jobs
Expands on the first analysis by joining the top-paying job postings with the skills dimension tables. This reveals the specific technical requirements for the most lucrative positions.

### 3. Most In-Demand Skills
Calculates the frequency of skills mentioned in job postings. It provides an overall top 5 list for Data Scientists, as well as a partitioned ranking to highlight the distinct top 5 skills required across Analysts, Scientists, and Engineers.

### 4. Highest Paying Skills
Calculates the average salary associated with each skill. This helps identify highly valued technical proficiencies by averaging the salaries of job postings that require them.

### 5. Optimal Skills to Learn (High Demand & High Salary)
Combines demand and salary metrics to find the optimal skills for professional development. It filters for skills that appear in a significant number of postings (demand > 10) and ranks them by average salary. The code demonstrates two methods: a Common Table Expression (CTE) approach and a more concise `GROUP BY ... HAVING` approach.

## Business Value
These scripts demonstrate advanced SQL concepts such as Common Table Expressions (CTEs), window functions, complex joins, and aggregation. The resulting insights provide actionable intelligence for optimizing technical skill sets to match current market demands.
