<script>
    export let id;
    let person;

    const f = fetch(`http://localhost:8080/person/${id}`);
    f.then((res) => {
        return res.json();
    })
        .then((data) => {
            person = data;
            console.log(person);
        })
        .catch((error) => {
            console.error(error);
        });
</script>

<section class="animate-fade-in mt-10 flex items-center justify-center w-full">
    <div
        class="bg-slate-200 dark:bg-slate-800 p-12 rounded-xl lg:mx-44 mb-2 prose dark:prose-invert"
    >
        {#if person}
            <h1>{person.firstName} {person.lastName}</h1>
            <h2>Stats</h2>
            <table class="table-auto">
                <thead>
                    <th>Goals</th>
                    <th>Assists</th>
                    <th>Yellow Cards</th>
                    <th>Red Cards</th>
                    <th>Games Played</th>
                </thead>
                <tbody>
                    <tr>
                        <td>{person.stats.goals}</td>
                        <td>{person.stats.assists}</td>
                        <td>{person.stats.yellowCards}</td>
                        <td>{person.stats.redCards}</td>
                        <td>{person.stats.games || 0}</td>
                    </tr>
            </table>
        {/if}
    </div>
</section>
