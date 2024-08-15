

  -- ●Which campaign generated the highest number of impressions, clicks, and conversions?
SELECT Campaign, 
    SUM(Impressions) AS TotalImpressions, 
    SUM(Clicks) AS TotalClicks, 
    SUM(Conversions) AS TotalConversions
FROM  MarketData
GROUP BY  Campaign




	-- ●What is the average cost-per-click (CPC)  and click-through rate (CTR) for each campaign?
	
	 UPDATE MarketData
	 SET CTR = REPLACE(CTR, '%', '');
	 ALTER TABLE MarketData
	 ALTER COLUMN CTR FLOAT;
	 
	SELECT Campaign, 
	      AVG(Daily_Average_CPC) AS AverageCPC, 
	      AVG(CTR) AS AverageCTR
	FROM  MarketData
	GROUP BY  Campaign

		--●	Which channel has the highest ROI
	SELECT  Channel,
	       SUM(Total_conversion_value_GBP - Spend_GBP) / SUM(Spend_GBP) AS ROI
	FROM MarketData
	GROUP BY  Channel
	ORDER BY  ROI DESC;
	

		-- ●	How do impressions, clicks, and conversions vary across different channels?
	SELECT  Channel,
	    SUM(Impressions) AS TotalImpressions,
	    SUM(Clicks) AS TotalClicks,
	    SUM(Conversions) AS TotalConversions
	FROM MarketData
	GROUP BY  Channel
	ORDER BY  Channel;


		--●	Which cities have the highest engagement rates (likes, shares, comments)?
	SELECT  City_Location AS City,
	    SUM(Likes_Reactions) AS TotalLikes,
	    SUM(Shares) AS TotalShares,
	    SUM(Comments) AS TotalComments
	FROM MarketData
	GROUP BY 
	    City_Location
	ORDER BY 
	    TotalLikes DESC,
		Totalshares DESC,
		TotalComments DESC


		--●	What is the conversion rate by city?
	SELECT  City_Location AS City,
	    SUM(Conversions) AS TotalConversions,
	    SUM(Clicks) AS TotalClicks,
	    (SUM(Conversions) * 100.0 / SUM(Clicks)) AS ConversionRate
	FROM MarketData
	GROUP BY 
	    City_Location
	ORDER BY 
    ConversionRate DESC;


	--●	How do ad performances compare across different devices (mobile, desktop, tablet)?
	
	SELECT  Device,
	    SUM(Impressions) AS TotalImpressions,
	    SUM(Clicks) AS TotalClicks,
	    SUM(Conversions) AS TotalConversions,
	    AVG(Daily_Average_CPC) AS AvgCPC
	FROM 
	    MarketData
	GROUP BY 
	    Device
	ORDER BY 
	    Device;

   	--●	Which specific ads are performing best in terms of engagement and conversions?
	
	SELECT  Ad,
	    SUM(Likes_Reactions) AS TotalLikes,
        SUM(Shares) AS TotalShares,
	    SUM(Comments) AS TotalComments,
	    (SUM(Likes_Reactions) + SUM(Shares) + SUM(Comments)) AS TotalEngagements,
        SUM(Conversions) AS TotalConversions
	FROM 
	    MarketData
	GROUP BY 
	    Ad
	ORDER BY 
	    TotalEngagements DESC, 
	    TotalConversions DESC;


--●	Which device type generates the highest conversion rates?
		SELECT 
    Device,
    SUM(Conversions) AS TotalConversions,
    SUM(Impressions) AS TotalImpressions,
    (SUM(Conversions) / SUM(Impressions)) * 100 AS ConversionRate
FROM 
    MarketData
GROUP BY 
    Device
ORDER BY 
    ConversionRate DESC;

	--●	Which specific ads are performing best in terms of engagement and conversions?
	SELECT 
    Ad,
    SUM(Clicks) AS TotalClicks,
    SUM(Likes_Reactions) AS TotalLikes,
    SUM(Shares) AS TotalShares,
    SUM(Comments) AS TotalComments,
    SUM(Conversions) AS TotalConversions
FROM 
    MarketData
GROUP BY 
    Ad
