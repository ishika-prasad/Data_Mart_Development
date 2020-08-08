/*The number of orders that are not shipped within 10 days of order from PEC. */
SELECT 
    division, COUNT(*) 'No. of Orders'
FROM
    TPC_sales_fact AS fact,
    product_dimension AS product,
    sales_date_dimension AS sales,
    order_date_dimension AS ord_dim
WHERE
    fact.product_sk = product.product_sk
        AND fact.salesDate_sk = sales.salesDate_sk
        AND fact.orderDate_sk = ord_dim.orderDate_sk
        AND product.division = 'PEC'
        AND DATEDIFF(sales.salesDate, ord_dim.orderDate) >= 10;


/*A report that shows the sales, and costs associated with each customer or\
 monthly  basis */
SELECT 
   customer.name as Customer_name, SUM(tfft.qty) as sales , SUM(tfft.amt) as costs
FROM
    TPC_sales_fact tfft
        JOIN
    customer_dimension AS customer USING (customer_sk)
        JOIN
    Sales_Date_Dimension sdd USING (SalesDate_SK)
WHERE
    sdd.Sales_Month = 1
GROUP BY (customer_sk);

/*Select prodDesc, typeDesc and Number of products sold in a sales week = '35'*/
SELECT 
    pd.division, ANY_VALUE(pd.prodDesc) AS prodDesc,
    ANY_VALUE(pd.typeDesc) AS typeDesc,
    COUNT(pd.division) AS No_of_products
FROM
    TPC_sales_fact
        JOIN
    Product_Dimension pd USING (Product_SK)
        JOIN
    Sales_Date_Dimension sdd USING (SalesDate_SK)
WHERE
    sdd.Sales_Week = 35
GROUP BY (pd.division);

