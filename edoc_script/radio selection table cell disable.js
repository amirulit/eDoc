  <script type="text/javascript">

         $(function () {


             $(document).ready(function () {

                 function checkRow(row) {

                     var selected = row.find('input.rdo:checked').length > 0;

                     if (selected) {
                         row.removeClass('row-disabled');

                         row.find('td:not(:nth-child(3))')
               .find('input, select, textarea, button')
               .prop('disabled', false);

                     } else {
                         row.addClass('row-disabled');

                         row.find('td:not(:nth-child(3))')
               .find('input, select, textarea, button')
               .prop('disabled', true);
                     }
                 }

                 // Check all rows on page load
                 $('tr[id^="row_"]').each(function () {
                     checkRow($(this));
                 });

                 // When Yes/No radio changes
                 $(document).on('change', '.rdo', function () {
                     checkRow($(this).closest('tr'));
                 });

             });
         });

    </script>
	
	
	
    <style>
    
    
    .row-disabled td:not(:nth-child(3)) {
    background-color: #e5e5e5 !important;
    color: #999;
}

.row-disabled td:not(:nth-child(3)) input,
.row-disabled td:not(:nth-child(3)) select,
.row-disabled td:not(:nth-child(3)) textarea,
.row-disabled td:not(:nth-child(3)) button {
    pointer-events: none;
    opacity: 0.5;
}
    
    </style>