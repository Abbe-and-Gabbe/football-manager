<script>
    export let player;
</script>

<div
    class="bg-slate-200 dark:bg-slate-800 flex justify-between flex-col p-6 px-44 lg:flex-row gap-2 rounded-xl items-center lg:mx-44 animate-fade-in mb-2 hover:bg-slate-300 dark:hover:bg-slate-700"
>
    <h1>{player.firstName} {player.lastName}</h1>

    <img src={player.image || "https://via.placeholder.com/100"} alt="" />
</div>
