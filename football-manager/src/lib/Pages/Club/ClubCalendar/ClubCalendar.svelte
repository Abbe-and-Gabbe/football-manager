<script>
    export let id
    let games = [];
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
        console.log(games)
      }
    })
    .catch((error) => {
      console.error(error);
    });

    

</script>
<ClubNavBar id = {id}/>
<DisplayCalendar {games}/>