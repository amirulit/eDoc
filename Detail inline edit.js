<table class="table table-bordered table-striped" id="tblSanctionDetails">
    <thead>
        <tr>
            <th>SL</th>
            <th>Customer Code</th>
            <th>Customer Name</th>
            <th>Loan Nature</th>
            <th>Currency</th>
            <th>Amount</th>
            <th>Validity</th>
            <th style="width:130px;">Action</th>
        </tr>
    </thead>
    <tbody id="tbodySanctionDetails"></tbody>
</table>



function createSelect(selector, selectedValue, className) {

    var select = $(selector).clone();

    select.removeAttr("id");
    select.removeAttr("name");
    select.removeClass("select2-hidden-accessible");
    select.removeAttr("data-select2-id");
    select.removeAttr("tabindex");
    select.removeAttr("aria-hidden");

    select.next(".select2-container").remove();

    select.addClass("form-control " + className);
    select.css("width", "100%");

    select.val(selectedValue);

    return select;
}


function renderSanctionDetails(details) {

    $("#tbodySanctionDetails").empty();

    $.each(details, function (i, item) {

        var tr = $("<tr>").attr("data-id", item.id);

        $("<td>").text(i + 1).appendTo(tr);
        $("<td>").text(item.customer_id).appendTo(tr);
        $("<td>").text(item.customer_name).appendTo(tr);
        $("<td>").text(item.loan_nature_name).appendTo(tr);
        $("<td>").text(item.currency).appendTo(tr);
        $("<td>").text(Number(item.amount).toLocaleString()).appendTo(tr);
        $("<td>").text(item.validity).appendTo(tr);

        // Action buttons
        $("<td>").append(
            $("<button>", {
                type: "button",
                class: "btn btn-primary btn-xs btnEditDetail",
                html: '<i class="fa fa-edit"></i> Edit'
            }),
            " ",
            $("<button>", {
                type: "button",
                class: "btn btn-danger btn-xs btnDeleteDetail",
                html: '<i class="fa fa-trash"></i> Delete'
            })
        ).appendTo(tr);

        tr.data("original", item);

        $("#tbodySanctionDetails").append(tr);

    });
}

renderSanctionDetails(data.Details);



$(document).on("click", ".btnEditDetail", function () {

    var tr = $(this).closest("tr");

    var item = tr.data("original");

    // Customer Code
    var customerSelect = createSelect(
        "#ddlCustomerCode",
        item.customer_id,
        "editCustomer"
    );

    // Loan Nature
    var loanSelect = createSelect(
        "#ddlLoanNature",
        item.loan_nature,
        "editLoanNature"
    );

    // Currency
    var currencySelect = createSelect(
        "#ddlCurrency",
        item.currency,
        "editCurrency"
    );

    // Customer Name
    var customerName = item.customer_name;

    tr.find("td:eq(1)").empty().append(customerSelect);

    tr.find("td:eq(2)").text(customerName);

    tr.find("td:eq(3)").empty().append(loanSelect);

    tr.find("td:eq(4)").empty().append(currencySelect);

    // Amount
    tr.find("td:eq(5)").empty().append(
        $("<input>", {
            type: "number",
            class: "form-control editAmount",
            value: item.amount
        })
    );

    // Validity
    tr.find("td:eq(6)").empty().append(
        $("<input>", {
            type: "date",
            class: "form-control editValidity",
            value: item.validity
        })
    );

    // Action buttons
    tr.find("td:eq(7)").empty().append(
        $("<button>", {
            type: "button",
            class: "btn btn-success btn-xs btnSaveDetail",
            html: '<i class="fa fa-save"></i> Save'
        }),
        " ",
        $("<button>", {
            type: "button",
            class: "btn btn-default btn-xs btnCancelEdit",
            text: "Cancel"
        })
    );

});


$(document).on("change", ".editCustomer", function () {

    var customerName = $(this).find("option:selected").text();

    $(this).closest("tr").find("td:eq(2)").text(customerName);

});



$(document).on("click", ".btnCancelEdit", function () {

    var tr = $(this).closest("tr");

    var item = tr.data("original");

    // Restore original row
    tr.find("td:eq(1)").text(item.customer_id);
    tr.find("td:eq(2)").text(item.customer_name);
    tr.find("td:eq(3)").text(item.loan_nature_name);
    tr.find("td:eq(4)").text(item.currency);
    tr.find("td:eq(5)").text(Number(item.amount).toLocaleString());
    tr.find("td:eq(6)").text(item.validity);

    tr.find("td:eq(7)").empty().append(
        $("<button>", {
            type: "button",
            class: "btn btn-primary btn-xs btnEditDetail",
            html: '<i class="fa fa-edit"></i> Edit'
        }),
        " ",
        $("<button>", {
            type: "button",
            class: "btn btn-danger btn-xs btnDeleteDetail",
            html: '<i class="fa fa-trash"></i> Delete'
        })
    );

});

