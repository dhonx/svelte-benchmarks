<script>
  import ServerUptime from './ServerUptime.svelte';

  export let fps = 0;
  export let playing = false;
  export let servers = Object.freeze(generateServers());

  function toggle() {
    playing = !playing;
    if (playing) {
      update();
    } else {
      clearTimeout(timeoutId);
    }
  }
</script>

<svelte:options accessors />

<p>FPS: {fps}</p>

<button on:click={toggle}>{playing ? 'pause' : 'play'}</button>

{#each servers as server}
  <ServerUptime name={server.name} days={server.days} />
{/each}
