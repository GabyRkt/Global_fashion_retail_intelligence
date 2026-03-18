# 🛍️ Global Fashion Retail Intelligence

![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-150458?style=flat&logo=pandas&logoColor=white)
![Google BigQuery](https://img.shields.io/badge/BigQuery-4285F4?style=flat&logo=google-cloud&logoColor=white)
![dbt](https://img.shields.io/badge/dbt-FF694B?style=flat&logo=dbt&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=flat&logo=power-bi&logoColor=black)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=flat&logo=mysql&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat&logo=github&logoColor=white)

> End-to-end data pipeline and business intelligence dashboard analyzing 2 years of multinational fashion retail data across 35 stores and 7 countries.

---

## 📊 Dashboard Preview

<div style="display: flex; flex-wrap: wrap; gap: 10px;">
  <img src="docs/screenshots/global_overview.png" width="48%">
  <img src="docs/screenshots/store_performance.png" width="48%">
  <img src="docs/screenshots/product_analysis.png" width="48%">
  <img src="docs/screenshots/customer_insights.png" width="48%">
</div>

---

## 🏗️ Pipeline Architecture


```
[Kaggle CSV Dataset]
        ↓
[Python — pandas-gbq]
  Extract & Load 6.4M rows
        ↓
[Google BigQuery — raw_data]
  Cloud Data Warehouse
        ↓
[dbt Cloud]
  Staging → Star Schema → Data Quality Tests
        ↓
[Power BI — DirectQuery]
  Business Intelligence Dashboard
```

---

## 🛠️ Tech Stack

| Layer | Technology | Purpose |
|---|---|---|
| Ingestion | Python (pandas, pandas-gbq) | Extract & Load CSVs to BigQuery |
| Storage | Google BigQuery (Sandbox) | Cloud Data Warehouse |
| Transformation | dbt Cloud (Developer) | ELT, Star Schema, Data Quality |
| Visualization | Power BI (DirectQuery) | Business Intelligence Dashboard |
| Version Control | GitHub | Code & Documentation |

---

## 📁 Project Structure
```
├── ingestion/
│   ├── ingestion.py        # Python ingestion script
│   ├── requirements.txt    # Python dependencies
│   └── .env.example        # Environment variables template
├── models/
│   ├── staging/            # Cleaning & typing models (views)
│   │   ├── stg_customers.sql
│   │   ├── stg_transactions.sql
│   │   ├── stg_products.sql
│   │   ├── stg_stores.sql
│   │   ├── stg_employees.sql
│   │   ├── stg_discounts.sql
│   │   └── sources.yml
│   └── marts/              # Star schema models (tables)
│       ├── dim_customers.sql
│       ├── dim_products.sql
│       ├── dim_stores.sql
│       ├── dim_employees.sql
│       └── fct_sales.sql
├── seeds/
│   └── exchange_rates.csv  # Historical FX rates 2023-2024
├── docs/
│   └── screenshots/
├── .gitignore
├── dbt_project.yml
└── README.md
```

---

## 📐 Data Model

### Star Schema

<div style="display: flex; justify-content: center;">
  <img src="docs/screenshots/lineage_graph.png" width="70%">
</div>

| Table | Type | Rows | Description |
|---|---|---|---|
| `fct_sales` | Fact | 6,416,827 | Sales & returns with pre-calculated EUR margins |
| `dim_customers` | Dimension | 1,643,306 | Customer demographics & generational segments |
| `dim_products` | Dimension | 17,940 | Product catalog (6 languages) |
| `dim_stores` | Dimension | 35 | 35 stores across 7 countries |
| `dim_employees` | Dimension | 404 | Store staff |

---

## 🔢 Dataset

Source : [Global Fashion Retail Sales — Kaggle](https://www.kaggle.com/datasets/ricgomes/global-fashion-retail-stores-dataset)

Synthetic dataset simulating 2 years of transactional data for a multinational fashion retailer featuring 4M+ sales records across 7 countries (🇺🇸 🇨🇳 🇩🇪 🇬🇧 🇫🇷 🇪🇸 🇵🇹) in 4 currencies (USD, EUR, GBP, CNY).

---

## ✅ Data Quality

**28/28 dbt tests passing**, covering uniqueness and non-null constraints on all primary and foreign keys.

<div style="display: flex; justify-content: center;">
  <img src="docs/screenshots/dbt_tests.png" width="70%">
</div>

---

## 💡 Key Business Insights

### 1. UK Stores profitability crisis
UK stores show the lowest margin rate (**26.85%**) while every other market is between 36% and 49%.
Store London and Store Bristol are the worst performers with margins below **32%**.
**Recommendation** : Conduct a cost structure audit on UK stores to review rental costs, staffing ratios and pricing strategy.

### 2. Suits & Sets pricing opportunity
Suits & Sets generate **13M€ in revenue** but rank among the lowest margin sub-categories.
**Recommendation** : A 5% price increase on this sub-category could generate an estimated **+600K€ in gross margin** annually.

### 3. Gen Z China, the highest value segment
Gen Z customers in China represent **22.3M€ in revenue**. No other country × generation combination even comes close. If there's one segment to invest in, this is it.
**Recommendation** : Prioritize digital marketing investment and product assortment tailored to Chinese Gen Z preferences.

### 4. Boomer+ untapped potential
Boomer+ customers have the **highest average basket size (67€)** but represent only **9M€ in total revenue**.
**Recommendation** : Targeted loyalty programs for Boomer+ customers could significantly increase their purchase frequency.

---

## ⚠️ Dataset Limitations

- **Synthetic data** : margins (~63%) are higher than real-world fashion retail benchmarks (40-55%)
- **Uniform return rates** (~5% per generation) suggest simplified return modeling
- **Exchange rates** : fixed historical averages (2023-2024) used instead of dynamic rates. In a production context, rates would be fetched dynamically via an API (e.g. frankfurter.app)
- **Multilingual data** : store names and some fields are in local languages (Chinese, German, Spanish) which reflect real-world multinational complexity

---

## How to Run

### 1. Prerequisites
- Python
- Google Cloud account with BigQuery enabled
- dbt Cloud account (free Developer plan)
- Power BI Desktop

### 2. Ingestion
```
pip install -r ingestion/requirements.txt
python ingestion/ingestion.py
```

### 3. dbt
```
dbt seed && dbt run && dbt test
```

### 4. Dashboard
Open Power BI Desktop → Connect to BigQuery (`dbt_grakotoarison` dataset) → Load `fct_sales`, `dim_customers`, `dim_products`, `dim_stores`, `dim_employees`.

---
