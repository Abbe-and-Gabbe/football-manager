<script>
    export let id;
    import WelcomePage from "./WelcomePage.svelte";
    import ClubNavBar from "./clubNavBar.svelte";

    import ClubCardContent from "./clubCardContent.svelte";
    let club
    let news

    let f = fetch(`http://localhost:8080/club/${id}`)
    f.then((res) => {
        return res.json()
    }).then((data) => {
        club = data.club
    })

    



    let n = fetch(`http://localhost:8080/club/${id}/news`)
    n.then((res) => {
        return res.json()
    }).then((data) => {
        news = data.news
      

    })


</script>

<ClubNavBar {id} />
{#if club}
    <WelcomePage club={club} />
{/if}
{#if news}
    <ClubCardContent news={news}  />
{/if}