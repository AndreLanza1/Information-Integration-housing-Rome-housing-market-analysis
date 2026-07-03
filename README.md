# Information Integration: Rome Housing Market Analysis

![Data Integration](https://img.shields.io/badge/Data-Integration-blue)
![Pentaho](https://img.shields.io/badge/ETL-Pentaho-green)
![SQL](https://img.shields.io/badge/Database-SQL-orange)

## Project Overview

This project was developed for the **Large Scale data management** course. The goal is to integrate heterogeneous data sources to analyze the housing rental market in Rome, specifically comparing **Short-term rentals (Airbnb)** with **Long-term rentals**.

The integrated database allows us to extract valuable insights regarding pricing, neighborhood population, proximity to public transport (metro stations), and tourist attractions.

## 🗂️ Data Sources

The project integrates data from multiple sources, resolving conceptual and structural heterogeneity:

1. **Short-Term rentals:** InsideAirbnb dataset and Kaggle "Italian Airbnb Dataset" (Filtered for Rome). Contains listings, prices, room types, accommodates, and coordinates.
2. **Long-Term rentals:** Kaggle "Italy house prices" dataset. Contains prices, square meters, and addresses.
3. **Points of Interest (Metro and tourist attractions):** OpenStreetMap database.
4. **Population data:** Official Rome Geoportal (Number of residents per municipio).

_Note: Spatial joins and GeoJSON polygon boundaries were used to map specific latitude/longitude coordinates to the corresponding Rome neighborhoods (procedural mapping)._

## Project architecture and Data Integration
The data integration pipeline and the ETL (Extract, Transform, Load) process were designed and implemented using **Pentaho Data Integration (Spoon)**. Our goal was to merge diverse data sources into a unified Relational Database Schema. The integration process handles several critical tasks:

* **Data extraction and cleansing:**
  * Imported raw data from diverse formats (CSV files, OSM databases).
  * Filtered out noisy or irrelevant data (e.g., removing Airbnb listings outside of Rome or entries with missing crucial values).
  * Standardized data types, formats, and currencies to ensure consistency across the integrated database.

* **Resolving conceptual and structural heterogeneity:**
  * **Spatial data integration:** One of the main challenges was aligning different geographical representations. Short-term rentals used latitude/longitude coordinates, while long-term rentals used street addresses. 
  * **Procedural Mapping via QGIS:** To resolve this, we utilized **QGIS** alongside spatial joins. By using a GeoJSON file containing the polygon boundaries of Rome's neighborhoods (Quartieri), we were able to accurately map specific coordinates and addresses to their corresponding neighborhood area.

* **Data transformation and Loading (ETL Mappings):**
  * Handled duplicate records and resolved primary key constraints.
  * Designed modular `.ktr` transformations to process and route data. Discarded records (e.g., duplicate PKs) are safely routed to external output files (`/data/Discarded_*`) for auditing, rather than failing the entire pipeline.
  * Successfully loaded the clean, mapped data into the final Relational Database tables (e.g., `G_ShortTerms`, `G_LongTerms`, `G_NeighborhoodInterest`).
 
> For a complete theoretical overview and data modeling explanation, please refer to the [presentation](Presentation.pdf).

## Analytical queries (SQL Tasks)

Once the data was integrated, several queries were executed to extract insights. The SQL scripts can be found in the `/sql` directory:

- **[Task 1](sql/Task1.sql) - Tourist attraction proximity:** Finds Airbnb listings with a review score > 4.8 located in neighborhoods containing at least 3 distinct tourist attractions.
- **[Task 2](sql/Task2.sql) - Over-tourism:** Identifies neighborhoods with fewer than 1,000 residents, at least 3 distinct Airbnb listings, and long-term rental prices greater than €20 per square meter.
- **[Task 3](sql/Task3.sql) - Public transport and affordability:** Finds long-term rentals in neighborhoods with at least 2 metro stations and a monthly cost lower than €600.
- **[Task 4](sql/Task4.sql) - Break-even analysis:** Compares the daily price of short-term rentals with the monthly price of long-term rentals for properties of the same size in the same neighborhood.

## Repository Structure

```text
├── data/                  # Raw datasets (CSV) and output directory for discarded records
├── pentaho_mappings/      # Pentaho ETL transformations (.ktr)
├── sql/                   # SQL scripts for data analysis (Tasks 1-4)
├── Presentation.pdf       # Project presentation slides
└── README.md              
```


## How to run the project

To reproduce the data integration pipeline and run the analysis on your local machine, follow these steps:

**1. Clone the Repository and Set Up Data**

- Clone this repository to your local environment.
- Ensure that all raw data files (e.g., `S_AirbnbInside.csv`) are placed directly inside the `data/` folder.

**2. Configure the Database**
The Pentaho transformations require an active SQL database connection.

- Open the `.ktr` files located in the `pentaho_mappings/` folder using a text editor or Pentaho Spoon.
- Locate the `<connection>` blocks and replace the placeholder credentials (`YOUR_USERNAME` and `YOUR_PASSWORD`) with your actual local database credentials.

**3. Run the ETL Pipeline**

- Open **Pentaho Data Integration (Spoon)**.
- Load the mapping files (`.ktr`) from the `pentaho_mappings/` folder.
- Execute the transformations to load the integrated data into your database.

  > **⚠️ Important Note on File Paths:** The file paths within the mappings are relative (`${Internal.Entry.Current.Directory}/../data/`). As long as you maintain the repository's original folder structure, Pentaho will automatically locate the input files in the `data/` folder and write any rejected records (e.g., `Discarded_PK`) to that same directory.

**4. Execute Analytics**

- Once the data is successfully loaded, use the SQL scripts provided in the `sql/` folder against your target database to extract insights.

**Authors:**  
Andrea Lanzarone
Claudia Cornacchia 
