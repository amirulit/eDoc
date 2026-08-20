/*----------------------------------------------------------------
AUTHOR:         MD. KHABIR UDDIN
PURPOSE:        GET THE CALENDAR CONTROL.
PREREQUISITES:  jQuery REFERENCE MUST BE AVAILABE IN THE PAGE..
PARAMETER DESC: 
calendarID: TextBox ID.
DATE:       NOVEMBER 27, 2010. 
-----------------------------------------------------------------*/

var getCalendar = function (calendarID) {
    var id = '#' + calendarID;
    
    $(id).datepicker({
        altField: '#actualDate', //The jQuery selector for another field that is to be updated with the selected date from the datepicker.
        altFormat: 'DD, d MM, yy', //Formatting for altField
        //appendText: 'DD/MM/YYYY', //Show hint of date format/// <reference path="../Menu/Thumbs.db" />

        buttonImage: 'calenderIcon.gif', //Display icon
        buttonImageOnly: true, //Enable icon click
        changeMonth: true, //Display month drop down
        changeYear: true, //Display year drop down
        currentText: 'Now',
        dateFormat: 'dd/mm/yy', //Display date format - localDateFormat variable value is set from code behind based on current culture... This variable is declared in master page.
        duration: 'slow', //Setup the animation speed
        maxDate: '+10Y +0M +0D', //Add maximum date restriction
        minDate: '-63Y -11M -0D', //Add minimum date restriction
        showButtonPanel: true,
        showOn: 'both', //Attach click to both input and button if 'both' anything will work
        showOtherMonths: true, //Show other months date
        selectOtherMonths: true, //Allow to select date from other months
        yearRange: '1950:2099', //Setup the year rangemm/dd/yy
        beforeShow: function (input, inst) { //Can be a function that takes an input field and current datepicker instance and returns an options object to update the datepicker with.
            //alert('Before show method.');
        },
        onChangeMonthYear: function (year, month, inst) { //Allows you to define your own event when the datepicker moves to a new month and/or year.
            //alert(year + ", " + month);
        },
        onClose: function (dateText, inst) { //Allows you to define your own event when the datepicker is closed, whether or not a date is selected.
            //alert('Closing.');
        },
        onSelect: function (dateText, inst) { //Allows you to define your own event when the datepicker is selected.
            //alert('You selected: ' + dateText);
        }
    });
}