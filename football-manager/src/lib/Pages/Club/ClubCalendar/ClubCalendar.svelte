<script>
    export let id
    import DisplayCalendar from "../../../Components/DisplayCalendar.svelte";
    import ClubNavBar from "../clubNavBar.svelte";
</script>
<ClubNavBar id = {id}/>
<DisplayCalendar/>