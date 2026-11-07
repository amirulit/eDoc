var table = $('#example').DataTable();
var selectedIds = [];



$(document).on('change', '.bulk', function () {

    var id = $(this).val();

    if ($(this).is(':checked')) {

        if (!selectedIds.includes(id)) {
            selectedIds.push(id);
        }

    } else {

        selectedIds = selectedIds.filter(function (item) {
            return item !== id;
        });

    }

    $('#Button2').toggle(selectedIds.length > 0);

});

table.on('draw', function () {

    $('.bulk').each(function () {

        $(this).prop('checked', selectedIds.includes($(this).val()));

    });

    $('#Button2').toggle(selectedIds.length > 0);

});



$('#Button2').click(function () {

    console.log(selectedIds);

});