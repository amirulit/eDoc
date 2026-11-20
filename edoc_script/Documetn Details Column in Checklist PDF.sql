DECLARE @drawdown_id INT = 291;

;WITH GroupData AS
(
    SELECT
        Drawdown_Id,
        PKNo,

        CASE
            WHEN PKNo = 7 THEN
                '<table border="1" cellpadding="5" cellspacing="0">
                 <thead>
                    <tr>
                        <th>Office</th>
                        <th>Date</th>
                    </tr>
                 </thead><tbody>'

            WHEN PKNo = 143 THEN
                '<table border="1" cellpadding="5" cellspacing="0">
                 <thead>
                    <tr>
                        <th>Number</th>
                        <th>Date</th>
                        <th>Amount</th>
                    </tr>
                 </thead><tbody>'

            WHEN PKNo = 186 THEN
                '<table border="1" cellpadding="5" cellspacing="0">
                 <thead>
                    <tr>
                        <th>Description</th>
                    </tr>
                 </thead><tbody>'

            ELSE
                '<table border="1"><thead><tr><th>Value01</th>
                <th>Value02</th><th>Value03</th>
                <th>Value04</th></tr></thead><tbody>'
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


select * from GroupData


SELECT
    Drawdown_Id,
    PKNo,

    MAX(HTMLHeader) +
    STRING_AGG(CAST(HTMLRow AS NVARCHAR(MAX)), '')
        WITHIN GROUP (ORDER BY CreatedOn) +
    '</tbody></table>' AS HTMLData

FROM GroupData
GROUP BY Drawdown_Id, PKNo
ORDER BY PKNo;