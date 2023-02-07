<script>
    export let id;
    import teams from "../../../assets/data";
  import TeamNav from "./TeamNav.svelte";
    let team = teams.find((item) => item.id == id);

</script>

<TeamNav id="{id}" />
