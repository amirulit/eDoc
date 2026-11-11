<div class="box box-info">
    <div class="box-header with-border">
        <h3 class="box-title">Master Information</h3>

        <div class="box-tools pull-right" id="masterAction">
            <button type="button" class="btn btn-primary btn-xs" id="btnEditMaster">
                <i class="fa fa-edit"></i> Edit
            </button>
        </div>
    </div>

    <div class="box-body">

        <div class="row">

            <div class="col-md-3">
                <label>eDoc ID</label>
                <p id="mEdocId"></p>
            </div>

            <div class="col-md-3">
                <label>Booking Branch</label>
                <p id="mBookingBranch"></p>
            </div>

            <div class="col-md-3">
                <label>Sanction Reference</label>
                <p id="mSanctionReference"></p>
            </div>

            <div class="col-md-3">
                <label>Sanction Date</label>
                <p id="mSanctionDate"></p>
            </div>

        </div>

        <div class="row">

            <div class="col-md-6">
                <label>Sanction Segment</label>
                <p id="mSanctionSegment"></p>
            </div>

            <div class="col-md-6">
                <label>Approval Authority</label>
                <p id="mApprovalAuthority"></p>
            </div>

        </div>

    </div>
</div>

var masterData = {};

$(document).on("click", "#btnEditMaster", function () {

    var m = masterData;

    // Booking Branch
    $("#mBookingBranch").empty().append(
        createSelect("#select3", m.booking_branch, "editBookingBranch")
    );

    // Sanction Reference
    $("#mSanctionReference").html(
        $("<input>", {
            type: "text",
            class: "form-control editSanctionReference",
            value: m.sanction_reference
        })
    );

    // Sanction Date
    $("#mSanctionDate").html(
        $("<input>", {
            type: "date",
            class: "form-control editSanctionDate",
            value: m.sanction_date
        })
    );

    // Sanction Segment
    $("#mSanctionSegment").empty().append(
        createSelect("#select2", m.sanction_segment, "editSanctionSegment")
    );

    // Approval Authority
    $("#mApprovalAuthority").empty().append(
        createSelect("#select1", m.sanction_approval_authority, "editApprovalAuthority")
    );

    // Change buttons
    $("#masterAction").html(`
        <button type="button" class="btn btn-success btn-xs" id="btnSaveMaster">
            <i class="fa fa-save"></i> Save
        </button>

        <button type="button" class="btn btn-default btn-xs" id="btnCancelMaster">
            Cancel
        </button>
    `);

});

$(document).on("click", "#btnCancelMaster", function () {

    renderMaster(masterData);

});


function renderMaster(m) {

    $("#mEdocId").text(m.edoc_id);

    $("#mBookingBranch").text(m.booking_branch_name || m.booking_branch);

    $("#mSanctionReference").text(m.sanction_reference);

    $("#mSanctionDate").text(m.sanction_date);

    $("#mSanctionSegment").text(m.sanction_segment_name || m.sanction_segment);

    $("#mApprovalAuthority").text(
        m.sanction_approval_authority_name || m.sanction_approval_authority
    );

    $("#masterAction").html(`
        <button type="button" class="btn btn-primary btn-xs" id="btnEditMaster">
            <i class="fa fa-edit"></i> Edit
        </button>
    `);

}


$(document).on("click", "#btnSaveMaster", function () {

    var m = masterData;

    var bookingBranch = $(".editBookingBranch").val();

    var sanctionReference = $(".editSanctionReference").val();

    var sanctionDate = $(".editSanctionDate").val();

    var sanctionSegment = $(".editSanctionSegment").val();

    var approvalAuthority = $(".editApprovalAuthority").val();

    if (!bookingBranch || !sanctionReference || !sanctionDate ||
        !sanctionSegment || !approvalAuthority) {

        alert("Please fill in all Master fields.");
        return;
    }

    $.ajax({

        type: "POST",

        url: "SanctionUpload_V4.aspx/UpdateMaster",

        data: JSON.stringify({
            edoc_id: m.edoc_id,
            booking_branch: bookingBranch,
            sanction_reference: sanctionReference,
            sanction_date: sanctionDate,
            sanction_segment: sanctionSegment,
            sanction_approval_authority: approvalAuthority
        }),

        contentType: "application/json; charset=utf-8",

        dataType: "json",

        success: function (response) {

            if (response.d === "success") {

                masterData.booking_branch = bookingBranch;
                masterData.sanction_reference = sanctionReference;
                masterData.sanction_date = sanctionDate;
                masterData.sanction_segment = sanctionSegment;
                masterData.sanction_approval_authority = approvalAuthority;

                // Refresh displayed Master
                renderMaster(masterData);

                alert("Master information updated successfully.");

            }
            else {

                alert(response.d);

            }

        },

        error: function (xhr) {

            console.log(xhr.responseText);

            alert("Unable to update Master information.");

        }

    });

});