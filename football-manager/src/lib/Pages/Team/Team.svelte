<script>
    export let id;
    import teams from "../../../assets/data";
    let team = teams.find((item) => item.id == id);

</script>

<h1>Hello {team.name}</h1>