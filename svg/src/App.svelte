<script>
  import { onMount } from "svelte";

  let model = createModel(1000);
  let optimized = false;

  onMount(() => {
    requestAnimationFrame(render);
    stats.begin();

    function render() {
      stats.end();
      stats.begin();
      requestAnimationFrame(render);
      model.step();
    }
  });

  function toggleOptimization() {
    model = optimized ? createModel(1000) : Object.freeze(createModel(1000));
    optimized = !optimized;
  }
</script>

<p>
  <button on:click={toggleOptimization}>
    {optimized ? 'disable' : 'enable'} optimization (Object.freeze)
  </button>
</p>
<svg>
  {#if optimized}
    {#each model.points as point}
      <circle cx={point.x} cy={point.y} r="2px" fill="#FC309D" />
    {/each}
  {:else}
    {#each model.points as point}
      <circle cx={point.x} cy={point.y} r="2px" fill="#FC309D" />
    {/each}
  {/if}
</svg>
