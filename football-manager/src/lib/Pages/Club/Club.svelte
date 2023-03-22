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
        })



</script>

<ClubNavBar {id} />
<WelcomePage club={club}/>
<ClubCardContent id={id}  />
