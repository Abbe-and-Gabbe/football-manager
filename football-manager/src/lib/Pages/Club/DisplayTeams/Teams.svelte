<script>
  export let id;
  let teams

  import DisplayAllTeams from "./DisplayAllTeams.svelte";
  import ClubNavBar from "../clubNavBar.svelte";

  let fetchTeams = fetch(`http://localhost:8080/club/${id}/teams`)
    fetchTeams.then((res) => {
        return res.json()
    }).then((data) => {
        teams = data
        })



</script>

<ClubNavBar {id} />
<DisplayAllTeams teams = {teams}/>

