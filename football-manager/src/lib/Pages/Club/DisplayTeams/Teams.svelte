<script>
  export let id;
  let teams = [];

  import DisplayAllTeams from "./DisplayAllTeams.svelte";
  import ClubNavBar from "../clubNavBar.svelte";

  let fetchTeams = fetch(`http://localhost:8080/club/${id}/teams`)
    .then((res) => {
      return res.json();
    })
    .then((data) => {
      console.log(data);
      if (Array.isArray(data.teams)) {
        teams = data.teams;
      }
    })
    .catch((error) => {
      console.error(error);
    });
</script>

<ClubNavBar {id} />
<DisplayAllTeams {teams} />
