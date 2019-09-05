<script>
  import UptimeDay from './UptimeDay.svelte';

  export let name;
  export let days = [];

  $: upDays = days.reduce(function(upDays, day) {
    return (upDays += day.up ? 1 : 0);
  }, 0);
  $: streak = days.reduce(
    ([max, streak], day) => {
      if (day.up && streak + 1 > max) {
        return [streak + 1, streak + 1];
      } else if (day.up) {
        return [max, streak + 1];
      } else {
        return [max, 0];
      }
    },
    [0, 0]
  );
</script>

<div class="server-uptime">
  <h2>{name}</h2>
  <h3>{upDays} Days Up</h3>
  <h4>Biggest Streak: {streak[0]}</h4>
  <h4>Lowest Streak: {streak[1]}</h4>
  <div class="days">
    {#each days as day}
      <UptimeDay {day} />
    {/each}
  </div>
</div>
