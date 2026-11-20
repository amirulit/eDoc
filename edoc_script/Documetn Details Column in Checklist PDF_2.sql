DECLARE @drawdown_id INT = 291;

;WITH GroupData AS
(
    SELECT
        Drawdown_Id,
        PKNo,

        CASE
            WHEN PKNo = 7 THEN
                '<table border="1" cellpadding="5">
                 <tr><th>Office</th><th>Date</th></tr>'

            WHEN PKNo = 143 THEN
                '<table border="1" cellpadding="5">
                 <tr><th>Number</th><th>Date</th><th>Amount</th></tr>'

            WHEN PKNo = 186 THEN
                '<table border="1" cellpadding="5">
                 <tr><th>Description</th></tr>'

            ELSE
                '<table border="1" cellpadding="5">
                 <tr><th>Value01</th><th>Value02</th>
                 <th>Value03</th><th>Value04</th></tr>'
        END AS HTMLHeader,

        CASE
            WHEN PKNo = 7 THEN
                '<tr><td>' + ISNULL(Value01, '') +
                '</td><td>' + ISNULL(Value02, '') + '</td></tr>'

            WHEN PKNo = 143 THEN
                '<tr><td>' + ISNULL(Value01, '') +
                '</td><td>' + ISNULL(Value02, '') +
                '</td><td>' + ISNULL(Value03, '') + '</td></tr>'

            WHEN PKNo = 186 THEN
                '<tr><td>' + ISNULL(Value01, '') + '</td></tr>'

            ELSE
                '<tr><td>' + ISNULL(Value01, '') +
                '</td><td>' + ISNULL(Value02, '') +
                '</td><td>' + ISNULL(Value03, '') +
                '</td><td>' + ISNULL(Value04, '') + '</td></tr>'
        END AS HTMLRow,

        CreatedOn

    FROM PK_Details
    WHERE Drawdown_Id = @drawdown_id
)

SELECT
    G.Drawdown_Id,
    G.PKNo,

    MAX(G.HTMLHeader) +

    (
        SELECT G2.HTMLRow
        FROM GroupData G2
        WHERE G2.Drawdown_Id = G.Drawdown_Id
          AND G2.PKNo = G.PKNo
        ORDER BY G2.CreatedOn
        FOR XML PATH(''), TYPE
    ).value('.', 'NVARCHAR(MAX)')

    + '</table>' AS HTMLData

FROM GroupData G

GROUP BY
    G.Drawdown_Id,
    G.PKNo

ORDER BY G.PKNo;