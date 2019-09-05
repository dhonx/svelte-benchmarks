<script>
  export let day;
</script>

<div class="uptime-day">
    <!-- title={day.number + ': ' + (day.up ? 'Servers operational!' : 'Red alert!')}  -->
  <span 
    class="uptime-day-status" 
    title="{day.number}: {day.up ? 'Servers operational!' : 'Red alert!'}"
    style="background-color: {day.up ? '#8cc665' : '#ccc'}" >
  </span>
  <!-- <span class="hover"></span> -->
</div>
