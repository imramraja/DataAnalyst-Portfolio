# 🚚 Supply Chain Analytics: Operational Efficiency & Predictive Modeling

An end-to-end data science project leveraging a real-world manufacturing dataset to analyze operational performance, forecast key metrics, and generate strategic supply chain recommendations. Combining rigorous EDA, statistical inference, and a suite of predictive models, this notebook demonstrates how advanced analytics drives actionable insights in manufacturing operations.

---

## 📌 Project Summary

This project ingests raw operational metrics for 200+ manufacturing sites, cleans and transforms the data, explores relationships among cycle time, throughput, defect rate, uptime, and inventory levels, then applies statistical tests and machine learning to:
- Identify the impact of Lean vs. Non-Lean practices on efficiency  
- Forecast throughput and downtime  
- Classify high-performance vs. low-performance facilities  
- Segment sites for targeted improvement plans

---

## ✅ Techniques & Models Used

- **Data Preparation**:  
  - Missing value imputation, outlier detection (Z-score & IQR), feature engineering for supply chain KPIs  
- **Exploratory Data Analysis (EDA)**:  
  - Descriptive statistics, histograms, boxplots, scatterplots, correlation heatmaps  
- **Statistical Inference**:  
  - Independent t-tests (Lean vs. Non-Lean), ANOVA, chi-square tests  
- **Predictive Modeling Suite**:  
  - **Linear Regression** – Throughput & cycle time forecasting  
  - **Random Forest & Gradient Boosting** – Performance classification & maintenance prediction  
  - **Time Series (ARIMA & Prophet)** – Seasonality in demand and downtime  
  - **Clustering (K-Means & Hierarchical)** – Operational profile segmentation  
- **Visualization & Reporting**:  
  - Matplotlib, Seaborn, Plotly interactive dashboards

---

## 🧠 Skills Demonstrated

| Domain                  | Skills & Tools                                                   |
|-------------------------|------------------------------------------------------------------|
| **Data Engineering**    | pandas, NumPy, data cleaning pipelines                           |
| **Statistical Analysis**| SciPy (t-tests, ANOVA), statsmodels                              |
| **Machine Learning**    | scikit-learn (RF, GBM, clustering), Prophet, statsmodels ARIMA   |
| **Visualization**       | Matplotlib, Seaborn, Plotly                                      |
| **Business Acumen**     | Supply chain KPIs, Lean methodology, operational KPIs interpretation |
| **Storytelling**        | Executive-level narrative, actionable recommendations            |

---

## 📊 Business Questions Addressed

- How do Lean practices influence operational efficiency across sites?  
- Which KPIs (cycle time, uptime, defect rate, inventory) most strongly predict throughput?  
- Can we forecast monthly throughput and downtime with >90% accuracy?  
- Which facilities cluster together by performance profile, and what tailored actions are needed?  
- What are the top three levers to achieve a 10–15% efficiency improvement?

---

## 📂 Data Sources

- **Dataset**: https://www.kaggle.com/datasets/lastman0800/supply-chain-management

---

## 📁 Notebook Contents

1. **🧹 Data Cleaning & Feature Engineering**  
2. **📊 Exploratory Data Analysis**  
3. **📈 Statistical Hypothesis Testing**  
4. **📈 Regression & Time Series Forecasting**  
5. **🤖 Classification & Ensemble Models**  
6. **🔍 Clustering & Segmentation**  
7. **📑 Model Evaluation & Diagnostics**  
8. **💡 Business Insights & Recommendations**

---

## ⚙️ Installation & Usage

```bash
git clone https://github.com/yourusername/supply-chain-analytics.git
cd supply-chain-analytics
python3 -m venv venv
source venv/bin/activate    # Windows: venv\Scripts\activate
pip install -r requirements.txt
jupyter lab notebooks/operational_efficiency_analysis.ipynb
