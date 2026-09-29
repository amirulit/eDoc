<table id="tblData" class="table">
    <tr data-id="101">
        <td>Account 101</td>
        <td>
            <input type="radio" name="status_101" value="Yes"> Yes
            <input type="radio" name="status_101" value="No"> No
        </td>
    </tr>

    <tr data-id="102">
        <td>Account 102</td>
        <td>
            <input type="radio" name="status_102" value="Yes"> Yes
            <input type="radio" name="status_102" value="No"> No
        </td>
    </tr>

    <tr data-id="103">
        <td>Account 103</td>
        <td>
            <input type="radio" name="status_103" value="Yes"> Yes
            <input type="radio" name="status_103" value="No"> No
        </td>
    </tr>
</table>

<button type="button" id="btnSave">Save</button>

$("#btnSave").click(function () {

    var data = [];
    var hasUnselected = false;

    $("#tblData tr[data-id]").each(function () {

        var row = $(this);
        var uniqueId = row.data("id");

        var selected = row.find("input[type='radio']:checked");

        // Nothing selected
        if (selected.length === 0) {

            hasUnselected = true;

            // Highlight row
            row.css("background-color", "#ffe6e6");

        } else {

            // Remove previous highlight
            row.css("background-color", "");

            data.push({
                id: uniqueId,
                option: selected.val()
            });
        }
    });

    // If any row is unselected
    if (hasUnselected) {
        alert("Please select Yes or No for all rows.");
        return;
    }

    // All rows selected
    console.log(data);

    // Example result:
    // [
    //    { id: 101, option: "Yes" },
    //    { id: 102, option: "No" },
    //    { id: 103, option: "Yes" }
    // ]

    // Now send data to server
    // $.ajax({...});
});


$("#tblData").on("change", "input[type='radio']", function () {
    $(this).closest("tr").css("background-color", "");
});




***************************************************


<input type="radio" name="status_101" value="Yes" done>
<input type="radio" name="status_101" value="No" done>


$("#btnSave").click(function () {

    var data = [];
    var hasUnselected = false;

    $("#tblData tr[data-id]").each(function () {

        var row = $(this);
        var uniqueId = row.data("id");

        // Skip row if its radio buttons have 'done' attribute
        if (row.find("input[type='radio'][done]").length > 0) {
            return;
        }

        var selected = row.find("input[type='radio']:checked");

        if (selected.length === 0) {

            hasUnselected = true;
            row.css("background-color", "#ffe6e6");

        } else {

            row.css("background-color", "");

            data.push({
                id: uniqueId,
                option: selected.val()
            });
        }
    });

    if (hasUnselected) {
        alert("Please select Yes or No for all rows.");
        return;
    }

    console.log(data);
});


if (row.is("[done]")) {
    return;
}



if (row.find("input[type='radio']:checked[done]").length > 0) {
    return;
}



**************************************

$("#tblData tr[data-id='101']").attr("done", "true");


$("#tblData tr[data-id]").each(function () {

    var row = $(this);

    // Skip completed row
    if (row.is("[done]")) {
        return;
    }

    // Process Yes/No radios...
});


**********************************

<tr data-id="101">
    <td>Account 101</td>
    <td>
        <input type="radio" name="status_101" value="Yes"> Yes
        <input type="radio" name="status_101" value="No"> No
    </td>
    <td>
        <button type="button" class="btnDone">Done</button>
    </td>
</tr>



$("#tblData").on("click", ".btnDone", function () {

    var row = $(this).closest("tr");

    row.attr("done", "true");

});


<tr data-id="101" done="true">




$("#tblData tr[data-id]").each(function () {

    var row = $(this);

    if (row.is("[done]")) {
        return; // skip this row
    }

    // Check Yes/No...
});





$("#tblData").on("click", ".btnDone", function () {

    var button = $(this);
    var row = button.closest("tr");

    row.attr("done", "true");
    button.text("Completed");
    button.prop("disabled", true);
});



******************************************************



<tr data-id="101">
    <td>
        <input type="radio" class="statusRadio" name="status_101" value="Yes">
        Yes

        <input type="radio" class="statusRadio" name="status_101" value="No">
        No
    </td>
</tr>

<tr data-id="102">
    <td>
        <input type="radio" class="statusRadio" name="status_102" value="Yes">
        Yes

        <input type="radio" class="statusRadio" name="status_102" value="No">
        No
    </td>
</tr>


var unselected = [];

$("#tblData tr[data-id]").each(function () {

    var row = $(this);

    // Skip completed rows
    if (row.is("[done]")) {
        return;
    }

    var selected = row.find(".statusRadio:checked");

    if (selected.length === 0) {
        unselected.push(row.data("id"));
        row.css("background-color", "#ffe6e6");
    }
});

console.log(unselected);


var result = [];

$("#tblData tr[data-id]").each(function () {

    var row = $(this);

    if (row.is("[done]")) {
        return;
    }

    var selected = row.find(".statusRadio:checked");

    if (selected.length === 0) {
        row.css("background-color", "#ffe6e6");
        return;
    }

    result.push({
        id: row.data("id"),
        option: selected.val()
    });
});

console.log(result);







***********************************



