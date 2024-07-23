with loyalty as (

SELECT
	c.name,
	c.country,
	c.notes as "status",
	rfm.*,
	CASE
	WHEN rfm_recency>=4 AND rfm_frequency>=4 AND  rfm_monetary>=4 THEN 'Best Customers'
	WHEN rfm_recency>=3 AND rfm_frequency>=3 AND  rfm_monetary>=3 THEN 'Loyal'
	WHEN rfm_recency>=3 AND rfm_frequency>=1 AND  rfm_monetary>=2 THEN 'Potential Loyalist'
	WHEN rfm_recency>=3 AND rfm_frequency>=1 AND  rfm_monetary>=1 THEN 'Promising'
	WHEN rfm_recency>=2 AND rfm_frequency>=2 AND  rfm_monetary>=2 THEN 'Customers Needing Attention'
	WHEN rfm_recency>=1 AND rfm_frequency>=2 AND  rfm_monetary>=1 THEN 'At Risk'
	WHEN rfm_recency>=1 AND rfm_frequency>=1 AND  rfm_monetary>=2 THEN 'Hibernating'
	ELSE 'Lost' END
	AS segment
from
	(
	select
		*,
		rfm_recency * 100 + rfm_frequency * 10 + rfm_monetary as rfm
	from
		(
		select
			*,
			ntile(4) over (
		order by
			last_payment_date) as rfm_recency,
			ntile(4) over (
		order by
			tot_payment_number) as rfm_frequency,
			ntile(4) over (
		order by
			tot_payment_amount) as rfm_monetary
		from
			(
			select
				customer_id,
				MAX(payment_date) as last_payment_date,
				COUNT(*) as tot_payment_number,
				SUM(amount) as tot_payment_amount
			from
				dp_payments.dp_payments
			group by
				customer_id
	) as rfm_metrics
) as rfm_score
) as rfm left join dp_customers.dp_customers c on rfm.customer_id = c.id 

)

select * from loyalty