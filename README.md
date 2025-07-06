# Stock Data Warehouse & BI Project | Data Storage CA1 (DBS)

📊 **Module:** B9DA111 Data Storage Solutions  
🎓 **Course:** MSc in Data Analytics  
🏫 **Institution:** Dublin Business School (DBS), Ireland  
👨‍🏫 **Lecturer:** Suman Gurbani  
📅 **Academic Year:** 2024–2025

---

## 📑 Project Overview

This project designs and implements a **Stock Data Warehouse (StockDW)** using a star schema. It includes:
- **Data extraction** with Python (`yfinance`) for real-time stock data.
- **ETL pipelines** using SSIS to load and transform data into the data warehouse.
- **SSRS Reports:** Drill-down, parameterized, matrix, and subreports for business insights.
- **Tableau Dashboards** for visual trend analysis and forecasting.
- **Neo4j vs SQL** comparison to analyze graph databases versus relational systems for stock data.

---

## 📂 Folder Structure

| Folder | Description |
|--------|-------------|
| **dataset/** | Cleaned CSVs for Fact and Dimension tables (`FactStockPrices.csv`, `Marketnames.csv`, etc.). |
| **sql/** | SQL scripts for creating `StockDW` database and tables (`SQLQuery1.sql`). |
| **starschema/** | Star schema diagram (`DataStorage.drawio`). |
| **report/** | All SSRS report exports as PDFs: Drill-down, Matrix, Parameterized, Subreports, and Final Main Report. |
| **report files-ssis/** | SSRS project files (`.rptproj`, `.rsuser`) and `StockDW_SSRS` folder if you have `.rdl` files. |
| **warehousefiles-ssrs/**
