<script>
	import { onMount } from 'svelte'
	const endpoint = "http://localhost:8080/";
	let name = "lucas"
	let sentence = null


	async function getResponse() {
		const response = await fetch(endpoint + name)
    	const text = await response.text()
		sentence = text
	}

	async function onClickGetResponse() {
        await getResponse()
    }
</script>

<input bind:value={name}>

<button on:click={onClickGetResponse}>
	Get Hello
</button>

{#if sentence != null}
  {#await sentence}
    <p>...waiting</p>
  {:then sentence}
    <p>{sentence}</p>
  {:catch error}
    <p style="color: red">{error.message}</p>
  {/await}
{/if}