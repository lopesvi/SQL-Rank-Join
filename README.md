# Projeto de Análise de Vendas com SQL e Power BI

## Descrição
Este projeto visa analisar o desempenho de vendas de uma empresa utilizando SQL para manipulação e transformação de dados e Power BI para visualização dos mesmos. O objetivo principal é fornecer insights detalhados que ajudem na tomada de decisões estratégicas.

## Tecnologias Utilizadas
### • SQL: 
Utilizado para calcular a soma das vendas por EmployeeKey e ProductKey e para classificar as vendas por funcionário utilizando a função DENSE_RANK().
### • Power BI:
Ferramenta de visualização de dados utilizada para criar dashboards interativos que exibem os insights gerados a partir dos dados processados.

##Estrutura do Projeto

##SQL

O script SQL calcula a soma das vendas por EmployeeKey e ProductKey e rankeia por EmployeeKey. Aqui está um exemplo do código utilizado:

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
        group by t1.EmployeeKey, t2.FirstName, t2.LastName, t3.EnglishProductName
    ) as TB
## Power BI
Os dados processados foram importados para o Power BI, onde foram criadas visualizações dinâmicas para fornecer insights valiosos. As principais visualizações incluem:

### •Valor Total de Vendas: 
Exibe o valor total de vendas.
### •Quantidade Total de Produtos Vendidos: 
Mostra a quantidade total de produtos vendidos.
### •Total de Venda por Produto:
Lista os produtos com maiores vendas.
### •Valor de Venda Total por Funcionário:
Apresenta o valor de vendas por funcionário.
### •5 Melhores Vendedores: 

Resultados
###  • Valor Total de Vendas:
R$ 80,45 milhões.
###  • Quantidade Total de Produtos Vendidos:
3.565 unidades.
###  • Top Produto:
A linha Mountain-200 Black lidera com mais de R$ 3 milhões em vendas.
###  • Top Vendedores: 
Linda, Jillian e Michael são os principais vendedores, cada um com mais de R$ 10 milhões em vendas.

##Contribuição
Sinta-se à vontade para contribuir com sugestões, melhorias ou correções. Abra uma issue ou envie um pull request.

Link para o Dashboard: https://app.powerbi.com/groups/me/reports/a91d4caa-cf65-4bcd-97f3-4c31f3cd606f/a1332fb84af17d298a52?experience=power-bi
