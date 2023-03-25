
<script>
    import Calendar from "../../Components/Calendar.svelte";
  export let id;
  let games = [];
  let active = [];
    import TeamNavbar from "./TeamNavbar.svelte";

  const fetchGames = fetch(`http://localhost:8080/team/${id}/games`);
  fetchGames
    .then((res) => {
      return res.json();
    })
    .then((data) => {
      games = data;
      console.log(games);
    })
    .catch((error) => {
      console.error(error);
    });

  const fetchActive = fetch(`http://localhost:8080/team/${id}/activities`);
  fetchActive
    .then((res) => {
      return res.json();
    })
    .then((data) => {
      active = data;
      console.log(active);
    })
    .catch((error) => {
      console.error(error);
    });
</script>

<TeamNavbar {id} />
<Calendar {games} {active} />
