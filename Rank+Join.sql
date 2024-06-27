-- Calcula a soma das vendas por EmployeeKey e ProductKey, e rankeia por EmployeeKey
select
    EmployeeKey,
    ProductKey,
    sum(SalesAmount) as venda,
    DENSE_RANK() over (partition by EmployeeKey order by sum(SalesAmount) desc) as posicao
from
    dbo.FactResellerSales
group by
    EmployeeKey, ProductKey

-- Base principal
select 
FirstName,
LastName,
EnglishProductName,
[Total de Vendas],
Ranking
from
(
select
    t1.EmployeeKey,
	t2.FirstName,
	t2.LastName,
	t3.EnglishProductName,
	SUM(t1.SalesAmount) as 'Total de Vendas',
	DENSE_RANK() over(partition by t1.EmployeeKey order by SUM(t1.SalesAmount) desc) as Ranking

from
    dbo.FactResellerSales as T1
left join
    dbo.DimEmployee as T2
on
    t1.EmployeeKey = t2.EmployeeKey

left join 
	dbo.DimProduct as T3
on
	t1.ProductKey = t3.ProductKey

group by t1.EmployeeKey,t2.FirstName,t2.LastName,t3.EnglishProductName ) as TB
where Ranking = 1


-- Seleciona os 10 primeiros registros da tabela DimEmployee
select
    top 10 *
from
    dbo.DimEmployee;
	
