<script lang="ts" context="module">
  export type Color = 'transparent-primary' | 'transparent-gray';
</script>

<script lang="ts">
  import Button from './button.svelte';

  export let color: Color = 'transparent-gray';
  export let disabled = false;
  export let fullwidth = false;
</script>

<Button size="link" {color} shadow={false} rounded="lg" {disabled} on:click {fullwidth}>
  <slot />
</Button>
