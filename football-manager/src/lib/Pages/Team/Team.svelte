<script>
    import TeamNavbar from "./TeamNavbar.svelte";
    import TeamNews from "./TeamNews.svelte";
    export let id
    let team

    const f = fetch(`http://localhost:8080/team/${id}`)

    f.then((res) => {
        return res.json()
    }).then((data) => {
        team = data
        console.log(data)
    })
</script>

<TeamNavbar id={id}/>
<TeamNews id={id} />