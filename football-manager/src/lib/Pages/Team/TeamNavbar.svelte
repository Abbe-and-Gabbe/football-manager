<script>
  import NavButton from "../../Components/NavButton.svelte";
  export let id;
</script>

<div class="bg-slate-400 dark:bg-slate-800 w-full rounded-xl p-2 flex gap-2">
  <NavButton buttonText="Home" location="/team/{id}" {id} />
  <NavButton buttonText="Squad" location="/team/{id}/squad" {id} />
  <NavButton buttonText="Calendar" location="/team/{id}/calendar" {id} />
  <!-- Only visible to admins: -->
  <NavButton buttonText="Admin" location="/team/{id}/admin" {id} />
</div>
