<script>
  export let id;
  let games = [];
  let active = [];
  import Calendar from "../../../Components/Calendar.svelte";
  import ClubNavBar from "../clubNavBar.svelte";

  const fetchGames = fetch(`http://localhost:8080/club/${id}/games`);
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

  const fetchActive = fetch(`http://localhost:8080/club/${id}/activities`);
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

<ClubNavBar {id} />
<Calendar {games} {active} />