$(document).on("click", ".btnSaveDetail", function () {

    var tr = $(this).closest("tr");

    var item = tr.data("original");

    var customerSelect = tr.find(".editCustomer");

    var customerCode = customerSelect.val();
    var customerName = customerSelect.find("option:selected").text();

    var loanNature = tr.find(".editLoanNature").val();
    var loanNatureName = tr.find(".editLoanNature option:selected").text();

    var currency = tr.find(".editCurrency").val();

    var amount = tr.find(".editAmount").val();
    var validity = tr.find(".editValidity").val();

    if (!customerCode || !loanNature || !currency || !amount || !validity) {
        alert("Please fill in all fields.");
        return;
    }

    if (Number(amount) <= 0 || !Number.isFinite(Number(amount))) {
        alert("Please enter a valid amount.");
        return;
    }

    $.ajax({

        type: "POST",

        url: "SanctionUpload_V4.aspx/UpdateDetail",

        data: JSON.stringify({
            id: item.id,
            customer_id: customerCode,
            customer_name: customerName,
            loan_nature: loanNature,
            loan_nature_name: loanNatureName,
            currency: currency,
            amount: amount,
            validity: validity
        }),

        contentType: "application/json; charset=utf-8",

        dataType: "json",

        success: function (response) {

            if (response.d === "success") {

                alert("Detail updated successfully.");

                // Update local original data
                item.customer_id = customerCode;
                item.customer_name = customerName;
                item.loan_nature = loanNature;
                item.loan_nature_name = loanNatureName;
                item.currency = currency;
                item.amount = amount;
                item.validity = validity;

                tr.data("original", item);

                // Refresh display
                tr.find("td:eq(1)").text(customerCode);
                tr.find("td:eq(2)").text(customerName);
                tr.find("td:eq(3)").text(loanNatureName);
                tr.find("td:eq(4)").text(currency);
                tr.find("td:eq(5)").text(Number(amount).toLocaleString());
                tr.find("td:eq(6)").text(validity);

                tr.find("td:eq(7)").empty().append(
                    $("<button>", {
                        type: "button",
                        class: "btn btn-primary btn-xs btnEditDetail",
                        html: '<i class="fa fa-edit"></i> Edit'
                    }),
                    " ",
                    $("<button>", {
                        type: "button",
                        class: "btn btn-danger btn-xs btnDeleteDetail",
                        html: '<i class="fa fa-trash"></i> Delete'
                    })
                );

            }
            else {
                alert(response.d);
            }

        },

        error: function (xhr) {

            console.log(xhr.responseText);

            alert("Unable to update detail.");

        }

    });

});


[WebMethod]
public static string UpdateDetail(
    int id,
    string customer_id,
    string customer_name,
    string loan_nature,
    string loan_nature_name,
    string currency,
    string amount,
    string validity)
{
    string cs = ConfigurationManager
        .ConnectionStrings["dbConn"].ConnectionString;

    using (SqlConnection con = new SqlConnection(cs))
    {
        using (SqlCommand cmd = new SqlCommand(
            "dbo.usp_UpdateSanctionDetail", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;

            cmd.Parameters.Add("@customer_id", SqlDbType.VarChar, 50).Value = customer_id;

            cmd.Parameters.Add("@customer_name", SqlDbType.VarChar, 200).Value = customer_name;

            cmd.Parameters.Add("@loan_nature", SqlDbType.VarChar, 50).Value = loan_nature;

            cmd.Parameters.Add("@loan_nature_name", SqlDbType.VarChar, 200).Value = loan_nature_name;

            cmd.Parameters.Add("@currency", SqlDbType.VarChar, 10).Value = currency;

            cmd.Parameters.Add("@amount", SqlDbType.Decimal).Value =
                Convert.ToDecimal(amount);

            cmd.Parameters.Add("@validity", SqlDbType.Date).Value =
                Convert.ToDateTime(validity);

            con.Open();

            int result = cmd.ExecuteNonQuery();

            return result > 0 ? "success" : "Unable to update record";
        }
    }
}

