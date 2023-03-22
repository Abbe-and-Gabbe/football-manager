<script>
    import ClubNavBar from "../clubNavBar.svelte";
    import CardForContactPage from "./CardForContactPage.svelte";
  
    export let id;
    let contactPersons = [];
    const fetchContactStaff = fetch(`http://localhost:8080/club/${id}/contact`);

  
    fetchContactStaff
        .then((res) => {
            return res.json();
        })
        .then((data) => {
            contactPersons = data;
        });
  </script>
  
  <ClubNavBar id={id} />
  <div
    class="bg-slate-200 dark:bg-slate-800 flex justify-evenly flex-col rounded-xl animate-fade-in p-6 mt-10 lg:mx-44" 
>

    <section class="animate-fade-in flex-col mt-10">
        <div class="prose dark:prose-invert m-2">
            <h1>Staff</h1>
        </div>
        {#if contactPersons}
            {#each contactPersons as person (person.id)}
                <CardForContactPage {person} />
            {/each}
        {/if}
    </section>
</div>
  