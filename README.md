**AQI Lakehouse – End-to-End Azure Data Engineering POC**

** Project Overview**
This Proof of Concept (POC) demonstrates an end-to-end Azure Data Engineering pipeline for ingesting, transforming, and analyzing Air Quality Index (AQI) data using a Lakehouse architecture.
The solution is built entirely on Azure services under the Azure Free Trial subscription.

**Architecture Overview**

High-Level Flow:

External AQI API
→ Azure Data Factory (Orchestration)
→ Azure Databricks (Processing)
→ ADLS Gen2 (Bronze / Silver / Gold)
→ Analytics Ready Data

**Azure Services Used**

Azure Data Factory – Pipeline orchestration
Azure Databricks – Data transformation (PySpark)
Azure Data Lake Storage Gen2 – Data storage
NAT Gateway – External API access
Virtual Network – Secure networking
Azure Cost Management – Cost monitoring

**Lakehouse Layer Design**
**Bronze Layer**
Raw API response stored as-is
JSON format
Partitioned by ingestion date

**Silver Layer**
Cleaned and structured data
Schema enforcement
Null handling
Data type casting
Deduplication

**Gold Layer**
Aggregated AQI metrics
City-level daily averages
Analytics-ready tables

**Pipeline Workflow**

Step 1 – ADF triggers pipeline
Step 2 – API data ingestion via Databricks notebook
Step 3 – Raw data stored in Bronze layer
Step 4 – Transformation to Silver layer
Step 5 – Aggregations written to Gold layer
Step 6 – Cost monitored via Azure Cost Analysis

**Databricks Configuration**

Cluster Configuration:

Small cluster
Auto-termination: 30 minutes
Optimized for low-cost POC

Processing:

PySpark transformations
Delta Lake format
Append mode writes
Partition-based storage

**Cost Analysis – February 2026**

Subscription: Azure Free Trial
Actual Cost (Till Date): ₹3,854.33
Forecast Cost: ₹6,275.31

Major Cost Contributors:

NAT Gateway (~69%) – Network egress from API calls
Virtual Machines (~17%) – Databricks compute
Virtual Network (~8%)
Storage (~5%)
ADF & Workspace (<2%)

Key Insight:
The REST API is free. Cost arises from network egress via NAT Gateway.

Estimated Savings Without External API:
₹3,000 – ₹7,000 per month

**Security & Networking**
Databricks deployed inside Virtual Network
NAT Gateway used for outbound API access
No public exposure of storage account
Controlled networking configuration

**Data Engineering Concepts Implemented**

Medallion Architecture (Bronze / Silver / Gold)
Delta Lake storage
Schema evolution
Partitioning
Auto-termination cost optimization
Orchestration using ADF
External API ingestion
Cost monitoring & optimization analysis

**Production Improvement Ideas**

Use Private Endpoints instead of NAT
Cache API responses
Reduce external API calls
Implement incremental ingestion
Add monitoring & alerts
Introduce CI/CD for Databricks & ADF

**Repository Structure**
air-quality-de-poc/
│
├── adf/
├── processing/
├── cost-tracking/
│   └── azure-cost-notes.md
├── docs/
└── README.md

**Key Learnings**

Networking can dominate Azure costs
Auto-termination significantly reduces compute cost
Storage cost is minimal for small datasets
Proper architecture design prevents unnecessary scaling

**Conclusion**

The AQI Lakehouse POC successfully demonstrates:
. End-to-end Azure data pipeline
. Cost-optimized Lakehouse architecture
. External API ingestion
. Structured Delta-based transformations
. Real-world cloud cost analysis

This POC reflects practical Azure Data Engineering implementation with cost awareness and architecture best practices.