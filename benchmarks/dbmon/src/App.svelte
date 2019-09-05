<script>
  export let databases = [];
</script>

<svelte:options accessors />

<table class="table table-striped lastest-data">
  <tbody>
    {#each databases as db, $index}
      <tr>
        <td class="dbname">{db.dbname}</td>
        <td class="query-count">
          <span class={db.lastSample.countClassName}>{db.lastSample.nbQueries}</span>
        </td>
        {#each db.lastSample.topFiveQueries as q, $index}
          <td class="query {q.elapsedClassName}">
            {q.formatElapsed}
            <div class="popover left">
              <div class="popover-content">{q.query}</div>
              <div class="arrow" />
            </div>
          </td>
        {/each}
      </tr>
    {/each}
  </tbody>
</table>
