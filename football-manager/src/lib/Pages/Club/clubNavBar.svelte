<script>
  import NavButton from "../../Components/NavButton.svelte";
  export let id;
</script>

<div class="bg-slate-400 dark:bg-slate-800 w-full rounded-xl p-2 flex gap-2">
  <NavButton buttonText="Home" location="/club/{id}" {id} />
  <NavButton buttonText="Teams" location="/club/{id}/teams" {id} />
  <NavButton buttonText="Calendar" location="/club/{id}/calendar" {id} />
  <NavButton buttonText="Contact" location="/club/{id}/contact" {id} />
  <!-- Only visible to admins: -->
  <NavButton buttonText="Admin" location="/team/{id}/admin" {id} />
</div>
