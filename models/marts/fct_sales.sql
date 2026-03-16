with transactions as (
    select * from {{ ref('stg_transactions') }}
),

discounts as (
    select * from {{ ref('stg_discounts') }}
),

exchange_rates as (
    select * from {{ ref('exchange_rates') }}
),

final as (
    select
        -- Clés
        t.invoice_id,
        t.line,
        t.customer_id,
        t.product_id,
        t.store_id,
        t.employee_id,

        -- Dates
        t.transaction_date,
        extract(year from t.transaction_date)       as year,
        extract(month from t.transaction_date)      as month,
        extract(dayofweek from t.transaction_date)  as day_of_week,
        cast(extract(year from t.transaction_date) * 100 + 
            extract(month from t.transaction_date) as INT64) as year_month,

        -- Métriques devise locale
        t.quantity,
        t.unit_price,
        t.discount,
        t.line_total,
        t.invoice_total,
        t.currency,
        t.payment_method,
        t.transaction_type,

        -- Métriques converties en EUR
        round(t.line_total * er.rate_to_eur, 2)                         as line_total_eur,
        round(t.invoice_total * er.rate_to_eur, 2)                      as invoice_total_eur,

        -- Marge brute en devise locale
        round(t.line_total - (p.production_cost * t.quantity), 2)       as gross_margin,

        -- Marge brute en EUR
        round((t.line_total - (p.production_cost * t.quantity)) 
            * er.rate_to_eur, 2)                                        as gross_margin_eur,

        -- Taux de marge
        round(
            safe_divide(
                t.line_total - (p.production_cost * t.quantity),
                t.line_total
            ) * 100, 2
        )                                                               as margin_rate

    from transactions t
    left join {{ ref('dim_products') }} p
        on t.product_id = p.product_id
    left join exchange_rates er
        on t.currency = er.currency
)

select * from final
