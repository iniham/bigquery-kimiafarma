CREATE OR REPLACE TABLE kimiafarma_data.kf_analisa AS
SELECT
    t.transaction_id,
    t.date,
    c.branch_id,
    c.branch_name,
    c.kota,
    c.provinsi,
    c.rating AS rating_cabang,
    t.customer_name,
    p.product_id,
    p.product_name,
    t.price,
    t.discount_percentage,
    CASE 
        WHEN t.price <= 50000 THEN 0.10
        WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15
        WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20
        WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25
        ELSE 0.30 
    END AS persentase_gross_laba,
    (t.price * (1 - t.discount_percentage / 100)) AS nett_sales,
    ((t.price * (1 - t.discount_percentage / 100)) * 
        CASE 
            WHEN t.price <= 50000 THEN 0.10
            WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15
            WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20
            WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25
            ELSE 0.30 
        END) AS nett_profit,
    t.rating AS rating_transaksi,
FROM kimiafarma_data.kf_final_transaction t
JOIN kimiafarma_data.kf_kantor_cabang c ON t.branch_id = c.branch_id
JOIN kimiafarma_data.kf_product p ON t.product_id = p.product_id;
