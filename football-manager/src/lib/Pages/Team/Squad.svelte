<script>
    import Person from "./Person.svelte";

    export let id;
    let players;
    let staff;

    const fetchPlayers = fetch(`http://localhost:8080/team/${id}/players`);
    const fetchStaff = fetch(`http://localhost:8080/team/${id}/staff`);

    fetchPlayers
        .then((res) => {
            return res.json();
        })
        .then((data) => {
            players = data;
            console.log(players);
        });

    // fetchStaff.then((res) => {
    //     return res.json();
    // }).then((data) => {
    //     staff = data;
    //     console.log(players);
    // });
</script>

<section class="animate-fade-in flex-col mt-10">
    {#if players}
        {#each players as player (player.id)}
            <Person {player} />
        {/each}
    {/if}
</section>
