<script>
    export let id
    let games = [];
    let activities = [];
    import DisplayCalendar from "../../../Components/DisplayCalendar.svelte";
    import ClubNavBar from "../clubNavBar.svelte";

    const fetchGames = fetch(`http://localhost:8080/club/${id}/games`)
    .then((res) => {
      return res.json();
    })
    .then((data) => {
      console.log(data);
      if (Array.isArray(data.games)) {
        games = data.games;
      }
    })
    .catch((error) => {
      console.error(error);
    });

    const fetchFixtures = fetch(`http://localhost:3000/club/${id}/activities`)
    .then((res) => {
      return res.json();
    })
    .then((data) => {
      console.log(data);
      if (Array.isArray(data.activities)) {
        activities = data.activities;
      }
    })
    .catch((error) => {
      console.error(error);
    });
</script>
<ClubNavBar id = {id}/>
<DisplayCalendar {games} {activities}/>