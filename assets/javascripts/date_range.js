var checkbox = document.getElementById('time_entry_date_range');
var details_div = document.getElementById('time_entry_spent_to');
checkbox.onchange = function() {
   if(this.checked) {
     details_div.style['display'] = 'block';
   } else {
     details_div.style['display'] = 'none';
   }
};
