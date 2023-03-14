<script>
    import TeamNavbar from "./TeamNavbar.svelte";
    import TeamNews from "./TeamNews.svelte";
    export let id
</script>

<TeamNavbar id={id}/>
<TeamNews id={id} />