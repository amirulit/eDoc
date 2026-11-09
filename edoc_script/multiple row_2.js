// Optional: Clear the array first if you want to fresh-load it from the table
loans = []; 

// Iterate through each row in the table body
$("#tblLoans tbody tr").each(function () {
    var $row = $(this);

    // Extract text from specific columns based on your renderTable structure:
    var customerCode = $row.find("td:eq(1)").text().trim();
    var loanNature = $row.find("td:eq(2)").text().trim();
    var amountText = $row.find("td:eq(3)").text().trim();
    var validity = $row.find("td:eq(4)").text().trim();

    // Convert the amount string back to a float (removes commas if formatting added them)
    var amount = parseFloat(amountText.replace(/,/g, "")) || 0;

    // Push the structured object into your loans array
    loans.push({
        CustomerCode: customerCode,
        LoanNature: loanNature,
        Amount: amount,
        Validity: validity
    });
});

// Optional: Call renderTable if you want to redraw/refresh it
renderTable();