ORDER BY 
    TotalConversions DESC, TotalClicks DESC, TotalLikes DESC, TotalShares DESC, TotalComments DESC;

	

 -- ●	What is the ROI for each campaign, and how does it compare across different channels and devices?
 SELECT 
    Campaign,
    SUM(Total_conversion_value_GBP) AS TotalConversionValue,
    SUM(Spend_GBP) AS TotalSpend,
    ((SUM(Total_conversion_value_GBP) - SUM(Spend_GBP)) / SUM(Spend_GBP)) * 100 AS ROI
FROM 
    MarketData
GROUP BY 
    Campaign;


--	 ROI for Each Channel

SELECT 
    Channel,
    SUM(Total_Conversion_Value_GBP) AS TotalConversionValue,
    SUM(Spend_GBP) AS TotalSpend,
    ((SUM(Total_Conversion_Value_GBP) - SUM(Spend_GBP)) / SUM(Spend_GBP)) * 100 AS ROI
FROM 
    MarketData
GROUP BY 
    Channel;



    --ROI for Each Channel and device 
	SELECT 
    Channel,
    Device,
    SUM(Total_Conversion_Value_GBP) AS TotalConversionValue,
    SUM(Spend_GBP) AS TotalSpend,
    ((SUM(Total_Conversion_Value_GBP) - SUM(Spend_GBP)) / SUM(Spend_GBP)) * 100 AS ROI
FROM 
    MarketData
GROUP BY 
    Channel, Device
ORDER BY 
    ROI DESC;


--monthly
SELECT 
    DATEPART(YEAR, Date) AS Year,
    DATEPART(MONTH, Date) AS Month,
    SUM(Impressions) AS TotalImpressions,
    SUM(Clicks) AS TotalClicks,
    SUM(Conversions) AS TotalConversions,
    SUM(Spend_GBP) AS TotalSpend,
    AVG(Daily_Average_CPC) AS AvgCPC
FROM 
    MarketData
GROUP BY 
    DATEPART(YEAR, Date),
    DATEPART(MONTH, Date)
ORDER BY 
    Year, Month;

--Qauter 
SELECT 
    DATEPART(YEAR, Date) AS Year,
    DATEPART(QUARTER, Date) AS Quarter,
    SUM(Impressions) AS TotalImpressions,
    SUM(Clicks) AS TotalClicks,
    SUM(Conversions) AS TotalConversions,
    SUM(Spend_GBP) AS TotalSpend,
    AVG(Daily_Average_CPC) AS AvgCPC
FROM 
    MarketData
GROUP BY 
    DATEPART(YEAR, Date),
    DATEPART(QUARTER, Date)
ORDER BY 
    Year, Quarter;


--Seaon 
SELECT 
    DATEPART(YEAR, Date) AS Year,
    CASE 
        WHEN DATEPART(MONTH, Date) IN (12, 1, 2) THEN 'Winter'
        WHEN DATEPART(MONTH, Date) IN (3, 4, 5) THEN 'Spring'
        WHEN DATEPART(MONTH, Date) IN (6, 7, 8) THEN 'Summer'
        WHEN DATEPART(MONTH, Date) IN (9, 10, 11) THEN 'Fall'
    END AS Season,
    SUM(Impressions) AS TotalImpressions,
    SUM(Clicks) AS TotalClicks,
    SUM(Conversions) AS TotalConversions,
    SUM(Spend_GBP) AS TotalSpend,
    AVG(Daily_Average_CPC) AS AvgCPC
FROM 
    MarketData
GROUP BY 
    DATEPART(YEAR, Date),
    CASE 
        WHEN DATEPART(MONTH, Date) IN (12, 1, 2) THEN 'Winter'
        WHEN DATEPART(MONTH, Date) IN (3, 4, 5) THEN 'Spring'
        WHEN DATEPART(MONTH, Date) IN (6, 7, 8) THEN 'Summer'
        WHEN DATEPART(MONTH, Date) IN (9, 10, 11) THEN 'Fall'
    END
ORDER BY 
    Year, Season;

--Yr ov yr
SELECT 
    DATEPART(YEAR, Date) AS Year,
    DATEPART(MONTH, Date) AS Month,
    SUM(Impressions) AS TotalImpressions,
    SUM(Clicks) AS TotalClicks,
    SUM(Conversions) AS TotalConversions,
    SUM(Spend_GBP) AS TotalSpend,
    AVG(Daily_Average_CPC) AS AvgCPC
FROM 
    MarketData
GROUP BY 
    DATEPART(YEAR, Date),
    DATEPART(MONTH, Date)
ORDER BY 
    Month, Year;
