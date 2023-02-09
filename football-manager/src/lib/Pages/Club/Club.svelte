<script>
    export let id;
    import teams from "../../../assets/data";
    import WelcomePage from "./WelcomePage.svelte";
    import ClubNavBar from "./clubNavBar.svelte";

    import ClubCardContent from "./clubCardContent.svelte";
    let team = teams.find((item) => item.id == id);
</script>

<ClubNavBar id="{id}" />
<WelcomePage/>
<ClubCardContent/>