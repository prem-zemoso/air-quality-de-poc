**Azure Cost Analysis – AQI Lakehouse POC**

Subscription: Azure Free Trial
Month: February 2026

**Billing Summary**
Actual Cost (Till Date): ₹3,854.33
Forecast Cost: ₹6,275.31
Forecast cost is system-generated based on the current consumption trend and may vary depending on usage.

**Key Observations**
1. Primary Cost Driver
NAT Gateway (~69%)
Major cost contributor due to network egress traffic
Triggered by external REST API calls

2. Databricks Compute Optimization
Compute costs are controlled because:
Small cluster configuration
Auto-termination set to 30 minutes
Limited data volume processed

3. Storage Efficiency
Only a few GB of data stored
Delta Lake format improves storage efficiency
ADLS Gen2 cost remains minimal

4. API Cost Observation
The REST API itself is free
Cost arises from network egress via NAT Gateway

**Estimated Savings (Without API):**
Removing external API calls can reduce costs by: ₹3,000 – ₹7,000 per month

**Conclusion**
The AQI Lakehouse POC architecture is:
Compute-efficient
Storage-optimized
Cost-controlled on processing
The dominant cost driver is network egress through NAT Gateway, primarily due to external API consumption.

**Recommendations for Production Scaling**
Evaluate Private Endpoints where possible
Reduce unnecessary external API calls
Optimize NAT Gateway usage
Consider serverless or alternative ingestion strategies