<script>
  export let id;
  let games = [];
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
</script>

<ClubNavBar {id} />
<Calendar {games} />
