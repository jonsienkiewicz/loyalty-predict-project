\# Live Notes - 2025-09-29



\## 🎯 Objetivo da Sessão



Começar um projeto de Data Science do zero.



\## O negócio



Sistema de pontos no chat da Twitch - Cubos



* !join para se cadastrar;
* !presente para assinar a lista de presença e ganhar cubo;
* Cada mensagem enviada no chat, recompensa de 1 cubo;
* !troca realiza a troca de cubos por datapoints, moeda da nossa loja no StreamElements;
* Com base nessas transações que identificamos a atividade das pessoas



Plataforma de Cursos



* Todo catálogo de cursos e projetos que estão disponíveis no YouTube;
* A pessoa salva sua progressão completando vídeos;
* É possível preencher os dados de PDI que também ficam salvos;
* Há recompensas e integração com o sistema de pontos anterior;



\## O que estamos procurando?



\### Métricas



DAU - Daily Active Users



MAU - Monthly Active Users



\## 💡 Key Insights do Teo

* muitas pessoas pecam em não saber a regra do negócio
* 



\## 🛠️ Comandos/Técnicas Novas



DAU

SELECT substr(DtCriacao,0,11) AS DtDia,

       count(DISTINCT IdCliente) AS DAU



FROM transacoes

GROUP BY 1

ORDER BY DtDia



MAU



WITH tb\_daily AS (



    SELECT DISTINCT

        date(substr(DtCriacao,0,11)) AS DtDia,

        IdCliente



    FROM transacoes

    ORDER BY dTdIA



),



tb\_distinct\_day AS (



    SELECT

            DISTINCT DtDia AS dtRef

    FROM tb\_daily



)



SELECT  t1.dtRef,

        count(DISTINCT IdCliente) AS MAU,

        count(DISTINCT t2.dtDia) AS qtdeDias



FROM tb\_distinct\_day AS t1



LEFT JOIN tb\_daily AS t2

ON t2.DtDia <= t1.dtRef

AND julianday(t1.dtRef) - julianday(t2.DtDia) < 28



GROUP BY t1.dtRef



ORDER BY t1.dtRef ASC





❓ Dúvidas para Pesquisar





\## ✅ Conquistas de Hoje:

\- \[x] Setup completo do ambiente

\- \[x] Entendimento do business problem: prever engajamento de usuários

\- \[x] Estrutura do projeto criada no GitHub



\## 🎯 Insights do Negócio:

\- Engajamento = combinação de frequência e qualidade

\- Dados vêm de múltiplas fontes (pontos, cursos)

\- Métricas de sucesso precisam ser definidas



\## 🔍 Lacunas Identificadas:

\- SQL para queries complexas (JOINs, subqueries)

\- Necessidade de revisar agregações (GROUP BY)



\## 🚀 Próximos Passos:

\- \[ ] Estudar SQL focado nas necessidades do projeto

\- \[ ] Revisar query da live amanhã com base nova

\- \[ ] Preparar perguntas para próxima live

