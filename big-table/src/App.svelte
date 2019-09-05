<script>
  import { onMount, tick } from 'svelte';

  let cols = COLS;
  let rows = ROWS;
  let optimized = OPTIMIZED;
  let msg = 'loading...';
  let grid = window.grid;
  let filter = '';

  onMount(async () => {
    console.profileEnd('a');
    await tick();
    msg = 'initial render took: ' + (window.performance.now() - s).toFixed(2) + 'ms';
  });

  function matches(item) {
    item = item;
    return item.value.toLowerCase().indexOf(filter.toLowerCase()) > -1;
  }

  function visibleCount() {
    let count = 0;
    const _grid = grid;
    for (let i = 0, l = _grid.length; i < l; i++) {
      let row = _grid[i].items;
      for (let j = 0, k = row.length; j < k; j++) {
        const item = row[j];
        const matched = !filter || matches(item);
        if (matched) count++;
      }
    }
    return count;
  }

  function loadBase() {
    window.location.hash = '';
  }

  function loadOptimized() {
    window.location.hash = '#optimized';
  }

  async function rerender() {
    grid = generateGrid(rows, cols);
    const s = window.performance.now();
    await tick();
    msg = `${filter ? 'filter' : 'rerender'} took: ${(window.performance.now() - s).toFixed(2)} ms`;
    console.profileEnd('rerender');
  }

  async function unmount() {
    console.profile('unmount');
    const s = window.performance.now();
    grid = [];
    await tick();
    msg = `umount took: ${(window.performance.now() - s).toFixed(2)} ms`;
    console.profileEnd('unmount');
  }

  $: dataPoints = grid && typeof grid[0] === 'object' ? grid.length * grid[0].items.length : 0;
  $: visibleCountResult = !filter ? 0 : visibleCount();
</script>

<p>
  <span>{rows} x {cols}, {optimized ? 'with' : 'without'} optimization. {msg}</span>
</p>

<p>
  {#if optimized}
    <button on:click={loadBase}>Disable optimization</button>
  {:else}
    <button on:click={loadOptimized}>Enable optimization (Object.freeze)</button>
  {/if}
  <button on:click={unmount}>Unmount</button>
  <button on:click={rerender}>Rerender with fresh data</button>
</p>

<form>
  <strong>Filter Data</strong>
  :
  <input type="text" bind:value={filter} />

  {#if filter}
    <span>
      &mdash; Filtering
      <strong>{filter}</strong>
      over {dataPoints} data points, {visibleCountResult} found.
    </span>
  {/if}

</form>

<table width="100%" cellspacing="0" class={filter ? 'filtered' : ''}>
  {#each grid as row}
    <tr>
      <th>{row.id}</th>
      {#each row.items as item}
        <td class="item {!(item.value.toLowerCase().indexOf(filter.toLowerCase()) > -1) ? 'hidden' : ''}">
          {item.value}
        </td>
      {/each}
    </tr>
  {/each}
</table>
