# KrishiLink (Smart Agri-Supply & Soil Intelligence System)

KrishiLink is an advanced, 8-module relational database design tailored to empower farmers, eliminate intermediaries, ensure cold-storage safety, and streamline agricultural credit.

## 📂 Database Name: `KrishiLinkDB`

---

## 🛠️ Modules Breakdown (8 Core Modules)

### 1. User Management Module
*   **Purpose:** Manages registration and roles for Farmers, Buyers, Experts, and Logistics Partners.
*   **Tables:** `Users`

### 2. Soil Health & AI Crop Advisory Module
*   **Purpose:** Diagnostics tracking for Nitrogen, Phosphorus, Potassium (NPK), and pH levels to suggest ideal crops.
*   **Tables:** `SoilReports`, `CropRecommendations`

### 3. Marketplace & Direct Crop Sales
*   **Purpose:** Allows direct post-harvest cataloging and B2B crop sales.
*   **Tables:** `CropListings`, `Orders`

### 4. Real-time Auction & Bidding Module
*   **Purpose:** Live bidding system for high-value organic produce to ensure fair pricing.
*   **Tables:** `Auctions`, `Bids`

### 5. Shared Equipment Rental Module
*   **Purpose:** Peer-to-peer equipment sharing ecosystem (tractors, tillers).
*   **Tables:** `Equipment`, `RentalBookings`

### 6. Logistics & Supply Chain Fleet
*   **Purpose:** Tracks delivery shipments from remote farms to urban buyers.
*   **Tables:** `Shipments`

### 7. Warehouse & Cold Storage Management
*   **Purpose:** Reserves temperature-controlled space to extend produce shelf-life.
*   **Tables:** `Warehouses`, `StorageBookings`

### 8. Micro-Finance & Credit Line
*   **Purpose:** Facilitates quick access to low-interest agricultural micro-loans.
*   **Tables:** `Loans`

---

## 🚀 Installation & Import

1. Run MySQL.
2. Source the DDL script:
   ```sql
   SOURCE schema.sql;