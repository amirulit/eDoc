DECLARE @drawdown_id INT = 291;

;WITH D AS
(
    SELECT
        Drawdown_Id,
        PKNo,
        Value01,
        Value02,
        Value03,
        Value04,
        CreatedOn,

        CASE PKNo
            WHEN 7   THEN 'Approval Authority'
            WHEN 43  THEN 'Deed Number (Numeric)'
            WHEN 44  THEN 'Original/Certified/Photocopy'
            WHEN 45  THEN 'Deed Number (Numeric)'
            WHEN 46  THEN 'Deed Number (Numeric)'
            WHEN 49  THEN 'Deed Number (Numeric)'
            WHEN 53  THEN 'Khatian Number (Numeric)'
            WHEN 62  THEN 'Valuation Company'
            WHEN 74  THEN 'Deed Number (Numeric)'
            WHEN 80  THEN 'Original/Certified'
            WHEN 82  THEN 'Original/Certified'
            WHEN 85  THEN 'Deed Number (Numeric)'
            WHEN 86  THEN 'Deed Number (Numeric)'
            WHEN 143 THEN 'Submission Number (Numeric)'
            WHEN 145 THEN 'Submission Number (Numeric)'
            WHEN 186 THEN 'Guarantor Company (Alphanumeric)'
            WHEN 211 THEN 'E-GAI Name'
        END AS H1,

        CASE PKNo
            WHEN 7   THEN 'Expiry'
            WHEN 43  THEN 'Date'
            WHEN 44  THEN 'Deed Number (Numeric)'
            WHEN 45  THEN 'Date'
            WHEN 46  THEN 'Date'
            WHEN 49  THEN 'Date'
            WHEN 53  THEN 'DCR Number (Numeric)'
            WHEN 62  THEN 'Date'
            WHEN 74  THEN 'Date'
            WHEN 80  THEN 'Deed Number'
            WHEN 82  THEN 'Deed Number'
            WHEN 85  THEN 'Date'
            WHEN 86  THEN 'Date'
            WHEN 143 THEN 'Date'
            WHEN 145 THEN 'Date'
            WHEN 211 THEN 'Expiry'
        END AS H2,

        CASE PKNo
            WHEN 44  THEN 'Date (Calendar)'
            WHEN 45  THEN 'SRO'
            WHEN 53  THEN 'DCR Page Number (Numeric)'
            WHEN 74  THEN 'Previous Bank'
            WHEN 80  THEN 'Date (Calendar)'
            WHEN 82  THEN 'Date (Calendar)'
            WHEN 85  THEN 'Amount (Numeric)'
            WHEN 86  THEN 'Amount (Numeric)'
            WHEN 143 THEN 'Amount (Numeric)'
            WHEN 145 THEN 'Amount (Numeric)'
            WHEN 211 THEN 'Rating'
        END AS H3,

        CASE PKNo
            WHEN 45 THEN 'Deed Delivery Date (Expected)'
            WHEN 74 THEN 'Previous Branch'
            WHEN 80 THEN 'Withdrawal Date'
            WHEN 82 THEN 'Withdrawal Date'
        END AS H4

    FROM PK_Details
    WHERE Drawdown_Id = @drawdown_id
),

HTMLData AS
(
    SELECT
        Drawdown_Id,
        PKNo,

        '<table border="1" cellpadding="5" cellspacing="0"
            style="border-collapse:collapse;width:100%;">' +

        '<thead><tr style="background-color:#92D050;">' +
        '<th>Primary Key No.</th>' +
        '<th>' + ISNULL(MAX(H1),'') + '</th>' +
        '<th>' + ISNULL(MAX(H2),'') + '</th>' +
        '<th>' + ISNULL(MAX(H3),'') + '</th>' +
        '<th>' + ISNULL(MAX(H4),'') + '</th>' +
        '</tr></thead><tbody>' +

        (
            SELECT
                '<tr>' +
                '<td>' + CAST(PKNo AS VARCHAR(10)) + '</td>' +
                '<td>' + ISNULL(Value01,'') + '</td>' +
                '<td>' + ISNULL(Value02,'') + '</td>' +
                '<td>' + ISNULL(Value03,'') + '</td>' +
                '<td>' + ISNULL(Value04,'') + '</td>' +
                '</tr>'
            FROM D D2
            WHERE D2.Drawdown_Id = D1.Drawdown_Id
              AND D2.PKNo = D1.PKNo
            ORDER BY D2.CreatedOn
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)')

        + '</tbody></table>' AS HTMLData

    FROM D D1
    GROUP BY Drawdown_Id, PKNo
)

SELECT
    Drawdown_Id,
    PKNo,
    HTMLData
FROM HTMLData
ORDER BY PKNo;