<script>
  export let id;
  import DtNavbar from "./DTNavbar.svelte";
  import DisplayAllTeams from "./DisplayAllTeams.svelte";
  import ClubNavBar from "../Club/clubNavBar.svelte";

</script>

<ClubNavBar {id} />
<DisplayAllTeams/>

