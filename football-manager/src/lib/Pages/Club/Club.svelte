<script>
    export let id;
    import WelcomePage from "./WelcomePage.svelte";
    import ClubNavBar from "./clubNavBar.svelte";

    import ClubCardContent from "./clubCardContent.svelte";
    let club


    let f = fetch(`http://localhost:8080/club/${id}`)
    f.then((res) => {
        return res.json()
    }).then((data) => {
        club = data.club
        console.log(club)
    })

</script>

<ClubNavBar {id} />
{#if club}
    <WelcomePage club={club} />
{/if}

<ClubCardContent id = {id}  />
